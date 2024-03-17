data_last <- read.csv("~/Desktop/data/data_last.csv")
data_mkt_cap <- read.csv("~/Desktop/data/data_mkt_cap.csv")
data_sector <- read.csv("~/Desktop/data/data_sector.csv")
data_volume <- read.csv("~/Desktop/data/data_volume.csv")
combine_data =cbind(data_last, data_mkt_cap[,3],data_volume[,3])
for(row in 1:nrow(combine_data)) {
  if(any(is.na(combine_data[row,]))){
    combine_data[row,3:5]=rep(0,3) 
  }
}

N = nrow(data_sector)   # no. of stocks
NT = nrow(combine_data)/N   # no. of time points
NZ = 3   # no. of covariates(1, mkt cap, volume)
y=array(NA,dim=c(N,NT))
x=array(1,dim=c(N,NT,NZ))
z=as.numeric(factor(data_sector[,2]))
NS = max(z)   # no. of sectors/ mixture components

for(i in 1:N){
  y[i,]=combine_data[c((1+1599*(i-1)): (1599*i)), 3] 
  for(k in 2:NZ)
  x[i,,k]=combine_data[c((1+1599*(i-1)): (1599*i)), 4+k-2]
}

# Define the likelihood function for the latent class model
logLik_latent_class <- function(parameters, y, x, z) {
  loglik <- 0
  parameters <- matrix(parameters, nrow = NS, ncol = NZ)
  for (i in 1:N) {
    for (t in 1:NT) {
      s <- z[i]
      beta_s <- parameters[s,]
      residual <- y[i, t] - (beta_s %*% x[i, t,  ])
      loglik <- loglik + dnorm(residual, mean = 0, sd = 1, log = TRUE)
    }
  }
  
  return(-loglik) # Negative log-likelihood for minimization
}

initial_parameters <- matrix(rnorm(NS * NZ), nrow = NS, ncol = NZ)


fit <- optim(
  fn = logLik_latent_class,
  par = initial_parameters,
  y = y,
  x = x,
  z = z,
  method = "L-BFGS-B"
)

estimated_parameters <- fit$par

est_y =array (NA,dim=c(N,NT))
for (i in 1:N) {
  for (t in 1:NT) {
    s <- z[i]
    beta_s <- as.vector(estimated_betas[,s])
    est_y[i,t] <-beta_s %*% c(1, x[i, t,  ])
  }
}
# 1332 JT example trace
plot(x=c(1:NT), y[1,],xlab = 'time', ylab = '1332 JT')
line(x=c(1:NT), est_y[1,])

# Load required packages
#library(mclust)
#data <- cbind(as.vector(y), matrix(as.vector(x), ncol = NZ))
#colnames(data) <- c("y", paste0("x", 1:NZ))

# estimate latent class model parameters
#fit <- Mclust(data, G = NS, modelNames = "EII")

#estimated_betas <- fit$parameters$mean


