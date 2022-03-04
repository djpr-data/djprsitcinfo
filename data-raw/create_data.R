rm(list = ls())
pkgload::load_all()
options("timeout" = 180)

merch <- read_merch_lite()

usethis::use_data(
	merch,
	internal = TRUE,
	overwrite = TRUE,
	version = 3
	)