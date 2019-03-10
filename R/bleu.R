#' BLEU  (Bilingual Evaluation Understudy)
#'
#' BLEU score calculations over a data frame.
#'
#' @param .data A list, where each candidate has multiple references  (dataframe that was transformed into a list by another function in this package)
#' @param n desired number of ngrams (defaults to 4)
#'
#' @return tibble with data in long form. Each row contains the BLEU score for each ngram value for each candidate-reference pair.
#'
#' @importFrom purrr walk walk2 map_df map_dbl
#' @importFrom tibble as_tibble tibble
#'
#' @export
#'
#' @examples
#' # Our candidate and reference data
#' sample_data <- list(list(candidate = "The cat the cat on the mat", references = c("The cat is on the mat", "There is a cat on the mat")),
#' list(candidate = "The cat the cat on the map", references = c("The cat is on the ccccccat", "There is a cat on the mat")))
#'
#'
#'
#' # Run function
#' bleu(sample_data)

bleu <- function(.data, n = 4) {
  ngrams <- 1:n

  map_through_ngram <- function(candidate){
    map_dbl(ngrams, function(ngram){
      bleu_vec(candidate$candidate, candidate$references, ngram)
    }
    )}

  .data_long <<- map_df(.data, function(item){
    cand <- item$candidate
    ref <- item$references
    scores <- map_through_ngram(item)

    tibble(
      candidate = cand,
      references = list(ref),
      scores
    )
  })


  .data_long["type"] <- paste0("BLEU_", ngrams)

  .data_long
}
