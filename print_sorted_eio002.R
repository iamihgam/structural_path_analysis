#check print(sprintf) statements
#check fopen, fclose and save statements statements
print_sorted_eio002 <- function(sorted, T_max, percent, Total_Emissions, filename, sectornames, thresh_banner){
	#print sorted paths to file
	paths <- length(sorted)
	fid <- read.csv(filename.csv)
	if(thresh_banner == 1){
		#check output clearly
		print(sprintf("Paths = %d, T_max = %d, percent = %2.5f, Total Effects= %d\n", paths, T_max, percent, Total_Emissions))
	}
	save(sorted, "sorted.RData")
	for (i in seq_along(1:paths)){
		#
		print(sprintf("%5d:%5d:%2.4f:%2.4f", i, length(sorted[i]$sequence)-1, sorted[i]$value[1], sorted[i]$value[2]))
		for (j in seq_along(1: length(sorted[i]$sequence))){
			print(sprintf("%c %d %c %s", ":", sorted[i]$sequence[j], ":", as.character(sorted[i]$sequence[j], 1)))
		}
	}
		print(fid)
	}

