#' @title Query from a database table with rows excluded based on keywords.
#' @description The function returns data that exclude rows with some keywords in a specified column.
#' @param d the database table.
#' @param ex_kwds the keywords want to be excluded.
#' @param column the column to look for the keywords in.
#' @importFrom dplyr anti_join
#' @export
exclude_query <- function(d, ex_kwds, column){
  ex <- ex_kwds |>
    strsplit(",") |>
    unlist() |>
    trimws()
  ex_ret <- query_kwds(d, ex, column, match_all = FALSE)
  anti_join(d,ex_ret, by="nct_id")
}
