testthat::test_that("whether the function can connect and return values",{

  testthat::expect_error(
    get_fred_series2(1231232, "test",
                      obs_start = "2009-03-01", obs_end = "2009-03-01")
  )


})
