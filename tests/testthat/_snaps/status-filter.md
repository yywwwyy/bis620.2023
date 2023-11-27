# silter_status() works

    Code
      filter_status(head(studies), c("Completed"))
    Output
      # A tibble: 5 x 73
        nct_id    nlm_download_date_de~1 study_first_submitte~2 results_first_submit~3
        <chr>     <lgl>                  <date>                 <date>                
      1 NCT00642~ NA                     2008-03-21             NA                    
      2 NCT02798~ NA                     2016-05-31             NA                    
      3 NCT04180~ NA                     2019-11-21             NA                    
      4 NCT02798~ NA                     2016-06-04             NA                    
      5 NCT00962~ NA                     2009-08-19             NA                    
      # i abbreviated names: 1: nlm_download_date_description,
      #   2: study_first_submitted_date, 3: results_first_submitted_date
      # i 69 more variables: disposition_first_submitted_date <date>,
      #   last_update_submitted_date <date>, study_first_submitted_qc_date <date>,
      #   study_first_posted_date <date>, study_first_posted_date_type <chr>,
      #   results_first_submitted_qc_date <date>, results_first_posted_date <date>,
      #   results_first_posted_date_type <chr>, ...

