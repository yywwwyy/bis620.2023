
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bis620.2023

<!-- badges: start -->

[![R-CMD-check](https://github.com/yywwwyy/bis620.2023/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/yywwwyy/bis620.2023/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/yywwwyy/bis620.2023/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/yywwwyy/bis620.2023/actions/workflows/test-coverage.yaml)
[![lint](https://github.com/yywwwyy/bis620.2023/actions/workflows/lint.yaml/badge.svg)](https://github.com/yywwwyy/bis620.2023/actions/workflows/lint.yaml)
<!-- badges: end -->

This bis620.2023 package is designed to facilitate the analysis and
visualization of clinical trial data from ctgov. It includes a Shiny
application (app.R) and a suite of functions that streamline the process
of querying, processing, and presenting clinical trials research data.

## Installation

You can install the development version of bis620.2023 from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("yywwwyy/bis620.2023")
```

## Features

calculate_duration.R: Calculate the duration between clinical trial
start and end dates. data.R: Data preparation and transformation
utilities. exclude_query.R: Functionality to exclude certain queries
from the data set. get_concurrent_trials.R: Identify concurrent clinical
trials. globals.R: Define global variables for use within the Shiny app.
hello.R: A simple function demonstrating package use.
intervention_and_outcome_data_pro.R: Process data related to
interventions and outcomes. plot_condition_histogram.R: Plot histograms
of conditions from clinical trial data. plot_phase_histogram.R:
Visualize the different phases of clinical trials. plot.R: General
plotting functions. query_kwds.R: Functions to query the data set with
specific keywords. show_info.R: Display information about specific
clinical trials. spectral.R: Perform spectral analysis on data.

## How to run shinyapp

library(bis620.2023)

runshinyapp()

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

``` r

# studies |> head(1000)|>
#   exclude_query(ducktest,"Rates, Pembrolizumab")
# calculate_duration("2020-01-01", "2020-01-31", "days")
# calculate_duration("2020-01-01", "2020-02-01", "months")
# calculate_duration("2020-01-01", "2021-01-01", "years")
```

### link to the coverage page and lint results

# \[R-CMD-check\]<https://github.com/yywwwyy/bis620.2023/actions/workflows/R-CMD-check.yaml>

# \[test-coverage\]<https://github.com/yywwwyy/bis620.2023/actions/workflows/test-coverage.yaml>

# \[lint\]<https://github.com/yywwwyy/bis620.2023/actions/workflows/lint.yaml>
