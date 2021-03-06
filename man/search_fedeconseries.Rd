% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/search.R
\name{search_fedeconseries}
\alias{search_fedeconseries}
\title{Search series_id by key words}
\usage{
search_fedeconseries(search_text, search_type = 'full_text',
                            realtime_start = NULL, realtime_end = NULL)
}
\arguments{
\item{search_text}{The words to match economic data series; key words.}

\item{search_type}{Determines the type of search to perform.
One of the following strings: 'full_text', 'series_id'.}

\item{realtime_start}{Date of first real time period in "yyyy-mm-dd" format, default: today's date.}

\item{realtime_end}{Date of last real time period in "yyyy-mm-dd" format, default: today's date.}
}
\value{
return dataframe of variables ids.
}
\description{
Get US federal reserve economic data series that match keywords
This wrapper function is to access data from  \url{https://alfred.stlouisfed.org}
}
\note{
More arguments could be added into function, for additional arguments, check
                 \url{https://research.stlouisfed.org/docs/api/fred/series_search.html}
}
\examples{
search_fedeconseries('GDP', search_type = 'full_text',realtime_start = NULL, realtime_end = NULL)

}
