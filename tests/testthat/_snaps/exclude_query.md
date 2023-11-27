# exclude_query works

    Code
      exclude_query(ducktest, "Rates, Pembrolizumab", "brief_title")
    Output
      # A tibble: 731 x 73
         nct_id   nlm_download_date_de~1 study_first_submitte~2 results_first_submit~3
         <chr>    <lgl>                  <date>                 <date>                
       1 NCT0570~ NA                     2023-01-02             NA                    
       2 NCT0570~ NA                     2023-01-02             NA                    
       3 NCT0570~ NA                     2023-01-02             NA                    
       4 NCT0361~ NA                     2018-03-14             NA                    
       5 NCT0271~ NA                     2016-03-15             NA                    
       6 NCT0268~ NA                     2016-02-08             NA                    
       7 NCT0268~ NA                     2016-02-08             NA                    
       8 NCT0479~ NA                     2021-03-08             NA                    
       9 NCT0479~ NA                     2021-03-08             NA                    
      10 NCT0479~ NA                     2021-03-08             NA                    
      # i 721 more rows
      # i abbreviated names: 1: nlm_download_date_description,
      #   2: study_first_submitted_date, 3: results_first_submitted_date
      # i 69 more variables: disposition_first_submitted_date <date>,
      #   last_update_submitted_date <date>, study_first_submitted_qc_date <date>,
      #   study_first_posted_date <date>, study_first_posted_date_type <chr>,
      #   results_first_submitted_qc_date <date>, ...

