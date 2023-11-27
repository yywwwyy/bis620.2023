
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bis620.2023

<!-- badges: start -->

[![R-CMD-check](https://github.com/yywwwyy/bis620.2023/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/yywwwyy/bis620.2023/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/yywwwyy/bis620.2023/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/yywwwyy/bis620.2023/actions/workflows/test-coverage.yaml)
[![lint](https://github.com/yywwwyy/bis620.2023/actions/workflows/lint.yaml/badge.svg)](https://github.com/yywwwyy/bis620.2023/actions/workflows/lint.yaml)
<!-- badges: end -->

The goal of bis620.2023 is to …

## Installation

You can install the development version of bis620.2023 from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("yywwwyy/bis620.2023")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(bis620.2023)
## basic example code
accel |> 
  head(100) |> 
  plot_accel()
```

<img src="man/figures/README-example-1.png" width="100%" />
