#'
#' Read NSO census report for 2024
#' 
#' @param path Path to downloaded PNG NSO Population Census report for 2024.
#' 
#' @examples
#' 
#' @export
#' 

nso_get_census_population_2024 <- function(path,
                                           admin = c("province", "district")) {
  admin <- match.arg(admin)
  
  x <- pdftools::pdf_text(pdf = path) |>
    (\(x) x[10:30])() |>
    stringr::str_split(pattern = "\n")

  if (admin == "province") {
    province <- lapply(X = x, FUN = nso_get_province) |>
      unlist()

    pvalue <- lapply(X = x, FUN = nso_get_province_population) |>
      do.call(what = rbind, args = _) |>
      data.frame() |>
      stats::setNames(nm = c("total", "male", "female"))

    pop <- data.frame(province, pvalue)
  }

  if (admin == "district") {
    pop <- lapply(X = x, FUN = nso_get_district_population) |>
      dplyr::bind_rows()
  }

  pop
}

nso_get_province <- function(x) {
  x[1] |>
    sub(pattern = "[0-9]{2}\\.\\s", replacement = "") |>
    stringr::str_to_title() |>
    (\(x)
      ifelse(
        grepl(pattern = "Autonomous", x = x), 
        "Autonomous Region of Bougainville",
        x
      )
    )()
}

nso_get_province_population <- function(x) {
  line_index <- grep(pattern = "Total population|Total Population", x = x) + 1

  x[line_index] |>
    gsub(pattern = ",", replacement = "") |>
    gsub(pattern = "^\\s{1,}", replacement = "") |>
    gsub(pattern = "\\s{1,}", replacement = ",") |>
    stringr::str_split(pattern = ",", simplify = TRUE)
}


nso_get_district_population <- function(x) {
  province <- nso_get_province(x)

  line_index <- grep(pattern = "Districts", x = x) + 1

  y <- x[line_index:length(x)]

  y |>
    grep(pattern = "[0-9]{1,2}", x = _, value = TRUE) |>
    (\(x) x[1:(length(x) - 1)])() |>
    gsub(pattern = "^\\s{1,}", replacement = "") |>
    gsub(pattern = ",", replacement = "") |>
    gsub(pattern = "\\s{2,}", replacement = ",") |>
    stringr::str_split(pattern = ",", simplify = TRUE) |>
    data.frame() |>
    stats::setNames(nm = c("district", "total", "male", "female")) |>
    dplyr::mutate(province = province, .before = district)
}