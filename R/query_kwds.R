#' @title Query keywords from a database table.
#' @description The function would returns data that contains
#'              keywords in specified column.
#' @param d the database table.
#' @param kwds the keywords to look for.
#' @param column the column to look for the keywords in.
#' @param ignore_case should the case be ignored when searching for a keyword?
#' (default TRUE)
#' @param match_all should we look for values that match all of the keywords
#' (intersection) or any of the keywords (union)? (default FALSE; union).
#' @importFrom dplyr filter sym
#' @importFrom stringr str_detect regex
#' @export
query_kwds<- function(d, kwds, column, ignore_case = TRUE, match_all = FALSE) {
  # Define the filter condition based on match_all
  if (match_all) {
    result <- d |>
      filter(Reduce(`&`, lapply(kwds, function(s) str_detect(!!sym(column), regex(s, ignore_case = ignore_case)))))
  } else {
    #query <- paste0(keywords, collapse = "|")
    result <- d |>
      filter(Reduce(`|`, lapply(kwds, function(s) str_detect(!!sym(column), regex(s, ignore_case = ignore_case)))))
  }
  # Return the result
  return(result)
}



# query_kwds <- function(d, kwds, column, ignore_case = TRUE, match_all = FALSE) {
#   kwds <- kwds[kwds != ""]
#   kwds <- paste0("%", kwds, "%") |>
#     gsub("'", "''", x = _)
#   if (ignore_case) {
#     like <- " ilike "
#   } else{
#     like <- " like "
#   }
#   query <- paste(
#     paste0(column, like, "'", kwds, "'"),
#     collapse = ifelse(match_all, " AND ", " OR ")
#   )
#   filter(d, sql(query))
# }


