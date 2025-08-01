#' @title Audit Logging for ResearchPak
#' @description Comprehensive logging of all data access operations
#' @import logger
#' @importFrom glue glue
#' @importFrom lubridate now

# Package-level logger configuration
.onLoad <- function(libname, pkgname) {
  # Set up logger
  log_dir <- get_log_directory()
  if (!dir.exists(log_dir)) {
    dir.create(log_dir, recursive = TRUE)
  }
  
  # Configure logger
  log_appender(appender_tee(
    appender_file(file.path(log_dir, "researchpak_audit.log"))
  ))
  
  log_threshold(INFO)
  log_layout(layout_json_parser())
}

#' Get log directory path
#' @return Character string with log directory path
#' @keywords internal
get_log_directory <- function() {
  log_dir <- Sys.getenv("RESEARCHPAK_LOG_DIR")
  if (log_dir == "") {
    log_dir <- file.path(tempdir(), "researchpak_logs")
  }
  log_dir
}

#' Log data access operation
#' @param dataset Dataset name
#' @param operation Type of operation performed
#' @param rows Number of rows accessed
#' @param columns Number of columns accessed
#' @param ... Additional logging parameters
#' @keywords internal
log_data_access <- function(dataset, operation, rows = NA, columns = NA, ...) {
  log_info(
    "Data access logged",
    dataset = dataset,
    operation = operation,
    rows = rows,
    columns = columns,
    user = Sys.getenv("USER", "unknown"),
    session_id = get_session_id(),
    timestamp = format(now(), "%Y-%m-%d %H:%M:%S %Z"),
    ...
  )
}

#' Get or create session ID
#' @return Character string with session ID
#' @keywords internal
get_session_id <- function() {
  session_id <- getOption("researchpak.session_id")
  if (is.null(session_id)) {
    session_id <- paste0(
      format(now(), "%Y%m%d%H%M%S"),
      "_",
      sample(letters, 6, replace = TRUE) |> paste(collapse = "")
    )
    options(researchpak.session_id = session_id)
  }
  session_id
}

#' View audit log
#' @param last_n Number of recent entries to show (default 20)
#' @param dataset Filter by dataset name (optional)
#' @param operation Filter by operation type (optional)
#' @return Tibble with log entries
#' @export
#' @examples
#' \dontrun{
#' view_audit_log()
#' view_audit_log(dataset = "judicial_cases")
#' }
view_audit_log <- function(last_n = 20, dataset = NULL, operation = NULL) {
  log_file <- file.path(get_log_directory(), "researchpak_audit.log")
  
  if (!file.exists(log_file)) {
    inform("No audit log found")
    return(tibble::tibble())
  }
  
  # Read log file
  log_lines <- readLines(log_file)
  
  # Parse JSON logs
  logs <- lapply(log_lines, function(line) {
    tryCatch({
      jsonlite::fromJSON(line)
    }, error = function(e) NULL)
  })
  
  # Remove NULL entries
  logs <- logs[!sapply(logs, is.null)]
  
  if (length(logs) == 0) {
    return(tibble::tibble())
  }
  
  # Convert to tibble
  log_df <- dplyr::bind_rows(logs)
  
  # Apply filters
  if (!is.null(dataset)) {
    log_df <- log_df[log_df$dataset == dataset, ]
  }
  
  if (!is.null(operation)) {
    log_df <- log_df[log_df$operation == operation, ]
  }
  
  # Return last n entries
  tail(log_df, last_n)
}