
<!-- README.md is generated from README.Rmd. Please edit that file -->

# footrulr

<!-- badges: start -->

<!-- badges: end -->

The goal of footrulr is to provide some functionality to compute
sentence comparisons using metrics frequently employed in Machine
Translation and Text Summarization evaluation.

The name is inspired from Rstudio’s [yardstick
package](https://tidymodels.github.io/yardstick/) for Machine Learning
evaluation metrics.

## Installation

You can install the development version of footrulr from github with:

``` r
# install.packages("devtools")
devtools::install_github("kanishkamisra/footrulr")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(footrulr)

bleu_vec("the cat the cat on the mat", c("the cat is on the mat", "there is a cat on the mat"), n = 3)
#> [1] 0.4
bleu_vec("The dragon ate dragon the pineapple", c("A dragon ate a pineapple", "The pineapple was eaten by the dragon"), n = 1)
#> [1] 0.8333333
```

### Contributors at chirunconf

  - [Katherine Simeon](https://katherinesimeon.github.io/)
  - [Mauro Lepore](https://github.com/maurolepore)
  - [Joshua Goldberg](https://twitter.com/GoldbergData)
  - [Will Bonnell](https://twitter.com/_willdebras)
