#'
#' Get links to NSO Census PDF reports for 2024, 2011, and 2000
#' 
#' @param .url URL from PNG NSO containing links to the various population
#'   census PDF reports for 2024, 2011, and 2000
#' 
#' @returns A `data.frame` object containing links to the various population
#'   census reports for 2024, 2011, and 2000
#' 
#' @examples
#' 
#' @export
#' 

nso_get_census_report_links <- function(.url) {
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

    download_name <- rvest::html_element(x = .session, css = ".wpfd-container") |>
      rvest::html_table() |>
      dplyr::pull(Title)

    download_links <- rvest::html_elements(
      x = .session, css = ".wpfd-container .file_download_tbl .wpfd_downloadlink "
    ) |>
      rvest::html_attr(name = "href")

    tibble::tibble(
      document_name = download_name, 
      link = download_links
    )
  }
}










