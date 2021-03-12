build_tree_value <- function(F_uno, A, y, sequence, Tier){
	# Given a sequence, it calculates the value of the node, aka , contribution from the node
	if (Tier == 0){
		value = 0
	}
	else{
		component <- y[sequence[1], 1]
		#for (t in 1:Tier){  #new script
		#	component <- component %*% A[sequence[t], sequence[t+1]] 
		 #}
		 for (t in 2:Tier){  #original script
		 	component <- component %*% A[sequence[t], sequence[t-1]] 
		 }

		
		 value <-  F_uno[1, sequence[Tier]] %*% component
	 }
 }
