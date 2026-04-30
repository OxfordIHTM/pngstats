# Workflow for ingesting and curating PNG National Statistical Office data -----


## Load libraries and custom functions ----
suppressPackageStartupMessages(source("packages.R"))
for (f in list.files(here::here("R"), full.names = TRUE)) source (f)


## Data targets ----
data_targets <- tar_plan(
  png_nso_population_url = "https://www.nso.gov.pg/statistics/population/",
  tar_target(
    name = nso_census_report_links,
    command = nso_get_census_report_links(.url = png_nso_population_url)
  ),
  tar_target(
    name = population_region_2024,
    command = pop_get_regional_2024(.url = png_nso_population_url)
  ),
  tar_target(
    name = population_province_2024,
    command = pop_get_provincial_2024(.url = png_nso_population_url)
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
