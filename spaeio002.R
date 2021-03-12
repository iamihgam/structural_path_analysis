spaeio002 <- function(F_uno, A, y, F_total, T_max, percent, filename, sectornames, thresh_banner){
	# SPA - Glen Peters - 2005
	# tol is the percentage to cut of paths
	# calculate total_emissions and tolerance
	Total_emissions <-  F_total %*% y
	tol <-  (percent/100) * Total_emissions
	
	message("tolerance")
	message(tol)
	
	message("Construct the tree...")
	tictoc::tic()
	# tree <- build_tree_func(F_uno, A, y, F_total, 0, T_max, tol)
	tree <- build_tree(F_uno, A, y, F_total, T_max, tol)
	tictoc::toc()
	
	#save the tree
	file_tree <- paste0(filename, "_tree_", T_max)
	#save('tree', file_tree)
	
	message('Read tree ..')
	tic()
	paths <- read_tree(tree, nrow(A))
	toc()
	#rm(tree)
	
	message("Sort tree")
	tic()
	sorted_paths <- sort_paths(paths)
	toc()
	
	#save the sorted paths
	file_paths <- paste0(filename, "_paths_", T_max)
	save(c(paths, sorted_paths, Total_emissions), file_paths.RData)
	
	file_print <- paste0(filename, ".txt", sep="")
	message(paste0("Print sorted tree to file", file_print))
	tic()
	print_sorted_eio002(sorted_paths, T_max, percent, Total_emissions, file_print, sectornames, thresh_banner)
	toc()
	
	total=0
	for(i in seq_along(1:length(sorted_paths))){
		total = total + sorted_paths[i]$value
	}
	percent_effects_captured <- total[1] / (Total_emissions*100)
	output_text <- paste0("The total number of paths is ", length(paths), "the total effects covered are ", total[1], "and covers", percent_effects_captured, "percent of emissions")
	message(output_text) 
	}
