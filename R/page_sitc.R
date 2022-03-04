page_sitc <- function(...) {
	selector_height <- 325
	inner_height <- selector_height - 44

	tabPanel(
		title = "SITC Guide",
		tags$head(
			tags$style(paste0(".multi-wrapper {height: ", selector_height, "px;}")),
			tags$style(paste0(
				".multi-wrapper .non-selected-wrapper, .multi-wrapper .selected-wrapper {height: ",
				inner_height,
		        "px;}"
		        ))
			),
		value = "tab-goods-profiles",
		br(),
		br(),
		h1("SITC Information and Goods Profiles"),
		fluidRow(
			column(
				4,
				shinyWidgets::awesomeRadio(
					inputId = "goods_sitc_filter",
					label = "SITC Level: ",
					choices = c(
						1,
						2,
						3,
						"All"
						),
					selected = "All",
					inline = TRUE,
					status = "primary"
					),
				shiny::div(style = "height: 800px",
				shinyWidgets::multiInput(
					inputId = "goods_sitc",
					label = "Goods",
					choices = "",
					selected = "",
					width = "100%",
					options = list(
						non_selected_header = "All goods:",
						selected_header = "Selected goods:"
						)
					)
				)
				),
			column(
				8,

				)
			),
		br(),
		centred_row(htmlOutput("sitc_footnote")),
		br()
		)
}