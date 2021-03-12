#!/bin/Rscript

#loading libraries
library(R.matlab)
library(pracma)
#library(tidyverse)


#Creating the A matrix a two by two sector matrix
A <- matrix(c(.15, .2, .25, .05), 2,2)
message("A-matrix")
print(A)


# R waste matrix 
# Assigning number of rows to <rows> and number of <columns> to cols
# and creating a list matrix of sector names which is a n*1 matrix
rows <- nrow(A)
cols <- ncol(A)
sector_names <- matrix(list(), rows, 1) # creating a empty matrix of list akin to cell command in matlab
#creating sector names
for (i in range(1:rows)){
	sector_names[i] <- paste("Sector-", i, sep="")
	}
message("Sector names")
print(sector_names)

# L matrix is [I-A]^-1 , when multiplied with final demand(Y), it gives total requirement matrix
L <- solve(diag(nrow(A)) - A)

# Final demand Y for single unit - Always use matrix for 2d arrays and for more than 2d use array commands
#F <- array(c(1, 1)) # creates a dimension of 1 row and  2 columns [for 1 unit output from sec 1 and 2]
F_uno <- matrix(c(1,1), 1, 2) # final demand of 1 unit output per sector
F_total <- F_uno %*% L


# Final demand of Y is 100 billion dollars
Y_hundred <- matrix(c(100, 0), 2,1)
Total_requirement <- F_total %*% Y_hundred
message("Total requirement for final demand of 100 billion from sector 1")
print(Total_requirement)# 151.8152 dollars for sector 1 
# The formula of Total_effects is similar to <L %*% Y_hundred %>% sum(.)>



# Waste matrix 
R= matrix(c(50, 5))
Waste_grams <- L %*% Y_hundred %*% t(R)
message("Total waste output from each nodes")
print(Waste_grams)
waste_sum <- R %*% Total_requirement
message("Summarized waste output per each sector")
print(waste_sum)
# Waste output 7590 grams from sector 1 and 759 grams from sector 2
# name conventions
# F => F_uno
# F_total => F_total
# A =>
# y => Y_hundred
# sectornames => sector_names
percent <- 0.01 # cut=off of upstream lci of total emissions
T_max <- 4 # Maximum tiers to search 		
thresh_banner=1
filename = "RunSPA"

# formula for calculating SPAEIO_02 
# (Structural path Analysis environmental input output analysis)
spaeio002(F_uno, L, F_total, T_max, percent, filename, sector_names, thresh_banner)


##EIO02.mat
library(R.matlab)
library(pracma)

#Reading the file
eio2002 <- readMat("/home/nanvizhai/Documents/brightway/mrio/lca_textbook/e_resources/eresource_chap12/2002 EIOLCA Matlab (no energy or GHGs)/EIO02.mat")
