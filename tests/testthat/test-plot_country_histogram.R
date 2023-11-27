test_that("multiplication works", {
  data(studies)
  example = studies |> head(1000)
  vdiffr::expect_doppelganger(
    "plot-country-1",
    example |> head(100) |> plot_country_histogram()
  )
})
