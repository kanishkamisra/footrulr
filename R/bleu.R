#' BLEU (Bilingual Evaluation Understudy)
#'
#' Evaluate a machine translation candidate against a set of reference sentences.
#'
#' @param candidate candidate sentence
#'
#' @param reference vector of reference sentences
#' @param n ngram size, default = 1
#'
#' @return a double indicating the BLEU score between the candidate and the set of references
#'
#' @importFrom tokenizers tokenize_ngrams
#' @importFrom purrr map_int map_dbl
#'
#' @examples
#'
#' cand <- "the cat the cat on the mat"
#' reference <- c("the cat is on the mat", "there is a cat on the mat")
#' bleu(cand, reference, 2)
#'
#' @export
bleu <- function(candidate, reference, n = 1) {
  tokenized_candidate <- tokenize_ngrams(candidate, simplify = T, n = n)
  tokenized_references <- tokenize_ngrams(reference, n = n)

  cand_tokens <- length(tokenized_candidate)

  clips <- map_dbl(unique(tokenized_candidate), function(x) {
    max(map_int(tokenized_references, ~sum(.x == x)))
  })

  return(sum(clips)/cand_tokens)
}
