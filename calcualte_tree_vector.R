calculate_tree_vector <- function(F_uno, A, y, F_total, sequence, Tier){
	# calculates total value of the tree below given node
	# F_total is included for speedy calculations since matrix inversions takes time
	# sequence is the path to the node eg[32 56 29] will calculate value of the tree
	# after following the path  32 --> 56 --> 29
	
	#component = build_vector_component[A, sequence] %*% y[sequence[1], 1]
	library(Matrix)
	component <- y[sequence[1], 1]
    for (t in 2:T_cur){
		component <- component %*% A[sequence[t], sequence[t-1]]# it is a tree algorithm which moves column wise , hence sequence[t-1]
	}
	vector <- sparseMatrix(sequence[Tier],1, x=as.numeric(component), dims=c(nrow(y), 1))
	value <- F_total %*% vector	
	print(value)
}
