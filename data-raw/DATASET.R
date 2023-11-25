## code to prepare `DATASET` dataset goes here

accel = readRDS("accel.rds")
usethis::use_data(accel, overwrite = TRUE)

# con = duckdb::dbConnect(
#   duckdb(
#     file.path("ctgov.duckdb"),
#     read_only = TRUE
#   )
# )
# studies = dplyr::tbl(con, "studies")
# sponsors = dplyr::tbl(con, "sponsors")
# outcomes = dplyr::tbl(con, "outcomes")
# interventions = dplyr::tbl(con, "interventions")
#
# reported_events = dplyr::tbl(con, "reported_events") |>
#   select(nct_id, result_group_id, ctgov_group_code,time_frame, event_type, subjects_affected,
#          subjects_at_risk, adverse_event_term, organ_system)
#
# brief_summaries = dplyr::tbl(con, "brief_summaries")|>
#   select(-id) |>
#   dplyr::rename(long_description = description)|>
#   tidyr::replace_na(list(long_description = "NA"))
#
# designs = dplyr::tbl(con, 'designs') |> select(-id)
#
# eligibilities = dplyr::tbl(con, 'eligibilities')|>
#   select(-healthy_volunteers, -gender_description, -gender_based) |>
#   tidyr::replace_na(list(sampling_method = "N/A",
#                   gender = "N/A",
#                   minimum_age = "N/A",
#                   maximum_age = "N/A",
#                   population = "N/A",
#                   criteria = "N/A"
#   ))
#
#
#
# # get conditions data for each trials
# conditions = dplyr::tbl(con, "conditions") |>
#   dplyr::rename(condition_name = name, downcase_condition_name = downcase_name) |>
#   select(nct_id, condition_name, downcase_condition_name)
#
# countries = dplyr::tbl(con, "countries") |>
#   select(nct_id,name) |>
#   dplyr::rename(country = name)
# #dplyr::distinct(nct_id, .keep_all = TRUE)
#
#
# country_list = countries |>
#   select(country) |>
#   dplyr::distinct() |>
#   tidyr::replace_na(list(country = "NA")) |>
#   dplyr::arrange(country) |>
#   dplyr::collect()
#
#
# # merged countries and conditions together in studies
# studies = studies |>
#   dplyr::left_join(countries, by = 'nct_id')
# studies = studies |>
#   dplyr::left_join(conditions, by = 'nct_id')
#
# # get all phases-type in studies a list with
# # and change NA type to 'NA' type
# phases_type = studies |>
#   select(phase) |>
#   dplyr::distinct() |>
#   dplyr::collect()
# phases_type[1][is.na(phases_type[[1]]), ] = "NA"
# phase_type = phases_type[1]
#
#
#
# usethis::use_data(studies, overwrite = TRUE)
# usethis::use_data(sponsors, overwrite = TRUE)
# usethis::use_data(outcomes, overwrite = TRUE)
# usethis::use_data(interventions, overwrite = TRUE)
# usethis::use_data(reported_events, overwrite = TRUE)
# usethis::use_data(brief_summaries, overwrite = TRUE)
# usethis::use_data(designs, overwrite = TRUE)
# usethis::use_data(eligibilities, overwrite = TRUE)
# usethis::use_data(conditions, overwrite = TRUE)
# usethis::use_data(countries, overwrite = TRUE)
# usethis::use_data(country_list, overwrite = TRUE)
# usethis::use_data(phase_type, overwrite = TRUE)
# duckdb::dbDisconnect(con)

