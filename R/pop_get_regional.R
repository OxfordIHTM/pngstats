#'
#' Get regional population for 2024
#' 

pop_get_regional_2024 <- function(.url = "https://www.nso.gov.pg/statistics/population/") {
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
          pattern = "Regional Population", replacement = "Region", x = region
        ),
        population = gsub(pattern = ",", replacement = "", x = population) |>
          as.numeric()
      ) |>
      dplyr::mutate(year = 2024, .before = population)
  }
}

