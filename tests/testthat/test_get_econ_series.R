testthat::test_that("whether the function can connect and return values",{

  testthat::expect_error(
    get_econ_series(1231232)
  )

  testthat::expect_equal(
    dplyr::filter(get_econ_series("INDPRO", "test",
                                    observation_start = "2012-02-02", observation_end = "2014-02-02"),
                  date == "2013-03-01"),
    data.frame(
      date = as.Date("2013-03-01"),
      test = 101.8114)
  )

  testthat::expect_equal(
    dplyr::filter(get_econ_series("INDPRO"),
                  date == "2013-03-01"),
    data.frame(
      date = as.Date("2013-03-01"),
      INDPRO = 101.8114)
  )

})
