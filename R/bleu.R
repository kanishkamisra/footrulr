#' BLEU  (Bilingual Evaluation Understudy)
#'
#' BLEU score calculations over a data frame.
#'
#' @param .data data frame (data that was processed by a data loading function to be created)
#' @param n desired number of ngrams (defaults to 4)
#'
#' @return tibble with data in long form. Each row contains the BLEU score for each ngram value for each candidate-reference pair.
#'
#' @importFrom purrr walk walk2
#' @importFrom tibble as_tibble
#'
#' @export
#'
#' @examples
#' # Our candidate and reference data
#' candidate <- "The cat the cat on the mat"
#' reference1 <- "The cat is on the mat"
#' reference2 <- "There is a cat on the mat"
#'
#' # Create data frame
#' pairs <- data.frame(cbind(
#'   candidate = c(candidate, candidate), reference = c(reference1, reference2)
#' ))
#' sample_data <- cbind(system = c(1, 1), candidate_id = c(1, 1), reference_id = c(1, 2), pairs)
#'
#' # Run function
#' bleu(sample_data)

bleu <- function(.data, n = 4) {
  walk(1:(length(colnames(.data))), function(x) .data[, x] <<- as.character(.data[, x]))
  ngrams <- 1:n

  .data_long <- as_tibble(.data[rep(seq_len(nrow(.data)), each = n), ])
  .data_long["type"] <- paste0("BLEU_", ngrams)
  .data_long["score"] <- NA_real_

  rows <- nrow(.data_long)
  ngram_sets <- rep(ngrams, times = nrow(.data))

  walk2(1:rows, ngram_sets, function(row, ngram) {
    .data_long[row, "score"] <<- bleu_vec(.data_long[row, 4][[1]], .data_long[row, 5][[1]], n = ngram)
  })

  .data_long
}
