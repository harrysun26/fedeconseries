
#' printer dunction
#'
#'
#' @param r the second column
#' @param x the first column
#'
#'
#' @return a tibble
#' @export
#'
#' @importFrom tibble data_frame
#' @importFrom utils head
#'
#' @examples
#' printer(x=rnorm(5), r=rnorm(5))
printer <- function(r,x){
  x = data_frame(x=x,r=r)
  print(head(x))
  # print(paste0("x=",x))
  return(x)
}
