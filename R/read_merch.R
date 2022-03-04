#' 
#' 
#' 
#' 
#' 
#' 
#' 
#' 
#' 
#' 

read_merch_lite <- function(
	path = tempdir(),
	max_date = Sys.Date(),
	min_date = Sys.Date() - months(60),
	delete = TRUE
	) {
	# Downloading and reading files into R
	url_exp <- "https://www.abs.gov.au/websitedbs/D3110132.nsf/home/DataExplorer/$File/MERCH_EXP.zip"
	exports_dest_zip <- file.path(path, basename(url_exp))
	download.file(url_exp, exports_dest_zip, mode = "wb")
	utils::unzip(exports_dest_zip, exdir = path)
	exp_csv <- list.files(path, pattern = "EXP.csv", full.names = TRUE)
	merch_exp <- readr::read_csv(file.path(exp_csv))

	url_imp <- "https://www.abs.gov.au/websitedbs/D3110132.nsf/home/DataExplorer/$File/MERCH_IMP.zip"
	imports_dest_zip <- file.path(path, basename(url_imp))
	download.file(url_imp, imports_dest_zip, mode = "wb")
	utils::unzip(imports_dest_zip, exdir = path)
	imp_csv <- list.files(path, pattern = "IMP.csv", full.names = TRUE)
	merch_imp <- readr::read_csv(file.path(imp_csv))

	# cleaning data file to reduce size

	merch <- dplyr::bind_rows(
		merch_exp %>%
			dplyr::transmute(sitc = .[[2]],
						 country = .[[3]],
						 state = .[[4]],
						 date = lubridate::ym(.[[6]]),
						 value = .[[7]],
						 series = "exports") %>%
			dplyr::filter(date >= min_date,
						  date <= max_date,
						  state == "2: Victoria"),
		merch_imp %>%
			dplyr::transmute(sitc = .[[2]],
							 country = .[[3]],
							 state = .[[4]],
							 date = lubridate::ym(.[[6]]),
							 value = .[[7]],
							 series = "imports") %>%
			dplyr::filter(date >= min_date,
						  date <= max_date,
						  state == "2: Victoria")
		)

	merch <- merch %>%
		tidyr::separate(sitc, c("sitc_code", "sitc"), sep = ": ") %>%
		tidyr::separate(country, c("country_code", "country"), sep = ": ") %>%
		tidyr::separate(state, c("state_code", "state"), sep = ": ")

	if(delete) {
		unlink(file.path(path, list.files(path)[grepl("MERCH", list.files(path))]))
	}

	return(merch)
}