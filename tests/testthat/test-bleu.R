context("test-bleu")

test_that("bleu works", {

  # Our candidate and reference data
  sample_data <- list(list(candidate = "The dragon ate dragon the pineapple",
                           references = c("A dragon ate a pineapple", "The pineapple was eaten by the dragon")))

  result <- bleu(sample_data, 1)
  result$scores <- round(result$scores, 5)

  # Finished data frame
  output_data <-
    tibble(
      candidate = "The dragon ate dragon the pineapple",
      references = list(references = c("A dragon ate a pineapple", "The pineapple was eaten by the dragon")),
      scores = round(0.8333333, 5),
      type = "BLEU_1"
    )

  expect_equal(tidyr::unnest(result, references), tidyr::unnest(output_data, references))
})
