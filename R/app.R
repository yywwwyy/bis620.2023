#' @title Run the shiny
#' @param ... additional argument passed to shiny app
#' @import shiny
#' @importFrom shiny fluidPage titlePanel navbarPage tabPanel sidebarLayout sidebarPanel textInput sliderInput dateInput selectInput checkboxGroupInput mainPanel tabsetPanel plotOutput dataTableOutput renderPlot renderDataTable renderUI htmlOutput shinyApp
#' @importFrom dplyr filter collect mutate rename distinct left_join
#' @importFrom ggplot2 ggplot aes geom_bar theme_minimal labs position_dodge
#' @export
runshinyapp <- function(...) {
  max_num_studies = 1000
  data(studies)
  data(sponsors)
  data(reported_events)
  data(phase_type)
  data(outcomes)
  data(interventions)
  data(eligibilities)
  data(designs)
  data(country_list)
  data(countries)
  data(conditions)
  data(brief_summaries)


  # Define UI for application that draws a histogram
  ui <- fluidPage(
    tags$head(
      tags$style(HTML("
          #infoTB {
            font-family: Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
            table-layout: fixed;
          }

          #infoTB td, #infoTB th {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
          }

          #infoTB tr:nth-child(even){background-color: #f2f2f2;}
          #infoTB tr>td:nth-child(1){
            width: auto;
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: lightgrey;
            color: black;}

          #infoTB tr:hover {background-color: #ddd;}

          #infoTB th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: lightblue;
            color: white;
          }
          .box {
            display: inline-block;
            border: 1px solid #ccc;
            width: 220px;
            height: auto;
            vertical-align: top;
            background-color:#f2f2f2;
            border-radius: 10px;
            border-collapse: collapse;
            margin: 5px;
          }
         .title-box {
            background-color: #4DBCDF;
            color: white;
            padding: 0.1px;
            font-weight: bold;
            border-radius: 10px;
         }
         .content-box {
            padding: 10px;
         }
         .container {
            position: relative;
            text-align: center;
            width: 100%;
         }
         .container2 {
            position: relative;
            text-align: left;
            width: 100%;
            background-color:lightgrey;
            border-radius: 10px;
            padding: 8px;
         }
        .blue-text {
            color: blue;
            font-weight: bold;
        }
                    "))),
    # Application title
    titlePanel("BIS 620 2023 Midterm-Project: Clinical Trials Query"),
    navbarPage(
      "Clinical Trials Query",
      tabPanel("Filter and Plot in Entire Clinical Trials",
               # Sidebar with inputs for keywords and sponsors
               sidebarLayout(
                 sidebarPanel(
                   textInput("brief_title_kw", "Brief title keywords"),
                   textInput("exclude_title_kw", "Title keywords you want to exclude from the result"),
                   sliderInput("durationRange",
                               "Duration of Study (in months):",
                               min = 0,
                               max = 60,  # Adjust based on your data, e.g., 60 months for 5 years
                               value = c(0, 30),  # Default range, e.g., between 6 and 24 months
                               step = 1),
                   dateInput("startDateFilter",
                             label = "Show studies starting from(enter in date format):",
                             value = as.Date("1900-01-01"),  # Default to today's date or choose another sensible default
                             min = as.Date("1900-01-01"),  # Set a minimum date if needed
                             max = Sys.Date()),
                   selectInput("source_type",
                               label = h4("Sponsor Type"),
                               choices = list("Fedral" = "FED",
                                              "Individual" = "INDIV",
                                              "Industry" = "INDUSTRY",
                                              "Network" = "NETWORK",
                                              "NIH"="NIH",
                                              "Other"= "OTHER",
                                              "Other gov"= "OTHER_GOV",
                                              "Unknown"="Unknown"),
                               multiple = TRUE
                   ),
                   selectInput("country_type",
                               label = h4("Choose Country"),
                               choices = country_list,
                               multiple = TRUE
                   ),
                   checkboxGroupInput("status", label = "Choose the status you want to include", choices = list("Completed", "Unknown status", "Terminated", "Recruiting", "Not yet recruiting",
                                                                                                                "Active, not recruiting", "Enrolling by invitation", "Withdrawn",
                                                                                                                "Suspended", "No longer available", "Approved for marketing", "Available",
                                                                                                                "Withheld", "Temporarily not available"))
                 ),
                 # Show a plot of the generated distribution
                 mainPanel(
                   tabsetPanel(
                     type = "tabs",
                     tabPanel("Phase", plotOutput("phase_plot")),
                     tabPanel("Concurrent", plotOutput("concurrent_plot")),
                     # Add a new tab that gives a histogram showing the conditions that trials in a query are examining
                     tabPanel("Condition", plotOutput("condition_plot")),
                     tabPanel("Intervention Outcomes", plotOutput("intervention_outcome_plot")),
                     tabPanel("Country", plotOutput("country_plot")),
                     tabPanel("Status", plotOutput("status_plot")),
                     tabPanel("Map", plotOutput("map")) # add two new tabs that include the status plot and map
                   ),
                   dataTableOutput("trial_table"),
                   # dataTableOutput("original_table"), #for debug usage
                   #uiOutput("length_id")
                 )
               )),
      tabPanel("Single Study",
               # Sidebar with a slider input for number of bins
               sidebarLayout(
                 sidebarPanel(
                   textInput("nct_id_wanted",
                             "Please enter NCT ID you want to search, e.g. NCT04538079",
                             value = "NCT04538079"),
                   dataTableOutput("single_study_information")
                 ),
                 # Show a plot of
                 mainPanel(
                   tabsetPanel(
                     type = "tabs",
                     #position = "above",
                     tabPanel("Infomation", uiOutput("basic_info"),
                              htmlOutput("long_desc")),
                     tabPanel("Condition",
                              #plotOutput("single_study_condition_plot"),
                              dataTableOutput("single_study_conditions")),
                     tabPanel("Sponsor",
                              dataTableOutput("single_study_sponsors")),
                     tabPanel("Event",
                              dataTableOutput("single_study_events")),
                   ),
                   # uiOutput("basic_info"),
                   # dataTableOutput("single_study_conditions"),
                 )
               ))
    )
  )

  # Define server logic required to draw different plot
  server <- function(input, output) {
    get_studies = reactive({
      if (input$brief_title_kw != "") {
        si = input$brief_title_kw |>
          strsplit(",") |>
          unlist() |>
          trimws()
        ret = query_kwds(studies, si, "brief_title", match_all = TRUE)  #studies = data(studies)
      } else {
        ret = studies
      }
      # source_class before
      if(!is.null(input$source_type)){
        ret = ret |>
          filter(source_class %in% !!input$source_type)
      }

      if(!is.null(input$country_type)){
        ret = ret |>
          filter(country %in% !!input$country_type)
      }

      if(input$exclude_title_kw != ""){
        ret = exclude_query(ret,input$exclude_title_kw, "brief_title")
      }

      ret <- ret |>
        collect()

      # Then calculate the duration in months
      ret <- ret |>
        mutate(duration = calculate_duration(start_date, completion_date, "months"))

      # Apply the duration filter
      if (!is.null(input$durationRange)) {
        ret <- ret |>
          filter(duration >= input$durationRange[1] & duration <= input$durationRange[2])
      }

      # filter the status according to user input
      if(!is.null(input$status)){
        ret <- ret |>
          filter_status(input$status)
      }

      # Apply the start date filter
      if (!is.null(input$startDateFilter)) {
        start_date_as_date <- tryCatch(as.Date(input$startDateFilter), error = function(e) NA)
        if(!is.na(start_date_as_date)) {
          ret <- ret |>
            filter(as.Date(start_date) >= start_date_as_date)
        }
      }

      ret <- ret |>
        head(max_num_studies)
    })


    get_studies_db = reactive({
      outcomes_db = outcomes |> collect()
      interventions_db = interventions |> collect()
      retdb = get_studies() |>
        left_join(outcomes_db, by = "nct_id", suffix = c("_outcomes", "_studies"), relationship = "many-to-many") |>
        left_join(interventions_db, by = "nct_id", suffix = c("_interventions", "_studies"), relationship = "many-to-many")

    })

    get_nct_id_with_conditions = reactive({
      #if (input$nct_id_wanted != "") {
      ni = input$nct_id_wanted |>
        trimws()
      nct_table = studies |>
        filter(nct_id == !!ni)
      # } else {
      #   nct_table = studies
      # }
      nct_table |>
        head(max_num_studies) |>
        collect()
    })

    #sponsors
    get_nct_id_with_sponsors = reactive({
      spi = input$nct_id_wanted |>
        trimws()
      spo_table = sponsors |>
        filter(nct_id == !!spi)
      spo_table |>
        head(max_num_studies) |>
        collect()
    })

    #reported events
    get_nct_id_with_events = reactive({
      repi = input$nct_id_wanted |>
        trimws()
      repi_table = reported_events |>
        filter(nct_id == !!repi)
      repi_table |>
        head(max_num_studies) |>
        collect()
    })
    # brief_summaries
    get_nct_id_with_long_desc = reactive({
      di = input$nct_id_wanted |>
        trimws()
      des_table = brief_summaries |>
        filter(nct_id == !!di)|>
        distinct()
      des_table |>
        head(1) |>
        collect()
    })
    # eligibilities
    get_nct_id_with_elig = reactive({
      ei = input$nct_id_wanted |>
        trimws()
      eli_table = eligibilities |>
        filter(nct_id == !!ei)|>
        distinct()
      eli_table |>
        collect()|>
        head(1)
    })

    output$phase_plot = renderPlot({
      get_studies() |>
        plot_phase_histogram()
    })

    output$concurrent_plot = renderPlot({
      get_studies() |>
        select(-condition_name, -downcase_condition_name) |>
        unique() |>
        select(start_date, completion_date) |>
        get_concurrent_trials() |>
        ggplot(aes(x = date, y = count)) +
        geom_line() +
        xlab("Date") +
        ylab("Count") +
        theme_bw()
    })

    output$condition_plot = renderPlot({
      get_studies() |>
        plot_condition_histogram()
    })


    output$country_plot = renderPlot({
      get_studies() |>
        plot_country_histogram()
    })

    output$trial_table = renderDataTable({
      get_studies() |>
        select(nct_id, country,brief_title, start_date, completion_date) |>
        rename(`NCT ID` = nct_id, `Country` = country,`Brief Title` = brief_title,
               `Start Date` = start_date, `Completion Date` = completion_date) |>
        unique()
    })

    # debug use
    output$original_table = renderDataTable({
      studies|> select(nct_id, country,brief_title, start_date, completion_date) |>
        rename(`NCT ID` = nct_id, `Country` = country,`Brief Title` = brief_title,
               `Start Date` = start_date, `Completion Date` = completion_date) |>
        head(max_num_studies) |>
        collect()
    })

    output$basic_info = renderUI({
      single_study_for_info = get_nct_id_with_conditions()
      single_study_for_elig = get_nct_id_with_elig()
      single_study_for_info = single_study_for_info |>
        select(nct_id, brief_title,phase, start_date, completion_date, country, source_class) |>
        distinct() |>
        collect() |>
        head(1)
      HTML(show_info(single_study_for_info, single_study_for_elig))
    })


    output$long_desc = renderUI({
      #<div class=\"container2\"> </div>
      desc = get_nct_id_with_long_desc() |>
        select(long_description) |>
        collect()|>
        head(1)
      HTML(paste("<div class=\"container2\"> <div ><span class=\"blue-text\">Description:</span> </div>","<font color=\"black\"><b>",desc[[1]],"</b></font></div>
               <br /><br />"))
    })


    # output$single_study_condition_plot = renderPlot({
    #
    # })

    output$single_study_information =  renderDataTable({
      get_nct_id_with_conditions() |>
        select(nct_id, brief_title,phase, start_date, completion_date) |>
        unique()
    },options = list(pageLength = 1,searching=FALSE,paging=FALSE,scrollX=TRUE,scrollY=TRUE,rownames = FALSE))

    output$single_study_conditions = renderDataTable({
      get_nct_id_with_conditions() |>
        select(nct_id, condition_name)
    })

    output$single_study_sponsors = renderDataTable({
      get_nct_id_with_sponsors() |>
        select(nct_id, agency_class, lead_or_collaborator, name) |>
        rename(`NCT ID` = nct_id, `Agency Class` = agency_class,`Lead/Collaborator` = lead_or_collaborator,
               `Sponsor Name` = name) |>
        head(max_num_studies) |>
        collect()
    })

    # status plot added
    output$status_plot = renderPlot({
      get_studies() |>
        plot_status_histogram()
    })

    # map added
    output$map = renderPlot({
      get_studies() |>
        plot_map()
    })

    #nct_id, result_group_id, ctgov_group_code,time_frame, event_type, subjects_affected,
    #subjects_at_risk, adverse_event_term, organ_system
    output$single_study_events = renderDataTable({
      get_nct_id_with_events() |>
        select(nct_id, time_frame, event_type, subjects_affected, subjects_at_risk,adverse_event_term,organ_system) |>
        rename(`NCT ID` = nct_id, `Time Frame` = time_frame,`Event Type` = event_type,
               `Subjects Affected` = subjects_affected, `Subjects at Risk` = subjects_at_risk,
               `Adverse Event Term` = adverse_event_term, `Organ System` = organ_system) |>
        head(max_num_studies) |>
        collect()
    })

    # for debug usage
    output$"length_id" = renderUI({
      nct_id_list = get_studies()|>select(nct_id) |>collect()
      nct_id_list[[1]]|>length()
    })

    output$intervention_outcome_plot <- renderPlot({
      get_studies_db <- req(get_studies_db())  # Ensure data is available before plotting
      processed_data <- process_intervention_outcomes(get_studies_db)

      ggplot(processed_data, aes(x = reorder(intervention_type, -count), y = count, fill = outcome_type)) +
        geom_bar(stat = "identity", position = position_dodge()) +
        theme_minimal() +
        labs(title = "Count of Outcomes by Intervention Type",
             x = "Intervention Type",
             y = "Count of Outcomes")
    })

  }

  # Run the application
  shinyApp(ui = ui, server = server)
}
