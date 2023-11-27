test_that("plot_map() works", {
  data("studies")
  vdiffr::expect_doppelganger(
    'plot_map-1', studies |> head(100) |> plot_map()
  )
})
