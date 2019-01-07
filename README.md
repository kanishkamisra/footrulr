
<!-- README.md is generated from README.Rmd. Please edit that file -->

# footrulr

[![CRAN
status](https://www.r-pkg.org/badges/version/footrulr)](https://cran.r-project.org/package=footrulr)

The goal of footrulr is to provide some functionality to compute
sentence comparisons using metrics frequently employed in Machine
Translation and Text Summarization evaluation.

The name is inspired from Rstudio’s [yardstick
package](https://tidymodels.github.io/yardstick/) for Machine Learning
evaluation metrics.

## Installation

You can install the development version of footrulr from github with:

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(footrulr)

bleu("the cat the cat on the mat", c("the cat is on the mat", "there is a cat on the mat"), n = 3)
#> [1] 0.4
bleu("the cat is on a mat", c("the cat is on the mat", "there is a cat on the mat"), n = 3)
#> [1] 0.5
```
