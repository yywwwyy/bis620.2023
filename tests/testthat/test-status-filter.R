test_that("silter_status() works", {
  data(studies)
  expect_snapshot(studies |> head() |> filter_status(c('Completed')))
})
