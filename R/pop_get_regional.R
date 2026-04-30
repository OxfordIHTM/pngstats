#'
#' Get PNG regional population for 2024
#' 
#' @param .url URL from PNG NSO containing data on 2024 regional population.
#' 
#' @returns A `data.frame` object containing population figures for each region
#'   of PNG for 2024
#' 
#' @examples
#' pop_get_regional_2024()
#' 
#' @export
#' 

pop_get_regional_2024 <- function(.url) {
  ## Check if .url is valid ----
  url_check <- httr::http_error(.url)

  if (url_check) {
    warning(
      ".url doesn't seem to be a valid URL. Please check and try again. ",
      "Returning NULL"
    )
    NULL
  } else {
    .session <- rvest::session(.url)

    rvest::html_element(x = .session, css = ".supsystic-table") |>
      rvest::html_table() |>
      stats::setNames(nm = c("region", "population")) |>
      dplyr::slice(4:7) |>
      dplyr::mutate(
        region = gsub(
          pattern = " Regional Population", replacement = "", x = region
        ),
        population = gsub(pattern = ",", replacement = "", x = population) |>
          as.numeric()
      ) |>
      dplyr::mutate(year = 2024, .before = population)
  }
}

