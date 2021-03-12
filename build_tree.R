build_tree <- function(F_uno, A, y, F_total, T_max, tol){
	# Driver for Build_tree_fun
	# T_max is the maximum tier to be calculated
	# tol is the minimum size to lop the tree
	message ('tolerance..')
	message(tol)
	# XXX need to be revised before compiling 
	library(mmap)
	tree_to_build <- build_tree_func(F_uno, A,y, F_total, 1, T_max, tol, 1)
	}
