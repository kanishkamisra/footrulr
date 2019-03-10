#' footrulr
#'
#' @param cand_file candidate file
#' @param ... one or more reference files
#' @param non_value string indicating non references
#'
#' @return a footrulr object with candidate-reference collections
#'
#' @importFrom purrr map discard map_chr
#' @importFrom readr read_lines
#' @export
#'
footrulr <- function(cand_file, ..., non_value = "NO REFERENCE AVAILABLE") {
  candidates <- read_lines(cand_file)
  references <- map(..., read_lines)

  non_idx <- discard_index(references[[1]], ~.x == non_value)

  candidates <- candidates[-non_idx]
  references <- map(references, function(x) {
    x[-non_idx]
  })

  ref_list <- vector(mode = "list", length = length(candidates))

  for(i in 1:length(references[[1]])) {
    ref_list[[i]] <- map_chr(references, ~.x[[i]])
  }

  cr_list <- map2(candidates, ref_list, function(x, y) {
    list(candidate = x, references = y)
  })

  # structure(cr_list, class = "footrulr")
  cr_list
}
