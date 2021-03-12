#Matrix computations
#install.packages("R.matlab")
#install.packages("pracma")

 #Loading libraries
library(R.matlab)
library(pracma)

#Loading the uslci package
uslci <- readMat("/home/nanvizhai/Downloads/E-resource files for Chapter 9 (Advanced LCA)/US LCI Process Matrix Matlab version/USLCI.mat")

#checking datasets
str(uslci)
uslci[1]
names(uslci)
class(uslci)
dim(uslci)
summary(uslci)
class(plist[[1000]])
uslci$funct.units

# replicate the function unit for 746 rows so as to make a matrix of 746r x 746c
funct_unit_matrix <- repmat(uslci$funct.units, 746,1)

# Atech_raw / funct_unit_matrix  to give a normalized technology matrix divided by its functional unit

norm_Atech_raw <- uslci$USLCI.Atech.raw / funct_unit_matrix

# Creating a diagnol matrix
I_mat <- diag(1, 746, 746)

# inv(I-A) matrix
L = solve(I_mat - norm_Atech_raw)

#final demand matrix
y = zeros(746,1)

#Environmental matrix
dim(uslci$env.factors)

env_func_units <- repmat(uslci$funct.units, 949,1)

env_fact_norm = uslci$env.factors / env_func_units

dim(uslci$env.factors.norm) == dim(env_fact_norm)
all(uslci$env.factors.norm == env_fact_norm)
identical(uslci$env.factors.norm , env_fact_norm)
all.equal(uslci$env.factors.norm, env_fact_norm)

#matequal function
matequal <- function(x, y)
  is.matrix(x) && is.matrix(y) && dim(x) == dim(y) && all(x == y)

#checking using grep - grep("carbon dioxide",uslci$US.LCI.EnvFactor)
co2_fossil <- env_fact_norm[231,]

#checking bituminous coal fired electricity process
grep("bituminous", uslci$US.LCI.Processes)
y[416,1] <- 3.6  # 3.6 MJ per kwh

# calculating output = inv(I-A) * final demand which is L * y
out <- L %*% y 

# Environment matrix co2_out

co2_out <- co2_fossil %*% out  # 1.033406

co2_outcols <- diag(co2_fossil) %*% out # Co2 emissions by sector [746 x 746] * [746 * 1] = 746 * 1
sum(co2_outcols) # 1.033406

# Adding index as second element

co2_df <- as.data.frame(co2_outcols)
co2_df$index <- seq.int(nrow(co2_df))
subset(co2_df, co2_df$V1 !=0)



uslci_process <- data.frame(name = character(),
                            unit = character(),
                            name_1 = character(),
                            unit_1 = character()
                            )

new_df <- data.frame(matrix(NA, nrow= 746, ncol=4))
new_df$X1 <- uslciproc_df[1:746,]
new_df$X2 <- uslciproc_df[747:1492,]
new_df$X3 <- uslciproc_df[1493:2238,]
new_df$X4 <- uslciproc_df[2239:2984,]
new_df$index <- seq.int(nrow(new_df))

uslci_process <- new_df[,c("index","X1", "X2")]
names(uslci_process[,1:2]) <- c("ProcessName", "Unit")

colnames(uslci_process) <- c("index", "Process", "Unit")

co2_outcols$Process <- uslci_process$Process
co2_df$Process <- uslci_process$Process

subset(co2_df, co2_df$V1 !=0)




