library(readr)
library(purrr)

cands <- read_lines("data-raw/newstest2018.LMU-unsup.5650.de-en")

read_footrulr <- function(...) {
  map(..., function(x) {
    read_lines(x)
  })
}

refs <- read_footrulr(
  c("data-raw/newstest2018-deen-ref-ts.en", "data-raw/newstest2018-deen-ref-ts.en")
)

refs

tic()
# test_list <- vector(mode = "list", length = length(cands))
test_list <- list()

for(i in 1:length(refs[[1]])) {
  test_list[[i]] <- map_chr(refs, ~.x[[i]])
}
toc()
test_list2 <- map2(cands, test_list, function(x, y) {
  list(candidate = x, reference = y)
})
# tic()
# map(1:4, function(x) {
#   map_dbl(test_list2, ~footrulr::bleu_vec(.x$candidate, .x$reference, n = x))
# })
# toc()

test <- list(list(candidate = "The cat the cat on the mat", references = c("The cat is on the mat", "There is a cat on the mat")),
             list(candidate = "The cat the cat on the map", references = c("The cat is on the ccccccat", "There is a cat on the mat")))


?read_lines

discard_index <- function (.x, .p, ...) {
  sel <- purrr:::probe(.x, .p, ...)
  which(sel)
}

discard_index(refs[[1]], ~.x == "NO REFERENCE AVAILABLE")

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

  structure(cr_list, class = "footrulr")
}




example <- footrulr("data-raw/newstest2018.LMU-unsup.5650.de-en", c("data-raw/newstest2018-deen-ref-ts2.en", "data-raw/newstest2018-deen-ref-ts.en"))

tic()
example_bleu <- bleu(example)
toc()
