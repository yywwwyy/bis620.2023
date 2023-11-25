#' @title Histogram of number of the first 25 conditions that trials in a query are examining.
#' @description The function gives a histogram showing the conditions that trials in a query are examining.
#' @param d the database table.
#' @importFrom dplyr summarize group_by select arrange
#' @importFrom ggplot2 ggplot aes geom_col xlab ylab coord_flip
plot_condition_histogram = function(d) {
  d$condition_name[is.na(d$condition_name)] = "NA"
  d <- d |>
    select(condition_name) |>
    group_by(condition_name) |>
    summarize(n = n()) |>
    arrange(desc(n)) |>
    head(25)
  # reorder()
  ggplot(d, aes(x = reorder(condition_name, n), y = n)) +
    geom_col() +
    theme_bw() +
    xlab("Conditions") +
    ylab("Count")+
    coord_flip()
}
