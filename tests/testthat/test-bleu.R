context("test-bleu")

test_that("bleu works", {

  # Our candidate and reference data
  candidate <- "The cat the cat on the mat"
  reference1 <- "The cat is on the mat"
  reference2 <- "There is a cat on the mat"

  # Create data frame
  pairs <-
    data.frame(cbind(
      candidate = c(candidate, candidate),
      reference = c(reference1, reference2)
    ), stringsAsFactors = FALSE)

  sample_data <-
    cbind(
      system = c("1", "1"),
      candidate_id = c("1", "1"),
      reference_id = c("1", "2"),
      pairs,
      stringsAsFactors = FALSE
    )

  result <- bleu(sample_data, 1)
  result$score <- round(result$score, 5)

  # Finished data frame
  output_data <-
    cbind(
      sample_data,
      type = c("BLEU_1", "BLEU_1"),
      score = round(c(0.7142857, 0.5714286), 5),
      stringsAsFactors = FALSE
    )

  expect_equal(result, as_tibble(output_data))
})
