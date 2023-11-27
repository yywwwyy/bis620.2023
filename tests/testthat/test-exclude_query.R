test_that("exclude_query works", {
  data(studies)
  testi = "achieve"
  ducktest = query_kwds(studies, testi, "brief_title", ignore_case = TRUE, match_all = TRUE) |>
    head(1000)
  #exclude_query(ducktest,"achieve", "brief_title")
  expect_snapshot(exclude_query(ducktest,"Rates, Pembrolizumab", "brief_title"))
})
