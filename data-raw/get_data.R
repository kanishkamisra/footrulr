library(tidyverse)

references_tibble <- tibble(
  reference = read_lines("data-raw/newstest2018-deen-ref-ts.en")
) %>%
  mutate(id = row_number())

cands <- list.files("data-raw/", pattern = "*.de-en", full.names = T)

wmt18example <- map_dfr(cands, function(x) {
  return(tibble(candidate = read_lines(x) %>% set_names(.)))
}, .id = "system") %>%
  group_by(system) %>%
  mutate(id = row_number()) %>%
  inner_join(references_tibble) %>%
  ungroup() %>%
  filter(reference != "NO REFERENCE AVAILABLE") %>%
  select(system, id, candidate, reference)

usethis::use_data(wmt18example, overwrite = TRUE)
sinew::makeOxygen(wmt18example)

