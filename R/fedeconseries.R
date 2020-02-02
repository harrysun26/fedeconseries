#' US federal reserve economic data series accessing
#' This wrapper function is to access data from  \url{https://alfred.stlouisfed.org}.
#'
#' @name get_fedeconseries  wrapper function name.
#'
#' @param s_id econimic variable names provided by ALFRED, unique identifier.
#' @param s_name Output column name, default is s_id.
#' @param obs_start Date of first observation in "yyyy-mm-dd" format. Default: Earliest observation available.
#' @param obs_end Date of last observation in "yyyy-mm-dd" format. Default: Last observation available.
#' @param real_start Date of first real time period in "yyyy-mm-dd" format. Default: First vintage date available.
#' @param real_end Date of last real time period in "yyyy-mm-dd" format. Default: Last vintage date available.
#'
#' @details fromJSON return: (1) $observations(4 cols: realtime_start, realtime_end, date, value); (2)other attrs: $realtime_start, $realtime_end, $observation_start, $observation_end, $units, $output_type, $file_type, $order_by, $sort_order, $count, $offset, $limit
#'
#' @keywords alfred; US federal reserve
#' @export get_fedeconseries
#'
#' @usage get_fedeconseries(s_id, s_name = NULL,obs_start = NULL, obs_end = NULL,real_start = NULL, real_end = NULL)
#'
#'
#' @importFrom tibble as_tibble
#' @importFrom tidyr gather_
#' @importFrom dplyr mutate_
#' @importFrom dplyr filter_
#' @importFrom dplyr mutate_if
#' @importFrom lubridate as_date
#' @importFrom magrittr %>%
#' @importFrom dplyr bind_rows
#' @importFrom stats na.omit
#' @importFrom jsonlite fromJSON
#'
#' @examples \dontrun{
#'     get_fedeconseries("INDPRO", "indpro")
#'     }
#'
#' @examples get_fedeconseries("INDPRO", "indpro", real_start = "2010-01-01", real_end = "2015-12-31")

get_fedeconseries <-
  function(s_id, s_name = NULL,
           obs_start = NULL, obs_end = NULL,
           real_start = NULL, real_end = NULL) {

    if (is.character(s_id) == FALSE) {
      stop("wrong type of series identifier!")
    }

    length_s_id <- nchar(s_id)


    if (is.null(s_name) == TRUE ) {
      s_name <- s_id

    }

    if (is.null(real_start)  == TRUE) {
      real_start <- "1776-07-04"

    }

    if (is.null(real_end) == TRUE) {
      real_end <- "9999-12-31"

    }

    if (is.null(obs_start) == TRUE) {
      obs_start <- "1776-07-04"

    }

    if (is.null(obs_end) == TRUE) {
      obs_end <- "9999-12-31"
    }

    link=paste0("https://api.stlouisfed.org/fred/series/observations?series_id=",
                s_id,
                "&realtime_start=",
                real_start,
                "&realtime_end=",
                real_end,
                "&output_type=2&observation_start=",
                obs_start,
                "&observation_end=",
                obs_end,
                "&api_key=98f9f5cad7212e246dc5955e9b744b24&file_type=json")

    df_series <-
      try({
        df_series <-
          fromJSON(link)$observations

        df_series %>%
          mutate_(date = ~as_date(df_series[["date"]])) %>%
          gather_("realtime_period", "name", setdiff(names(df_series), "date")) %>%
          na.omit() %>%
          mutate_(realtime_period =
                    ~paste(substr(realtime_period, start = length_s_id + 2, stop = length_s_id + 5),
                           substr(realtime_period, start = length_s_id + 6, stop = length_s_id + 7),
                           substr(realtime_period, start = length_s_id + 8, stop = length_s_id + 9),
                           sep = "-")) %>%
          mutate_(realtime_period = ~as_date(realtime_period),
                  date = ~as_date(date),
                  name = ~as.numeric(name)) %>%
          dplyr::filter_(.dots = paste0("realtime_period", "!= ", "2099-12-31"))
      }, silent = TRUE)

    if (class(df_series) == "try-error") {
      stop("Download of specified time-series failed - check identifier, R version, or Internet connection!")
    }

    colnames(df_series)[!colnames(df_series) %in% c("date", "realtime_period")] <- s_name

    df_series
  }
