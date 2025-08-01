#' @title Statistical Utilities for ResearchPak
#' @description Functions for retrieving dataset statistics
#' @import arrow
#' @importFrom lubridate now
#' @importFrom rlang abort

#' Get dataset statistics
#' @param dataset Dataset name or arrow table
#' @param log_operation Whether to log this operation (default TRUE)
#' @return A list with dataset statistics
#' @export
#' @examples
#' \dontrun{
#' stats <- dataset_stats("judicial_cases")
#' }
dataset_stats <- function(dataset, log_operation = TRUE) {
  # Handle input types
  if (is.character(dataset)) {
    arrow_table <- load_dataset(dataset, log_access = FALSE)
    dataset_label <- dataset
  } else if (inherits(dataset, "ArrowTabular") || inherits(dataset, "data.frame")) {
    arrow_table <- dataset
    dataset_label <- "provided_dataset"
  } else {
    abort("Input must be a dataset name, arrow table, or dataframe")
  }
  
  # Compute statistics
  n_obs <- nrow(arrow_table)
  n_cols <- ncol(arrow_table)
  col_names <- names(arrow_table)
  
  # Get column types
  if (inherits(arrow_table, "ArrowTabular")) {
    col_types <- sapply(arrow_table$schema$fields, function(f) f$type$name)
  } else {
    col_types <- sapply(arrow_table, class)
  }
  
  # Memory size estimation
  if (inherits(arrow_table, "ArrowTabular")) {
    size_bytes <- as.numeric(object.size(as.data.frame(head(arrow_table, 1000)))) * 
      (n_obs / 1000)
  } else {
    size_bytes <- as.numeric(object.size(arrow_table))
  }
  
  stats <- list(
    dataset_name = dataset_label,
    n_observations = n_obs,
    n_columns = n_cols,
    column_names = col_names,
    column_types = col_types,
    size_mb = round(size_bytes / 1024^2, 2),
    computed_at = now()
  )
  
  if (log_operation) {
    log_data_access(
      dataset = dataset_label,
      operation = "dataset_stats",
      rows = n_obs,
      columns = n_cols
    )
  }
  
  class(stats) <- c("dataset_stats", "list")
  stats
}

#' Print method for dataset_stats
#' @param x dataset_stats object
#' @param ... Additional arguments
#' @export
print.dataset_stats <- function(x, ...) {
  cat("Dataset Statistics\n")
  cat("==================\n")
  cat("Dataset:", x$dataset_name, "\n")
  cat("Observations:", format(x$n_observations, big.mark = "."), "\n")
  cat("Columns:", x$n_columns, "\n")
  cat("Estimated size:", x$size_mb, "MB\n")
  cat("Computed at:", format(x$computed_at, "%Y-%m-%d %H:%M:%S"), "\n\n")
  
  cat("Column Information:\n")
  for (i in seq_along(x$column_names)) {
    cat(sprintf("  %s: %s\n", x$column_names[i], x$column_types[i]))
  }
  
  invisible(x)
}

#' Get last update time for a dataset
#' @param dataset_name Name of the dataset
#' @return POSIXct timestamp of last modification
#' @export
dataset_last_updated <- function(dataset_name) {
  datasets <- list_datasets()
  dataset_info <- datasets[datasets$name == dataset_name, ]
  
  if (nrow(dataset_info) == 0) {
    abort(paste0("Dataset '", dataset_name, "' not found"))
  }
  
  dataset_info$modified
}