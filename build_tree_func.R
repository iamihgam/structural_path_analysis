build_tree_func <- function(F_uno, A, y, F_total, Tier, T_max, tol, sequence){
  # Construct the tiered Tree 
  # F_uno = final demand matrix of 1 functional output
  # A = technosphere matrix
  # y = final demand for n dollars per sector(s) (say 100 billion dollar from sector1)
  # F_total = F_uno * L, where L is inv(I-A), where F_total gives L matrix
  # Tier = Current Tier; T= 1, B * y; T=2 , B*A*y;  T=3, B*A2*y;
  # T_max = Maximum Tier
  # tol = minimum size to lop the tree ; tol <- total_emissions %*% percent; total_emissions = F_total %*% y ; percent = 0.01 
  # sequence = Current sequence being worked on 

  N <- length(y)

# Creating null_tree , an empty tree akin to a null pointer to a tree
 null_tree <- array(numeric())
 null_tree$sequence <- 0 # also try uint16(length=0) instead of array(numeric())
 null_tree$value <- -pi
 null_tree$nextstep <- 0
 
# creating cur_tree
 cur_tree <- array(numeric())
 
# Building final node
 if (Tier == T_max) {
	 cur_tree$sequence <- sequence
	 cur_tree$value[1] <- build_tree_value(F_uno, A, y, sequence, Tier)
	 cur_tree$value[2] <- calculate_tree_vector(F_uno, A,y, F_total, sequence, Tier)
	 
	 for(i in 1:N){ # stopping the node using null_tree
		 cur_tree$nextstep[i] <- null_tree
	 }
 }
 else{
	 #building a new node or sub_tree
	 cur_tree$sequence <- sequence
	 cur_tree$value <- build_tree_value(F_uno, A, y, sequence, Tier)
	 
	 for (i in 1:N){
		 sequence_next <- c(sequence, i) # gives concatenate, check and try replication : rep(sequence, times=i) if necessary 2) i can replaced as uint16(5) , revisit
		 tree_vector_value <- calculate_tree_vector(F_uno, A, y, F_total, sequence_next, Tier+1)
		 if (as.numeric(tree_vector_value) < tol){
			 cur_tree$nextstep[i] <- null_tree
			 }
		 else {
			 cur_tree$nextstep[i] <- build_tree_func(F_uno, A, y, F_total, Tier+1, T_max, tol, sequence_next)
			 }
		}
		
	if (prod(dim(sequence)) > 0 ) {
		cur_tree$value[2] <- calculate_tree_vector(F_uno, A, y, F_total, sequence, Tier)
		 }
 }
 message("Current Tree")
 print(cur_tree)
}	  
