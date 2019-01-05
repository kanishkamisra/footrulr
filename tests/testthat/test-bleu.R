context("test-bleu")

test_that("bleu works", {
  expect_equal(bleu("the", "the", 1), 1)
  expect_equal(bleu("the cat the cat on the mat", c("the cat is on the mat", "there is a cat on the mat"), n = 2), 4/6)
})
