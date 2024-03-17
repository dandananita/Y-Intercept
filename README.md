# Y-Intercept Coding Test

##Model Description
  
  - Given data
  
  $Y_{it}$: price of stock i at time point t,
  
  $Z_{i}$: latent class of stock i, taking values {1,2,...,S}
  
  $X_{it}$: existing covariates of of stock i at time point t,
  
  - Latent Class Model: $$[Y_{it}|Z_{i}=s] = \mu_s + \beta_s' X_{it} +\delta_{it}$$,
  where $ \mu_s$, $\beta_s$ are class specific intercept and coeffcients, \delta_{it} is the residual term of stock i at time point t.
  
## Estimation 
