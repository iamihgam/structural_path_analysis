read_tree <- function(tree, N){
	# driver for read_tree_func
	previous_path <<- matrix(numeric(), nrow=0, ncol=0)
	read_tree_func(tree, N)
	read_paths <- previous_path 
	}

