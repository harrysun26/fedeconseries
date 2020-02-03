#' @title Search series_id by key words
#' @author Weiwei Liu
#' @description
#' Get US federal reserve economic data series that match keywords
#' This wrapper function is to access data from  \url{https://alfred.stlouisfed.org}
#'
#' @name search_fedeconseries
#'
#' @param search_text The words to match against economic data series.
#' @param search_type Determines the type of search to perform.
#'              One of the following strings: 'full_text', 'series_id'.
#' @param realtime_start Date of first real time period in "yyyy-mm-dd" format..
#' @param realtime_end Date of last real time period in "yyyy-mm-dd" format.
#' @note  More arguments could be added into function, for additional arguments, check
#'                  \url{https://research.stlouisfed.org/docs/api/fred/series_search.html}
#' @return dataframe
#' @export search_fedeconseries
#' @importFrom jsonlite fromJSON
#' @usage search_fedeconseries(search_text, search_type = 'full_text',
#'                             realtime_start = NULL, realtime_end = NULL)
#'
#' @examples
#' search_fedeconseries('GDP', search_type = 'full_text',realtime_start = NULL, realtime_end = NULL)
#'
search_fedeconseries <-
  function(search_text, search_type = 'full_text',
           realtime_start = NULL, realtime_end = NULL) {

    if (is.character(search_text) == FALSE) {
      stop("search_text is always in characters")
    }

    if (is.null(realtime_start)  == TRUE) {
      realtime_start <- Sys.Date()
    }

    if (is.null(realtime_end) == TRUE) {
      realtime_end <- Sys.Date()
    }

    df_series <-
      try({
        df_series <-
          fromJSON(
            paste0("https://api.stlouisfed.org/fred/series/search?search_text=",
                   search_text,
                   "&realtime_start=",
                   realtime_start,
                   "&realtime_end=",
                   realtime_end,
                   "&output_type=2",
                   "&api_key=ebee35f5fcd8a74392ca0a267d39b53d&file_type=json")
          )$seriess})

    if (class(df_series) == "try-error") {
      stop("Fail to fetch search results, please check if parameters are right?")
    }

    df_series
  }
