#' @title Create a histogram of the status of the study returned by a brief title keyword search
#' @param x the database table.
#' @importFrom dplyr select group_by summarize n
#' @importFrom ggplot2 ggplot aes geom_col theme_bw xlab ylab coord_flip
#' @export
plot_status_histogram = function(x) {
  # plot the status
  #x$phase[is.na(x$phase)] = "NA"
  x = x |>
    #select(-condition_name, -downcase_condition_name) |>
    unique() |>
    select(overall_status) |>
    group_by(overall_status) |>
    summarize(n = n())
  # select(nct_id, condition_name, downcase_condition_name)
  # complete phases that is not included in x
  #complete_x = as_tibble(x) |> right_join(phase_type)
  #complete_x[2][is.na(complete_x[2])] = 0  # set n to 0

  ggplot(x, aes(x = overall_status, y = n)) +
    geom_col() +
    theme_bw() +
    xlab("Status") +
    ylab("Count") +
    coord_flip()
}
