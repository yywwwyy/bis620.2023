test_that("showinfo works", {
  data(studies)
  data(eligibilities)
  ni = "NCT04538079" |>
    trimws()
  nct_table <- studies |>
    filter(nct_id == !!ni)
  single_study_for_info <- nct_table |>
    head(1000) |>
    collect()
  single_study_for_info = single_study_for_info |>
    select(nct_id, brief_title,phase, start_date, completion_date, country, source_class) |>
    distinct() |>
    collect() |>
    head(1)
  eli_table = eligibilities |>
    filter(nct_id == !!ni)|>
    distinct()
  single_study_for_elig <- eli_table |>
    collect()|>
    head(1)
  true_result="\n  <div class=\"container\">\n  <h3>Information</h3>\n  <table id=\"infoTB\">\n    <tr>\n      <th>Feature</th>\n      <th>Value</th>\n    </tr>\n    <tr>\n      <td>NCT ID</td>\n      <td>NCT04538079</td>\n    </tr>\n    <tr>\n      <td>Phase</td>\n      <td>NA</td>\n    </tr>\n    <tr>\n      <td>Country</td>\n      <td>Ireland</td>\n    </tr>\n    <tr>\n      <td>Start Date</td>\n      <td>2019-11-09</td>\n    </tr>\n    <tr>\n      <td>End Date</td>\n      <td>2021-05-31</td>\n    </tr>\n  </table>\n  <br />\n    <div class=\"box\">\n        <div class=\"title-box\">\n            <h5>Sampling Method:</h5>\n        </div>\n        <div class=\"content-box\">\n          Non-Probability Sample\n        </div>\n    </div>\n    <div class=\"box\">\n        <div class=\"title-box\">\n            <h5>Gender:</h5>\n        </div>\n        <div class=\"content-box\">\n          All\n        </div>\n    </div>\n    <div class=\"box\">\n        <div class=\"title-box\">\n            <h5>Minimum Age:</h5>\n        </div>\n        <div class=\"content-box\">\n          1 Minute\n        </div>\n    </div>\n    <div class=\"box\">\n        <div class=\"title-box\">\n            <h5>Maximum Age:</h5>\n        </div>\n        <div class=\"content-box\">\n          20 Hours\n        </div>\n    </div>\n    <div class=\"box\">\n        <div class=\"title-box\">\n            <h5>Population:</h5>\n        </div>\n        <div class=\"content-box\">\n          Preterm Neonates born at a gestational age of 23 weeks 0 days to 31 weeks 6 days.\n        </div>\n    </div>\n  </div>\n  <br />\n  <br />\n  "
  expect_equal(show_info(single_study_for_info, single_study_for_elig), true_result)
})

