#' @title Filter the status returned after applying the filter
#' @param x the database table.
#' @param ls_status the list of included status to look for.
#' @importFrom dplyr filter
#' @export
filter_status = function(x, ls_status) {
  # Fix the phase histogram so that the x-axis values
  # are uniform regardless of the query.
  #x_df = x |> collect()
  #replace(x$phase, is.na(x_df$phase), 'Unknown')
  x = x |>
    filter(overall_status %in% !!ls_status)
  #x$phase[x$phase == "NA"] = NA
  return(x)
}
