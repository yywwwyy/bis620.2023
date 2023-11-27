#' @title duration calculation
#' @description This function can calculate the duration between start_date and end_date in days
#'              and can transform duration into months and years.
#' @param start_date start_date of the trail
#' @param end_date completion date of the trail
#' @param unit end unit which can days, months, years
#' @export
calculate_duration <- function(start_date, end_date, unit = "days") {
  # Convert the start and end dates to Date objects
  start_date <- as.Date(start_date)
  end_date <- as.Date(end_date)

  # Calculate the duration
  duration <- end_date - start_date

  # Return the duration in the specified unit
  switch(unit,
         days = round(as.numeric(duration, "days")),
         months = round(as.numeric(duration, "days") / 30.44),  # Approximate average month length
         years = round(as.numeric(duration, "days") / 365.25), # Average year length, accounting for leap years
         round(as.numeric(duration, "days"))  # Default to days if the unit is not recognized
  )
}
