test_that("calculate_duration works correctly", {
  # Test for days
  expect_equal(calculate_duration("2020-01-01", "2020-01-31", "days"), 30)
  # Test for months
  expect_equal(calculate_duration("2020-01-01", "2020-02-01", "months"), 1)
  # Test for years
  expect_equal(calculate_duration("2020-01-01", "2021-01-01", "years"), 1)
})


test_that("calculate_duration with studies dataset", {
  # Load the dataset
  data <- studies

  results <- calculate_duration(data$start_date[1], data$completion_date[1], "days")

  # Write expectations based on known values in your dataset
  expect_true(results > 0) # Example: Expecting a positive number of days
})
