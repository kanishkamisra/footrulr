#' @noRd
discard_index <- function (.x, .p, ...) {
  sel <- purrr:::probe(.x, .p, ...)
  which(sel)
}
