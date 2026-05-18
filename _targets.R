# Workflow for ingesting and curating PNG National Statistical Office data -----


## Load libraries and custom functions ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Data targets ----
data_targets <- tar_plan(
  nso_population_url = "https://www.nso.gov.pg/statistics/population/",
  nso_census_report_2024_url = "https://www.nso.gov.pg/download/51/population-housing/4310/2024-national-population-census-final-figures.pdf",
  nso_census_report_2011_url = "https://www.nso.gov.pg/download/51/population-housing/2152/png-national-report-2011-census.pdf",
  nso_census_report_2000_url = "https://www.nso.gov.pg/download/51/population-housing/2151/png-national-report-2000-census.pdf",
  tar_target(
    name = nso_census_report_links,
    command = nso_get_census_report_links(.url = nso_population_url)
  ),
  tar_target(
    name = population_region_2024,
    command = pop_get_regional_2024(.url = nso_population_url)
  ),
  tar_target(
    name = population_province_2024,
    command = pop_get_provincial_2024(.url = nso_population_url)
  ),
  tar_target(
    name = nso_census_report_2024_file,
    command = nso_download_census_report(
      .url = nso_census_report_2024_url, 
      path = "data-raw/png_nso_census_2024.pdf", 
      overwrite = FALSE
    )
  ),
  tar_target(
    name = nso_census_report_2011_file,
    command = nso_download_census_report(
      .url = nso_census_report_2011_url, 
      path = "data-raw/png_nso_census_2011.pdf", 
      overwrite = FALSE
    )
  ),
  tar_target(
    name = nso_census_report_2000_file,
    command = nso_download_census_report(
      .url = nso_census_report_2000_url, 
      path = "data-raw/png_nso_census_2000.pdf", 
      overwrite = FALSE
    )
  ),
  tar_target(
    name = population_province_2024_by_sex,
    command = nso_get_census_population_2024(
      path = nso_census_report_2024_file, admin = "province"
    )
  ),
  tar_target(
    name = population_district_2024_by_sex,
    command = nso_get_census_population_2024(
      path = nso_census_report_2024_file, admin = "district"
    )
  )
)


## Processing targets ----
processing_targets <- tar_plan(
  
)


## Analysis targets ----
analysis_targets <- tar_plan(
  
)


## Output targets ----
output_targets <- tar_plan(
  
)


## Reporting targets ----
report_targets <- tar_plan(
  
)


## Deploy targets ----
deploy_targets <- tar_plan(
  
)


## List targets ----
all_targets()
