context("just testing printer functionality")

test_that("whether printer gives the same output",{
  set.seed(1)
  res = printer(x=rnorm(5), r=rnorm(5))
  expect_equal(nrow(res),5)




})
