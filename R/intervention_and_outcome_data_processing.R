#' @title process intervention and outcome data for plotting
#' @description This function can aggregate study data and group by outcome_type and intervention_type.
#' @param get_studies_db database
#' @importFrom dplyr group_by summarise arrange desc
#' @export
process_intervention_outcomes <- function(get_studies_db) {
  # Assuming studies_data already includes outcomes and interventions
  # Aggregate and arrange data for plotting
  get_studies_db$intervention_type[is.na(get_studies_db$intervention_type)] = "NA"
  get_studies_db$outcome_type[is.na(get_studies_db$outcome_type)] = "NA"
  aggregated_data <- get_studies_db |>
    group_by(intervention_type, outcome_type) |>
    summarise(count = n(), .groups = 'drop') |>
    arrange(desc(count))

  return(aggregated_data)
}
