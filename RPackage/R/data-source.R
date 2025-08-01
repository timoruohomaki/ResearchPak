#' @title Data Source Management for ResearchPak
#' @description Functions for managing parquet data sources
#' @import arrow
#' @import fs
#' @importFrom rlang abort inform

#' Get the datasets directory path
#' @return Character string with the path to datasets
#' @keywords internal
get_datasets_path <- function() {
  system.file("extdata", "datasets", package = "ResearchPak")
}

#' List available parquet datasets
#' @return A tibble with dataset information
#' @export
#' @examples
#' list_datasets()
list_datasets <- function() {
  datasets_path <- get_datasets_path()
  
  if (!dir_exists(datasets_path)) {
    abort("Datasets directory not found")
  }
  
  parquet_files <- dir_ls(datasets_path, regexp = "\\.parquet$", recurse = TRUE)
  
  if (length(parquet_files) == 0) {
    inform("No parquet files found in datasets directory")
    return(tibble::tibble(
      name = character(),
      path = character(),
      size_mb = numeric(),
      modified = as.POSIXct(character())
    ))
  }
  
  file_info <- file_info(parquet_files)
  
  tibble::tibble(
    name = path_ext_remove(path_file(parquet_files)),
    path = parquet_files,
    size_mb = round(file_info$size / 1024^2, 2),
    modified = file_info$modification_time
  )
}

#' Load a parquet dataset
#' @param dataset_name Name of the dataset (without .parquet extension)
#' @param log_access Whether to log this data access (default TRUE)
#' @return Arrow Table object
#' @export
#' @examples
#' \dontrun{
#' data <- load_dataset("judicial_cases")
#' }
load_dataset <- function(dataset_name, log_access = TRUE) {
  if (missing(dataset_name) || is.null(dataset_name) || dataset_name == "") {
    abort("Dataset name is required")
  }
  
  datasets <- list_datasets()
  
  if (nrow(datasets) == 0) {
    abort("No datasets available")
  }
  
  dataset_row <- datasets[datasets$name == dataset_name, ]
  
  if (nrow(dataset_row) == 0) {
    abort(paste0("Dataset '", dataset_name, "' not found. ",
                 "Available datasets: ", 
                 paste(datasets$name, collapse = ", ")))
  }
  
  tryCatch({
    arrow_table <- read_parquet(dataset_row$path)
    
    if (log_access) {
      log_data_access(
        dataset = dataset_name,
        operation = "load_dataset",
        rows = nrow(arrow_table),
        columns = ncol(arrow_table)
      )
    }
    
    arrow_table
  }, error = function(e) {
    abort(paste0("Failed to load dataset: ", e$message))
  })
}