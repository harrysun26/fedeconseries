context("just testing fedeconseries functionality")

testthat::test_that("whether the function can connect and return values",{
  set.seed(1)
  res = get_fedeconseries("INDPRO")
  print(class(df_series))
  testthat::expect_equal(class(df_series),"try-error")
  testthat::expect_equal(class(df_series),"data.frame")
  testthat::expect_equal(class(df_series),"data.frame")

})
