#' Accessing FRED
#' This function can pull time series from the FRED database: \url{https://fred.stlouisfed.org}
#' @name get_econ_series
#'
#' @param series_id FRED times series ID, the unique id retrieved from fed database.
#' @param series_name Choose a name for the series column in output. Default: series_id.
#' @param observation_start Choose a name for the series column in output. Default: series_id.
#' @param observation_end Date of last observation in "yyyy-mm-dd" format. Default: Last observation available.
#'
#' @usage get_econ_series(series_id,
#' series_name = NULL,observation_start = NULL,
#'  observation_end = NULL)
#' @export get_econ_series
#'
#' @importFrom tibble as_tibble
#' @importFrom dplyr mutate_
#' @importFrom lubridate as_date
#' @importFrom magrittr %>%
#' @importFrom dplyr bind_rows
#' @importFrom tidyr gather_
#' @importFrom dplyr filter_
#' @importFrom dplyr mutate_if
#' @importFrom stats na.omit
#' @importFrom jsonlite fromJSON
#'
#' @examples get_econ_series("UNRATE", "unemploymentRate")
get_econ_series <- function(series_id, series_name = NULL,
                            observation_start = NULL, observation_end = NULL) {


  length_series_id <- nchar(series_id)

  if (is.character(series_id) == FALSE) {
    stop("series_id is always in characters")
  }

  if (is.null(series_name) == TRUE ) {
    series_name <- series_id
  }

  if (is.null(observation_start) == TRUE) {
    observation_start <- "1776-07-04"
  }

  if (is.null(observation_end) == TRUE) {
    observation_end <- "9999-12-31"
  }

  df_series <-
    try({
      fromJSON(
        paste0("https://api.stlouisfed.org/fred/series/observations?series_id=",
               series_id,
               "&observation_start=",
               observation_start,
               "&observation_end=",
               observation_end,
               "&output_type=2",
               "&api_key=ebee35f5fcd8a74392ca0a267d39b53d&file_type=json")
      )$observations %>%
        mutate_(date = ~as_date(date))
    }, silent = TRUE)

  if (class(df_series) == "try-error") {
    stop("Download of specified time-series failed - did you misspell the identifier?")
  }

  colnames(df_series)[!(colnames(df_series) %in% "date")] <- series_name
  df_series[, 2] <- as.numeric(unlist(df_series[, 2]))
  df_series
}
