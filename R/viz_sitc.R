viz_ui_module <- function(data = merch,
					  	  selected = c("Food and live animals", "Beverages and tobacco")) {
	number <- length(selected)

	for (i in 1:number) {
		good <- selected[i]
		
		code <- merch %>% 
			dplyr::filter(sitc == good) %>%
			dplyr::select(sitc_code) %>%
			unique() %>%
			as.character()
		
		subsets <- merch %>% 
			dplyr::select(sitc_code, sitc) %>%
			unique() %>%
			dplyr::filter(substr(sitc_code,1, nchar(code)) == code,
						  sitc_code != code) %>%
			dplyr::transmute(sitc = paste0(sitc_code, ": ", sitc))

		export_table <- merch %>%
			filter(sitc == good,
				   date >= max(date) - months(12),
				   country != "Total",
				   series == "exports") %>%
			group_by(sitc_code, sitc, country_code, country, state_code, state, series) %>%
			summarise(total = sum(value)) %>%
			ungroup() %>%
			arrange(desc(total)) %>%
			transmute(`Destination Country` = country,
					  `YTD Total Exports ($000s)` = scales::comma(total)) %>%
			DT::datatable(options = list(paging = TRUE,
										 pageLength = 10,
										 scrollX = FALSE,
										 scrollY = TRUE,
										 autoWidth = TRUE,
										 server = FALSE,
										 dom = "Bfrtip",
										 buttons = c('csv', 'excel')
										 ),
						  extensions = "Buttons",
						  selection = "Single",
						  filter = "bottom")

		import_table <- merch %>%
			filter(sitc == good,
				   date >= max(date) - months(12),
				   country != "Total",
				   series == "imports") %>%
			group_by(sitc_code, sitc, country_code, country, state_code, state, series) %>%
			summarise(total = sum(value)) %>%
			ungroup() %>%
			arrange(desc(total)) %>%
			transmute(`Country of Origin` = country,
					  `YTD Total Imports ($000s)` = scales::comma(total)) %>%
			DT::datatable(options = list(paging = TRUE,
										 pageLength = 10,
										 scrollX = FALSE,
										 scrollY = TRUE,
										 autoWidth = TRUE,
										 server = FALSE,
										 dom = "Bfrtip",
										 buttons = c('csv', 'excel')
										 ),
						  extensions = "Buttons",
						  selection = "Single",
						  filter = "bottom")
		print(subsets)
	}

}