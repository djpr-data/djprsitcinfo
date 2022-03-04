# FUNCTION NO LONGER IN USE


# update_merch <- function(
# 	data = merch,
# 	start = max(merch$date),
# 	end = start + months(1),
# 	overwrite = FALSE
# 	) {

# 	url_exp <- paste0("https://api.data.abs.gov.au/data/ABS,MERCH_EXP,1.0.0/...M?startPeriod=",
# 		format(start, "%Y-%m"),
# 		"&endPeriod=",
# 		format(end, "%Y-%m"),
# 		"&format=csv")

# 	new_merch_exp <- readr::read_csv(url_exp)

# 	latest_new_date <- new_merch_exp %>%
# 		dplyr::transmute(date = lubridate::ym(.[[6]])) %>%
# 		dplyr::filter(date == max(date))
	
# 	latest_date <- merch %>%
# 		dplyr::select(date) %>%
# 		dplyr::filter(date == max(date))

# 	if(overwrite) {
# 		if (latest_date < latest_new_date) {
# 			stop("Latest data from ABS Data Explorer ")
# 		}
# 	}

# 		new_merch_exp <- new_merch_exp %>%
# 			dplyr::transmute(sitc_code = .[[2]],
# 							 country_code = .[[3]],
# 							 state_code = .[[4]],
# 							 date = lubridate::ym(.[[6]]),
# 							 value = .[[7]],
# 							 series = "exports")

# 		url_imp <- paste0("https://api.data.abs.gov.au/data/ABS,MERCH_IMP,1.0.0/...M?startPeriod=",
# 			format(start, "%Y-%m"),
# 			"&endPeriod=",
# 			format(end, "%Y-%m"),
# 			"&format=csv")

# 		new_merch_imp <- readr::read_csv(url_imp)

# 		new_merch_imp <- new_merch_imp %>%
# 			dplyr::transmute(sitc_code = .[[2]],
# 							 country_code = .[[3]],
# 							 state_code = .[[4]],
# 							 date = lubridate::ym(.[[6]]),
# 							 value = .[[7]],
# 							 series = "imports")

# 		merch_codes <- merch_codes()
		
# 		new_merch <- dplyr::bind_rows(new_merch_exp, new_merch_imp) %>%
# 			dplyr::left_join(merch_codes %>% select(names(merch_codes)[grepl("sitc", names(merch_codes))])) %>%
# 				dplyr::left_join(merch_codes %>% select(names(merch_codes)[grepl("state", names(merch_codes))])) %>%
# 					dplyr::left_join(merch_codes %>% select(names(merch_codes)[grepl("country", names(merch_codes))]))
		
# 		merch <- merch %>% 
# 	  		dplyr::select(sort(current_vars()))

# 	  	new_merch <- new_merch %>% 
# 	  		dplyr::select(sort(current_vars()))

# 		merch <- dplyr::bind_rows(merch, new_merch) %>%
# 			dplyr::filter(state == "Victoria") %>%
# 			unique()

# 		usethis::use_data(merch,
# 			overwrite = TRUE,
# 			version = 3)
# }