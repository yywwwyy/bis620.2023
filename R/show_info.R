#' @title HTML for single study tab's information page(beyond long description part).
#' @description The function provides the HTML code that takes tables' variables from users.
#' @param info the database table contain the basic information of the studies table.
#' @param elig the database table contain the information of the eligibilities table.
#' @export
show_info <- function(info,elig){
  #nct_id, brief_title,phase, start_date, completion_date,country,source_class
  #nct_id, sampling_method, gender, minimum_age, maximum_age, population,criteria
  sprintf('
  <div class="container">
  <h3>Information</h3>
  <table id="infoTB">
    <tr>
      <th>Feature</th>
      <th>Value</th>
    </tr>
    <tr>
      <td>NCT ID</td>
      <td>%s</td>
    </tr>
    <tr>
      <td>Phase</td>
      <td>%s</td>
    </tr>
    <tr>
      <td>Country</td>
      <td>%s</td>
    </tr>
    <tr>
      <td>Start Date</td>
      <td>%s</td>
    </tr>
    <tr>
      <td>End Date</td>
      <td>%s</td>
    </tr>
  </table>
  <br />
    <div class="box">
        <div class="title-box">
            <h5>Sampling Method:</h5>
        </div>
        <div class="content-box">
          %s
        </div>
    </div>
    <div class="box">
        <div class="title-box">
            <h5>Gender:</h5>
        </div>
        <div class="content-box">
          %s
        </div>
    </div>
    <div class="box">
        <div class="title-box">
            <h5>Minimum Age:</h5>
        </div>
        <div class="content-box">
          %s
        </div>
    </div>
    <div class="box">
        <div class="title-box">
            <h5>Maximum Age:</h5>
        </div>
        <div class="content-box">
          %s
        </div>
    </div>
    <div class="box">
        <div class="title-box">
            <h5>Population:</h5>
        </div>
        <div class="content-box">
          %s
        </div>
    </div>
  </div>
  <br />
  <br />
  ',info$nct_id,info$phase,info$country,info$start_date,info$completion_date,
          elig$sampling_method, elig$gender, elig$minimum_age, elig$maximum_age, elig$population)
}
