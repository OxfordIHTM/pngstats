#'
#' Download NSO census report
#' 
#' @param .url Download URL for PNG NSO Population Census report.
#' @param path Path to download PNG NSO Population Census report.
#' @param overwrite Logical. Should report be overwritten if already present at
#'   `path`? Default to FALSE.
#' 
#' @examples
#' 
#' @export
#' 

nso_download_census_report <- function(.url, path, overwrite = FALSE) {
  if (overwrite | !file.exists(.url)) {
    download.file(url = .url, destfile = path, mode = "wb")
  }

  path
}