# Matrix Computations in R
# To create an Identity matrix
n = 2L
I <- diag(n)

A <- matrix(c(.15, .2, .25, .05), 2)

InvIA = solve(I-A)

#Final demand $100 billion for sectors 1 and 2.
Y1 <- matrix(c(100,0))
Y2 <- matrix(c(0,100))

#Total requirements for sectors 1 and 2

tot_req_Y1 <- InvIA %*% Y1
tot_req_Y2 <- InvIA %*% Y2

I_plus_A <- I+A

#Calculating direct requirements for respective sectors
dir_req_Y1 = I_plus_A %*% Y1
dir_req_Y2 = I_plus_A %*% Y2

# Matrix R gives output of  gram CO2 emissions per dollar for each sector
R <- matrix(c(50, 0, 0, 5),2)

# Dir emissions R * (I+A) * Y
dir_emi_Y1 <- R %*% dir_req_Y1
dir_emi_Y2 <- R %*% dir_req_Y2
sum(dir_emi_Y1) # Total direct emissions Y1
sum(dir_emi_Y2) # Total direct emissions Y2

# Total emissions R* inv(I-A)*Y
tot_emi_Y1 <- R %*% tot_req_Y1 
tot_emi_Y2 <- R %*% tot_req_Y2
sum(tot_emi_Y1) # Total emissions Y1
sum(tot_emi_Y2) # Total emissions Y2

# Indirect emissions
indir_emi_Y1 <- sum(tot_emi_Y1) - sum(dir_emi_Y1) # Indirect emissions Y1
indir_emi_Y2 <- sum(tot_emi_Y2) - sum(dir_emi_Y2) # Indirect emissions Y2


## Process based LCA
Out <- matrix(c(20, 0, 0, 10),2) # diagnol matrix of outputs 20 liters and 10 kWh
In <- matrix(c(0,0,2,0),2) # input of 2 fuel liters to process 2
A <- Out- In # technosphere matrix
inv_A <- solve(A)

# for a final demand of 100 kWh of electricity, total requirement X = inv_A * Y(final demand)

Y= matrix(c(0,100))

X = inv_A %*% Y  # 1 litre of fuel oil and 10 kwh of electricity

# Environmental matrix = BX , where B is a matrix of emissions(+ve) and resource uses(-ve).

B = matrix(c(-50, 2, 10, 0, 0.1, 1), 3,2) # B Crude oil, SO2 and CO2 row wise; P1, P2 Process wise

E = B %*% X # 50 kg of crude oil input, 3 kg of SO2 and 20 kg of CO2

# Exercises
#9.1 
A  <- matrix(c(20, -1, 0, 10),2)

#9.2 
A <- 





