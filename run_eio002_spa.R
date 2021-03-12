dir_path="/home/nanvizhai/Documents/brightway/mrio/spa_codes"
setwd(dir_path)
dir_files <- list.files()
r_files <- dir_files[-c(6,7)]

#Loading 
library(R.matlab)
library(pracma)

#linux
eio_02 <-readMat("/home/nanvizhai/Documents/brightway/mrio/spa_codes/matlab_spa_code/EIO02.mat") 
#mac 
eio_02 <- readMat("/Users/maghimaimarcus/pCloud Drive/Backups/LCAsoftwares/brightway/Documentation/lca_textbook/e_resources/E-resource files for Chapter 12 (Adv Hotspot and Path Analysis)/2002 EIOLCA Matlab (no energy or GHGs)/EIO02.mat")
F_uno <- ones(1, 428)
A <-eio_02$A02ic 
dim(A)
sector_names <- eio_02$EIOsecnames
L <- eio_02$L02ic
F_total <- F_uno %*% L
y <- zeros(428, 1)
y[70, 1] <- 1
percent = 1
T_max <- 4
thresh_banner <-  1
filename <- "soda_1mil"

spaeio002(F_uno, A, y, F_total, T_max, percent, filename, sectornames, thresh_banner)
