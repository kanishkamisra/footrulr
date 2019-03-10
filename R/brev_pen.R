#' BLEU  (Bilingual Evaluation Understudy)
#'
#' Brevity Penalty calculations for BLEU assessed candidate and reference texts
#'
#' @param data data frame (data that was processed by a data loading function to be created)
#' @param reference column in data with reference text (human translated or created text)
#' @param candidate column in data with candidate text (machine generated text)
#'
#' @return brevity penalty score calculated as e^(1-r/c)
#'
#'
#' @importFrom tokenizers count_words
#'
#' @export
#'
#' @examples
#' library(footrulr)
#'
#' brev_pen(data = wmt18example, reference = "reference", candidate = "candidate")


brev_pen <- function(data, reference = reference, candidate = candidate) {
  exp(1 - sum(count_words(as.character((data$reference))))/sum(count_words(as.character((data$candidate)))))

}


