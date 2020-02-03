testthat::test_that("whether the function can connect and return values",{

  testthat::expect_error(
    search_fedeconseries(123)
  )

  testthat::expect_equal(
    as.character(dplyr::filter(search_fedeconseries("Industrial+Production+Index"),
                  title == "Industrial Production Index")['id']),
    'INDPRO'
  )

})

