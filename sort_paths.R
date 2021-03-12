sort_paths <- function(paths){
     # sort the paths by value
     #write.csv(paths, filepath/paths.csv)
     N <- length(paths)
     while (i <= N){
     largest <- -1e10
     largest_index <- 0
     for(j in 1:N){
		if(paths[j]$value[1] > largest){
			largest <- paths[j]$value[1]
			largest_index <- j
			}
		}
	 if(largest_index > 0){
		temp <- paths[i]
		paths[i] <- paths(largest_index)
		paths[largest_index] <- temp
		}
	 i = i+1
	 }
sorted <- paths
}
