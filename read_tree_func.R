read_tree_func <- function(tree, N){
	# Read all the paths and values constructed in the tree
	# to make routine faster subtrees could be left unread
	
	if (cur_tree$value != -pi){
	      for (i in 1:N){
		  if (cur_tree$nextstep[i]$value != -pi){
			  next_path$value <- as.matrix(tree$nextstep[i]$value)
			  next_path$sequence <- tree$nextstep[i]$sequence
			  previous_path <<- c(previous_path, next_path)
			  read_tree_func(tree$nextstep[i], N)
			  }
			}	
	}
}
