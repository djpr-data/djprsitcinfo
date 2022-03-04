ui <- function() {
	djprshiny::djpr_page(
		title = shiny::HTML("DJPR SITC Information and Goods Profiles"),
		page_sitc()
		)
}