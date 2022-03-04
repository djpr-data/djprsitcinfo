#' @import djprshiny
#' @import shiny
#' @import dplyr
#' @import ggplot2
#' @import djprtheme
#' @importFrom rlang .data .env

server <- function(input, output, session) {
	# Page Footnote
	footnote <- shiny::reactive({
		div(
			shiny::HTML(
				paste0(
					"This dashboard is produced by the <b>Strategy and Priority ",
					"Projects - Data + Analytics</b> team at the Victorian Department ",
					"of Jobs, Precincts and Regions. ",
					'Please <a href="mailto:louis.cui@ecodev.vic.gov.au?subject=DJPR SITC Information App">email us</a> with any comments or feedback.'
        			)
        		),
			style = "color: #828282; font-size: 0.75rem"
			)
	})

	output$sitc_footnote <- renderUI({footnote()})

	# Reactive list to select SITC codes
	sitc_codes <- merch %>%
		select(sitc, sitc_code) %>%
		unique() 

	sitc_df <- shiny::reactive({
	    if(input$goods_sitc_filter %in% c(1,2,3)) {
	      sitc_codes %>%
	        dplyr::filter(nchar(.data$sitc_code) == input$goods_sitc_filter) %>%
	        dplyr::mutate(code_name = paste0(.data$sitc_code, ": ", .data$sitc))
	    } else {
	      sitc_codes %>%
	        dplyr::mutate(code_name = paste0(.data$sitc_code, ": ", .data$sitc))
	    }
  	})

  observeEvent(sitc_df(), {
  		shinyWidgets::updateMultiInput(session = session, inputId = "goods_sitc", choices = unique(sitc_df()$code_name))
  })
}