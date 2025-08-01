#' @title DataFrame Abstraction Layer
#' @description Convert arrow tables to R dataframes with logging
#' @import arrow
#' @import dplyr
#' @importFrom rlang abort

#' Convert dataset to dataframe
#' @param dataset_name Name of the dataset or arrow table object
#' @param collect Whether to collect into memory (default TRUE)
#' @param filter_expr Optional dplyr filter expression
#' @param select_cols Optional column selection
#' @param log_operation Whether to log this operation (default TRUE)
#' @return A tibble dataframe
#' @export
#' @examples
#' \dontrun{
#' df <- as_dataframe("judicial_cases")
#' df_filtered <- as_dataframe("judicial_cases", 
#'                            filter_expr = quote(year > 2020))
#' }
as_dataframe <- function(dataset_name, 
                         collect = TRUE, 
                         filter_expr = NULL,
                         select_cols = NULL,
                         log_operation = TRUE) {
  
  # Handle both string names and arrow table objects
  if (is.character(dataset_name)) {
    arrow_table <- load_dataset(dataset_name, log_access = FALSE)
    dataset_label <- dataset_name
  } else if (inherits(dataset_name, "ArrowTabular")) {
    arrow_table <- dataset_name
    dataset_label <- "arrow_table"
  } else {
    abort("Input must be a dataset name or arrow table")
  }
  
  # Start with arrow table
  result <- arrow_table
  
  # Apply column selection if provided
  if (!is.null(select_cols)) {
    tryCatch({
      result <- result |> select(all_of(select_cols))
    }, error = function(e) {
      abort(paste0("Column selection failed: ", e$message))
    })
  }
  
  # Apply filter if provided
  if (!is.null(filter_expr)) {
    tryCatch({
      result <- result |> filter(!!filter_expr)
    }, error = function(e) {
      abort(paste0("Filter application failed: ", e$message))
    })
  }
  
  # Collect if requested
  if (collect) {
    result <- collect(result)
  }
  
  # Log the operation
  if (log_operation) {
    log_data_access(
      dataset = dataset_label,
      operation = "as_dataframe",
      rows = nrow(result),
      columns = ncol(result),
      filter_applied = !is.null(filter_expr),
      columns_selected = !is.null(select_cols)
    )
  }
  
  result
}

#' Create a lazy evaluation dataset
#' @param dataset_name Name of the dataset
#' @return Arrow Dataset object for lazy evaluation
#' @export
#' @examples
#' \dontrun{
#' lazy_df <- lazy_dataset("judicial_cases")
#' result <- lazy_df |> 
#'   filter(year > 2020) |> 
#'   select(case_id, year) |> 
#'   collect()
#' }
lazy_dataset <- function(dataset_name) {
  arrow_table <- load_dataset(dataset_name, log_access = TRUE)
  
  # Return as arrow table for lazy evaluation
  arrow_table
}