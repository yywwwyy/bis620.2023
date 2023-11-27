
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

## Installation(takes nearly 30 mins, please be patient)

### 

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

studies |> head(1000)|>
   exclude_query("Rates, Pembrolizumab","brief_title")
#> # A tibble: 998 × 73
#>    nct_id   nlm_download_date_de…¹ study_first_submitte…² results_first_submit…³
#>    <chr>    <lgl>                  <date>                 <date>                
#>  1 NCT0064… NA                     2008-03-21             NA                    
#>  2 NCT0423… NA                     2020-01-13             NA                    
#>  3 NCT0279… NA                     2016-05-31             NA                    
#>  4 NCT0418… NA                     2019-11-21             NA                    
#>  5 NCT0279… NA                     2016-06-04             NA                    
#>  6 NCT0096… NA                     2009-08-19             NA                    
#>  7 NCT0423… NA                     2019-12-31             NA                    
#>  8 NCT0096… NA                     2009-08-19             NA                    
#>  9 NCT0130… NA                     2011-02-18             2011-11-16            
#> 10 NCT0064… NA                     2008-03-24             NA                    
#> # ℹ 988 more rows
#> # ℹ abbreviated names: ¹​nlm_download_date_description,
#> #   ²​study_first_submitted_date, ³​results_first_submitted_date
#> # ℹ 69 more variables: disposition_first_submitted_date <date>,
#> #   last_update_submitted_date <date>, study_first_submitted_qc_date <date>,
#> #   study_first_posted_date <date>, study_first_posted_date_type <chr>,
#> #   results_first_submitted_qc_date <date>, results_first_posted_date <date>, …
#calculate_duration("2020-01-01", "2020-01-31", "days")
#calculate_duration("2020-01-01", "2020-02-01", "months")
#calculate_duration("2020-01-01", "2021-01-01", "years")
```

### link to the coverage page and lint results

# \[R-CMD-check\]<https://github.com/yywwwyy/bis620.2023/actions/workflows/R-CMD-check.yaml>

# \[test-coverage\]<https://github.com/yywwwyy/bis620.2023/actions/workflows/test-coverage.yaml>

# \[lint\]<https://github.com/yywwwyy/bis620.2023/actions/workflows/lint.yaml>
