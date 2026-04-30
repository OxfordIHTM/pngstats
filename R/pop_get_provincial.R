#'
#' Get PNG provincial population by sex for 2024
#' 
#' @param .url URL from PNG NSO containing data on 2024 provincial population.
#' 
#' @returns A `data.frame` object containing population figures for each
#'   province of PNG for 2024
#' 
#' @examples
#' pop_get_provincial_2024()
#' 
#' @export
#'

pop_get_provincial_2024 <- function(.url) {
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

    rvest::html_element(x = .session, css = ".et_pb_row_inner_3 .supsystic-table") |>
      rvest::html_table() |>
      stats::setNames(nm = c("province", "total", "male", "female", "sex_ratio")) |>
      dplyr::slice(3:24) |>
      dplyr::mutate(
        province = gsub(
          pattern = "[0-9]{1}.\\s", replacement = "", x = province
        ),
        dplyr::across(
          .cols = total:sex_ratio, 
          .fns = function(x) {
            gsub(pattern = ",", replacement = "", x = x) |>
              as.numeric()
          }
        ) 
      ) |>
      dplyr::select(-sex_ratio) |>
      dplyr::mutate(year = 2024, .before = total)
  }
}
