# Y-Intercept Coding Test

## Model
  
- Given data
  
  $Y_{it}$: price of stock i at time point t,
  
  $Z_{i}$: latent class of stock i, taking values {1,2,...,S} based on its corresponding sector,
  
  $X_{it}$: existing covariates of of stock i at time point t, including volume and mkt_cap.

  
- Latent Class Model: $$[Y_{it}|Z_{i}=s] = \mu_s + \beta_s' X_{it} +\delta_{it}$$
  where $\mu_s$, $\beta_s$ are class specific intercept and coefficients, $\delta_{it}$ is the residual term of stock i at time point t.
  
## Estimation 

- logLik_latent_class

  This is the function designed for calculation of the log-likelihood functions of the model

- fit

  This is designed for estimation of the parameters by minimizing the target log-likelihood functions, methods used here is "L-BFGS-B"

- Notes

  The specified method may not be the best option out of efficiency, advantageous replacements could be Nelder-Mead, Genetic Algorithms or Particle Swarm Optimization

## Output

- $\hat{\beta}_s$:

  parameters for every latent class, including the intercept term and the 2 coefficients for volume and mkt_cap
 
- $\hat{Y}_{it}$:

  estimated price of stock i at time point t, calulated based on the model and the estimated $\hat{\beta}_s$

## Strategy

  Suppose the $\hat{Y}_{it}$ is higher than current value, we buy in stock i, otherwise sell out.

## Discussion

  Due to time limitation, only latent class model with linear effect is considered. Further expansion could be
  - autoregression effect from time series point of view,
  - more covariates and information for the stocks, interest and market level,
  - truncational/functional effect of the covariates,
  - potential factors based on additional information.
  
