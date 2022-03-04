#'
#' 
#' 
#' 
#' 
#' 
#' 
#' 

merch_codes <- function(path = tempdir()) {

	structure_url <- "https://api.data.abs.gov.au/dataflow/ABS/MERCH_EXP/1.0.0?references=all&detail=referencepartial"

	structure <- readsdmx::read_sdmx(structure_url) %>% 
		as_tibble() %>%
		arrange(en) %>%
		dplyr::select(en, en_description, id_description) %>%
		dplyr::filter(!(en %in% c("Frequency", "Observation Status", "Unit Multiplier", "Unit of Measure")))

	structure_chunk <- structure %>%
		dplyr::group_split(en) %>%
		stats::setNames(gsub(" ", "_", tolower(unique(structure$en))))

	bind_rows(
		structure_chunk$merchandise_commodity_by_sitc_revision_3 %>%
			transmute(sitc = paste0(id_description, ": ", en_description),
				   	  sitc_code = id_description),
		structure_chunk$merchandise_state %>%
			transmute(state = paste0(id_description, ": ", en_description),
					  state_code = id_description),
		structure_chunk$merchandise_country %>%
		transmute(country = paste0(id_description, ": ", en_description),
				  country_code = id_description)		
		)
}