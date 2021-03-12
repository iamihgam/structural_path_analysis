F_uno <- matrix(c(1, 1), 1, 2)
A <- matrix(c(0.150, 0.200, 0.250, 0.05), 2, 2)
L <- solve(diag(nrow(A))- A)
F_total <- F_uno %*% L
y <- matrix(c(100, 0), 2, 1)

##Scripts and results - sequence from left to right
# build_tree_value(F_uno, A,y, c(1,2, 2, 1), 4) => 0.25
# build_tree_value(F_uno, A,y, c(1,1,1), 3) => 2.25 (0.15 * 0.15 * 100)
# build_tree_value(F_uno, A,y, c(1,2,1), 3) => 5 (0.25 * 0.20 * 100)
# build_tree_value(F_uno, A,y, c(1,2), 2) => 20

sequence <- c(1, 2, 1)




