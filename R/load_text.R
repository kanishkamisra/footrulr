#' load_text
#'
#' Load two text files (a candidate and a reference) and give it unique candidate and reference IDs and pair them.
#' Candidates and references should have a one-to-one correspondence
#'
#' @param candidate_df candidate text file
#' @param reference_df reference text file
#'
#' @return a dataframe with candidates matched to references
#' @export
#'
#' @examples
load_text <- function(candidate_df,reference_df) {

  candidate_data <- read.delim(candidate_df, header = FALSE)
  reference_data <- read.delim(reference_df, header = FALSE)

  candidates <- transform(candidate_data, id = as.numeric(factor(V1)))
  references <- transform(reference_data, id = as.numeric(factor(V1)))

  full_data <<- data.frame(cbind(candidate_ID = candidates$id,
                                 reference_ID = references$id,
                                 candidate = as.character(candidates$V1),
                                 reference = as.character(references$V1)))


}
