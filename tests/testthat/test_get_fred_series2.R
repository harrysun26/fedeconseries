testthat::test_that("whether the function can connect and return values",{

  testthat::expect_error(
    get_fred_series2(1231232, "test",
                      obs_start = "2009-03-01", obs_end = "2009-03-01")
  )

  testthat::expect_equal(
    dplyr::filter(get_fred_series2("INDPRO", "test",
                                    observation_start = "2012-02-02", observation_end = "2014-02-02"),
                  date == "2013-03-01"),
    data.frame(
      date = as.Date("2013-03-01"),
      test = 101.8114)
  )

})
