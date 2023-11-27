test_that("plot_status_histogram() works", {
  data("studies")
  vdiffr::expect_doppelganger(
    'plot_status-1', studies |> head(100) |> plot_status_histogram()
  )
})
