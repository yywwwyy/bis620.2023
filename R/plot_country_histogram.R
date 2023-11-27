#' @title Histogram of number of the first 5 countries that trials in a query are examining.
#' @description The function gives a histogram showing the countries that trials in a query are examining.
#' @param d the database table.
#' @importFrom dplyr summarize group_by select arrange n desc
#' @importFrom ggplot2 ggplot aes geom_col theme_bw xlab ylab coord_flip
#' @importFrom utils head
#' @export
plot_country_histogram = function(d) {
  d$country[is.na(d$country)] = "NA"
  d <- d |>
    select(country) |>
    group_by(country) |>
    summarize(n = n()) |>
    arrange(desc(n)) |>
    head(5)

  ggplot(d, aes(x = reorder(country, n), y = n)) +
    geom_col() +
    theme_bw() +
    xlab("Countries") +
    ylab("Count")+
    coord_flip()
}
