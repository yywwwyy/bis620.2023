library(ggplot2)
library(dplyr)

test_that("processed_data_test plots correctly", {
  studies_test <- studies |>
    left_join(outcomes, by = "nct_id", suffix = c("_outcomes", "_studies"), relationship = "many-to-many") |>
    left_join(interventions, by = "nct_id", suffix = c("_interventions", "_studies"), relationship = "many-to-many")
  processed_data_test <- process_intervention_outcomes(studies_test)

  plot <- ggplot(processed_data_test, aes(x = reorder(intervention_type, -count), y = count, fill = outcome_type)) +
    geom_bar(stat = "identity", position = position_dodge()) +
    theme_minimal() +
    labs(title = "Count of Outcomes by Intervention Type",
         x = "Intervention Type",
         y = "Count of Outcomes")

  vdiffr::expect_doppelganger("Plot of Outcomes by Intervention Type", plot)
})
