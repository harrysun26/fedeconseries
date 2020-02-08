testthat::test_that("whether the function can connect and return values",{
  testthat::expect_equal(
    get_fedeconseries("INDPRO",
                      obs_start = "2013-03-01", obs_end = "2013-03-01",
                      real_start = "2015-02-02", real_end = "2015-02-02"),
    data.frame(
      date = as.Date("2013-03-01"),
      realtime_period  = as.Date("2015-02-02"),
      INDPRO = 99.488)
  )
  testthat::expect_equal(
    dplyr::filter(get_fedeconseries("INDPRO", "test",
                                    real_start = "2015-02-02", real_end = "2015-02-02"),
                  date == "2013-03-01"),
    data.frame(
      date = as.Date("2013-03-01"),
      realtime_period  = as.Date("2015-02-02"),
      test = 99.488)
  )
  testthat::expect_equal(
    dplyr::filter(get_fedeconseries("INDPRO", "test",
                                    obs_start = "2009-03-01", obs_end = "2009-03-01"),
                  realtime_period == "2015-02-18"),
    data.frame(
      date = as.Date("2009-03-01"),
      realtime_period = as.Date("2015-02-18"),
      test = 85.6157)
  )
  testthat::expect_error(
    get_fedeconseries(1231232, "test",
                    obs_start = "2009-03-01", obs_end = "2009-03-01")
  )
  testthat::expect_error(
    get_fedeconseries(1231232, "test",
                      obs_start = "2009-03-01", obs_end = "2009-03-01")
  )
})
