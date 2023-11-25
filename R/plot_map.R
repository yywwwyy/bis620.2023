#' @title Create a world map of study density using the studies dataframe that returned after
#' filtered by the user
#' @param x the dataset to get the number of trails performed in each countries.
#' @importFrom dplyr select group_by filter summarize arrange collect
#' @importFrom ggplot2 ggplot aes geom_polygon map_data
plot_map = function(x) {
  x = x |>
    select(nct_id, country) |>
    distinct() |>
    select(country) |>
    group_by(country) |>
    summarize(n = n()) |>
    collect() |>
    filter(!is.na(country))

  #x[x$n > 10000, ]$n = 10000
  x[x$country == 'United States', ]$country = 'USA'
  x[x$country == 'Russian Federation', ]$country = 'Russia'
  x[x$country == 'Korea, Republic of', ]$country = 'South Korea'
  x[x$country == 'Korea, Democratic People\'s Republic of', ]$country = 'North Korea'
  x[x$country == 'United Kingdom', ]$country = 'UK'
  x[x$country == 'Moldova, Republic of', ]$country = 'Moldova'
  x[x$country == 'Iran, Islamic Republic of', ]$country = 'Iran'
  x[x$country == 'Syrian Arab Republic', ]$country = 'Syria'
  x[x$country == 'Libyan Arab Jamahiriya', ]$country = 'Libya'
  #x[x$country == 'Côte D\'Ivoire', ]$country = 'Ivory Coast'
  x[x$country == 'Congo', ]$country = 'Democratic Republic of the Congo'
  #congo = data.frame(country = 'Republic of Congo', n = x[x$country == 'Democratic Republic of the Congo', ]$n)
  #x <- x |>
  #rows_insert(congo)

  world <- map_data("world")

  world |>
    merge(x, by.x = "region", by.y = "country", all.x = T) |>
    arrange(group, order) |>
    ggplot(aes(x = long, y = lat, group = group, fill = n)) + geom_polygon()
}
