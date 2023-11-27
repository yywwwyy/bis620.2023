#' @title Create a histogram of the phases returned by a brief title keyword search
#' @param x the database table.
#' @importFrom dplyr summarize right_join group_by select n
#' @importFrom tidyr as_tibble
#' @importFrom ggplot2 ggplot aes geom_col theme_bw xlab ylab
#' @export
plot_phase_histogram = function(x) {
  # Fix the phase histogram so that the x-axis values
  # are uniform regardless of the query.
  x$phase[is.na(x$phase)] <- "NA"
  x <- x |>
    #select(-condition_name, -downcase_condition_name) |>
    select(nct_id, phase) |>
    group_by(phase) |>
    summarize(n = n())
  # select(nct_id, condition_name, downcase_condition_name)
  # complete phases that is not included in x
  complete_x <- as_tibble(x) |> right_join(phase_type)
  complete_x[2][is.na(complete_x[2])] <- 0  # set n to 0

  ggplot(complete_x, aes(x = phase, y = n)) +
    geom_col() +
    theme_bw() +
    xlab("Phase") +
    ylab("Count")
}
