---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# recurrentpseudo: An R package for analysing recurrent events in the presence of terminal events using pseudo-observations

<!-- badges: start -->
<!-- badges: end -->

This package computes pseudo-observations for recurrent event data in the presence of terminal events. Three versions exist: One-dimensional, two-dimensional or three-dimensional pseudo-observations. 


## Notation 
Let $D^*$ denote the survival time and let $N^*(t)$ denote the number of recurrent events by time $t$. 
Let $C$ denote the time of censoring. 
Due to right-censoring, the data consists of $X=\lbrace N(\cdot), D, \delta, Z \rbrace$ where $N(t) = N^*(t \wedge C)$, $D=D^* \wedge C$, $\delta = I \left( D^* \leq C \right)$ and $Z$ denotes $p$ baseline covariates.

We observe $X_i=\lbrace N_i(\cdot), D_i, \delta_i, Z_i \rbrace$ for each individual $i= 1,\ldots, n$.

We consider the marginal mean function, $\mu (t)$, given by
$$ 
\mu(t) = E(N^*(t)) = \int_0^t S(u^-) \, d R(u), \quad d R(t) = E(dN^*(t) \mid D^* \geq t)
$$
and the survival probability, $S(t)$ given by
$$ 
S(t) = P(D^*> t).
$$ 

Moreover, we consider the cumulative incidences for death causes 1, $C_1(t)$, and 2, $C_2(t)$
$$
C_1(t) = E(I(D^* \leq t, \Delta = 1)), \quad C_2(t) = E(I(D^* \leq t, \Delta = 2))
$$
where $\Delta = \lbrace 1, 2 \rbrace$ represents a cause-of-death indicator. 


## Introduction to pseudo-observations

The following section serves as a fast introduction to pseudo-observations, which the methods of this package is based on. 

For more detailed information, please see 
+ Andersen and Perme (_Pseudo-observations in survival analysis (2010)_) or 
+ Andersen, Klein and Rosthøj (_Generalised linear models for correlated pseudo-observations, with applications to multi-state models (2003)_)

We wish to formulate a model for
$$ 
\theta = E(f(X))
$$ 
where $X=X_1, \ldots, X_n$ denotes a vector of survival times (or other survival data) for $n$ individuals and $f$ denotes some function. 

An example would be $\theta = E(I(D^*>t)) = P(D^*>t)$. 

Assume that a sufficiently nice estimator $\hat{\theta}$ of $\theta$ exists. 

For a fixed time, $t \in [0, \tau]$, the pseudo-observation for the i'th individual at $t$ is given by 
$$ 
\hat{\theta}_i (t)= n \cdot \hat{\theta}(t) - (n-1) \cdot \hat{\theta}^{-i}(t)
$$
where $\hat{\theta}(t)$ denotes the estimate based on the total data set, and $\hat{\theta}^{-i}(t)$ denotes the estimate based on the same data set but omitting observations from individual i. 

Since the survival times are subject to right-censoring, inference based on likelihood is adjusted to accommodate this. 


However, since all subjects has a valid pseudo-observation, $\hat{\theta}_i (t)$, at one or more times, these can be used as an outcome variable in a generalised linear model. 

Note, that this is regardless of the whether a subject is censored or died at time t. 

Assume that $g$ denotes a link function, then we wish to fit

$$
g(E(f(X) \mid Z)) = \xi^T Z.
$$
Following, $f(X)$ is replaced by $\hat{\theta}_i (\cdot)$ in the model fit. 


The model parameters, $\xi$, are estimated using generalised estimating equations, see Liang and Zeger (_Longitudinal data analysis using generalized linear models (1986)_. 

This can accomodate the fact that each individual can have several pseudo-observations if more than one time point is used in the computation. 




## One-dimensional pseudo-observations 
The one-dimensional pseudo-observations model is based on the parameter
$$
\hat{\theta} = \hat{\mu}(t) =  \int_0^t \hat{S}(u^-) \, d \hat{R}(u),
$$ 
where $\hat{S}(t)$ denotes the Kaplan-Meier estimator of $S(t)$ and $\hat{R}(t)$ denotes the Nelson-Aalen estimator of $R(t)$.


## Two-dimensional pseudo-observations 
The two-dimensional pseudo-observations model is based on the parameter
$$
\hat{\theta} = \left( \begin{matrix} \hat{\mu}(t) \\ \hat{S}(t) \end{matrix} \right)
$$ 


## Three-dimensional pseudo-observations 
The three-dimensional pseudo-observations model is based on the parameter
$$
\hat{\theta} = \left( \begin{matrix} \hat{\mu}(t) \\ \hat{C}_1(t) \\ \hat{C}_2(t) \end{matrix} \right)
$$ 
where $\hat{C}_1(t)$ and $\hat{C}_2(t)$ are the Aalen-Johansen estimates of the cumulative incidences for causes 1, $C_1(t)$, and 2, $C_2(t)$, respectively.



# Install package from GitHub



```r
require(devtools)
#> Indlæser krævet pakke: devtools
#> Indlæser krævet pakke: usethis

devtools::install_github("JulieKFurberg/recurrentpseudo")
#> Skipping install of 'recurrentpseudo' from a github remote, the SHA1 (c9e8318e) has not changed since last install.
#>   Use `force = TRUE` to force installation

require(recurrentpseudo)
#> Indlæser krævet pakke: recurrentpseudo
#> Warning: replacing previous import 'dplyr::filter' by 'stats::filter' when
#> loading 'recurrentpseudo'
#> Warning: replacing previous import 'dplyr::lag' by 'stats::lag' when loading
#> 'recurrentpseudo'
```


# Example - Bladder cancer data from survival package


We consider the well-known bladder cancer data from the survival package.

We focus on the comparison between placebo and thiotepa. 


```r
# Example: Bladder cancer data from survival package
require(survival)
#> Indlæser krævet pakke: survival

# Make a three level status variable
bladder1$status3 <- ifelse(bladder1$status %in% c(2, 3), 2, bladder1$status)

# Add one extra day for the two patients with start=stop=0
# subset(bladder1, stop <= start)
bladder1[bladder1$id == 1, "stop"] <- 1
bladder1[bladder1$id == 49, "stop"] <- 1

# Restrict the data to placebo and thiotepa
bladdersub <- subset(bladder1, treatment %in% c("placebo", "thiotepa"))

# Make treatment variable two-level factor
bladdersub$Z <- as.factor(ifelse(bladdersub$treatment == "placebo", 0, 1))
levels(bladdersub$Z) <- c("placebo", "thiotepa")
head(bladdersub)
#>   id treatment number size recur start stop status rtumor rsize enum status3
#> 1  1   placebo      1    1     0     0    1      3      .     .    1       2
#> 2  2   placebo      1    3     0     0    1      3      .     .    1       2
#> 3  3   placebo      2    1     0     0    4      0      .     .    1       0
#> 4  4   placebo      1    1     0     0    7      0      .     .    1       0
#> 5  5   placebo      5    1     0     0   10      3      .     .    1       2
#> 6  6   placebo      4    1     1     0    6      1      1     1    1       1
#>         Z
#> 1 placebo
#> 2 placebo
#> 3 placebo
#> 4 placebo
#> 5 placebo
#> 6 placebo
```


One-dimensional pseudo-observations can be computed using the following code


```r
# Pseudo observations
pseudo_bladder_1d <- pseudo.onedim(tstart = bladdersub$start,
                                   tstop = bladdersub$stop,
                                   status = bladdersub$status3,
                                   id = bladdersub$id,
                                   covar_names = "Z",
                                   tk = c(20, 30, 40),
                                   data = bladdersub)
head(pseudo_bladder_1d$outdata)
#>             mu k ts id       Z
#> 1 0.000000e+00 3 20  1 placebo
#> 2 1.421085e-14 3 30  1 placebo
#> 3 0.000000e+00 3 40  1 placebo
#> 4 0.000000e+00 3 20  2 placebo
#> 5 1.421085e-14 3 30  2 placebo
#> 6 0.000000e+00 3 40  2 placebo

# GEE fit
fit_bladder_1d <- pseudo.geefit(pseudodata = pseudo_bladder_1d,
                                covar_names = c("Z"))
fit_bladder_1d
#> $xi
#>                     
#> Zplacebo  0.44276324
#> Zthiotepa 0.01579732
#> 
#> $sigma
#>            Zplacebo  Zthiotepa
#> Zplacebo  0.0263779 0.00000000
#> Zthiotepa 0.0000000 0.05123865

# Treatment differences
xi_diff_1d <- as.matrix(c(fit_bladder_1d$xi[2] - fit_bladder_1d$xi[1]), ncol = 1)

mslabels <- c("treat, mu")
rownames(xi_diff_1d) <- mslabels
colnames(xi_diff_1d) <- ""
xi_diff_1d
#>                     
#> treat, mu -0.4269659

# Variance matrix for differences
sigma_diff_1d <- matrix(c(fit_bladder_1d$sigma[1,1] + fit_bladder_1d$sigma[2,2]),
                     ncol = 1, nrow = 1,
                     byrow = T)

rownames(sigma_diff_1d) <- colnames(sigma_diff_1d) <- mslabels
sigma_diff_1d
#>            treat, mu
#> treat, mu 0.07761655
```



Two-dimensional pseudo-observations can be computed using the following code


```r
# Pseudo observations
pseudo_bladder_2d <- pseudo.twodim(tstart = bladdersub$start,
                                   tstop = bladdersub$stop,
                                   status = bladdersub$status3,
                                   id = bladdersub$id,
                                   covar_names = "Z",
                                   tk = c(20, 30, 40),
                                   data = bladdersub)
head(pseudo_bladder_2d$outdata)
#>             mu         surv k ts id       Z
#> 1 0.000000e+00 0.000000e+00 3 20  1 placebo
#> 2 1.421085e-14 1.421085e-14 3 30  1 placebo
#> 3 0.000000e+00 1.421085e-14 3 40  1 placebo
#> 4 0.000000e+00 0.000000e+00 3 20  2 placebo
#> 5 1.421085e-14 1.421085e-14 3 30  2 placebo
#> 6 0.000000e+00 1.421085e-14 3 40  2 placebo

# GEE fit
fit_bladder_2d <- pseudo.geefit(pseudodata = pseudo_bladder_2d,
                                covar_names = c("Z"))
fit_bladder_2d
#> $xi
#>                                  
#> Zplacebo:esttypemu     0.44276324
#> Zthiotepa:esttypemu    0.01579732
#> Zplacebo:esttypesurv  -1.50037165
#> Zthiotepa:esttypesurv -1.43404704
#> 
#> $sigma
#>                       Zplacebo:esttypemu Zthiotepa:esttypemu
#> Zplacebo:esttypemu           0.026377895          0.00000000
#> Zthiotepa:esttypemu          0.000000000          0.05123865
#> Zplacebo:esttypesurv        -0.008026568          0.00000000
#> Zthiotepa:esttypesurv        0.000000000          0.01283890
#>                       Zplacebo:esttypesurv Zthiotepa:esttypesurv
#> Zplacebo:esttypemu            -0.008026568             0.0000000
#> Zthiotepa:esttypemu            0.000000000             0.0128389
#> Zplacebo:esttypesurv           0.103835737             0.0000000
#> Zthiotepa:esttypesurv          0.000000000             0.1240161

# Treatment differences
xi_diff_2d <- as.matrix(c(fit_bladder_2d$xi[2] - fit_bladder_2d$xi[1],
                          fit_bladder_2d$xi[4] - fit_bladder_2d$xi[3]), ncol = 1)

mslabels <- c("treat, mu", "treat, surv")
rownames(xi_diff_2d) <- mslabels
colnames(xi_diff_2d) <- ""
xi_diff_2d
#>                       
#> treat, mu   -0.4269659
#> treat, surv  0.0663246


# Variance matrix for differences
sigma_diff_2d <- matrix(c(fit_bladder_2d$sigma[1,1] + fit_bladder_2d$sigma[2,2],
                          fit_bladder_2d$sigma[1,3] + fit_bladder_2d$sigma[2,4],
                          fit_bladder_2d$sigma[1,3] + fit_bladder_2d$sigma[2,4],
                          fit_bladder_2d$sigma[3,3] + fit_bladder_2d$sigma[4,4]),
                          ncol = 2, nrow = 2,
                          byrow = T)

rownames(sigma_diff_2d) <- colnames(sigma_diff_2d) <- mslabels
sigma_diff_2d
#>              treat, mu treat, surv
#> treat, mu   0.07761655  0.00481233
#> treat, surv 0.00481233  0.22785186
```

Three-dimensional pseudo-observations can be computed using the following code


```r
# Add deathtype variable to bladder data
# Deathtype = 1 (bladder disease death), deathtype = 2 (other death reason)
bladdersub$deathtype <- with(bladdersub, ifelse(status == 2, 1, ifelse(status == 3, 2, 0)))
table(bladdersub$deathtype, bladdersub$status)
#>    
#>       0   1   2   3
#>   0  55 132   0   0
#>   1   0   0   2   0
#>   2   0   0   0  20

# Pseudo-observations
pseudo_bladder_3d <- pseudo.threedim(tstart = bladdersub$start,
                                     tstop = bladdersub$stop,
                                     status = bladdersub$status3,
                                     id = bladdersub$id,
                                     deathtype = bladdersub$deathtype,
                                     covar_names = "Z",
                                     tk = c(20, 30, 40),
                                     data = bladdersub)
head(pseudo_bladder_3d$outdata_long)
#>   k ts id esttype            y       Z
#> 1 3 20  1      mu 0.000000e+00 placebo
#> 2 3 20  1    surv 0.000000e+00 placebo
#> 3 3 20  1    cif1 0.000000e+00 placebo
#> 4 3 20  1    cif2 7.283953e+00 placebo
#> 5 3 30  1      mu 1.421085e-14 placebo
#> 6 3 30  1    surv 1.421085e-14 placebo

# GEE fit
fit_bladder_3d <- pseudo.geefit(pseudodata = pseudo_bladder_3d,
                                covar_names = c("Z"))
fit_bladder_3d
#> $xi
#>                                    
#> esttypemu              3.598264e-02
#> esttypemu:Ztime2       4.589506e-01
#> esttypemu:Ztime3       6.398069e-01
#> esttypemu:Zthiotepa   -4.034013e-01
#> esttypecif1           -4.416394e+00
#> esttypecif1:Ztime2     4.668904e-01
#> esttypecif1:Ztime3     4.668904e-01
#> esttypecif1:Zthiotepa  5.701714e-01
#> esttypecif2            7.082247e+17
#> esttypecif2:Ztime2     7.176957e+17
#> esttypecif2:Ztime3     1.138932e+18
#> esttypecif2:Zthiotepa  1.717020e+15
#> 
#> $sigma
#>                           esttypemu esttypemu:Ztime2 esttypemu:Ztime3
#> esttypemu              3.232749e-02    -5.114484e-03    -7.562655e-03
#> esttypemu:Ztime2      -5.114484e-03     5.040221e-03     6.416379e-03
#> esttypemu:Ztime3      -7.562655e-03     6.416379e-03     1.018010e-02
#> esttypemu:Zthiotepa   -3.061933e-02     2.665131e-03     6.100456e-03
#> esttypecif1            1.192316e-02     5.114046e-03     5.114046e-03
#> esttypecif1:Ztime2    -1.772091e-03     6.227435e-04     6.227435e-04
#> esttypecif1:Ztime3    -4.916760e-03    -7.913832e-04    -7.913832e-04
#> esttypecif1:Zthiotepa -1.073970e-02    -2.616266e-03    -2.616266e-03
#> esttypecif2            4.073032e+13     1.031162e+12     1.031162e+12
#> esttypecif2:Ztime2    -2.761373e+13    -1.177545e+11    -1.177545e+11
#> esttypecif2:Ztime3    -6.050363e+13    -4.093913e+11    -4.093913e+11
#> esttypecif2:Zthiotepa -3.642738e+11    -7.608608e+11    -7.608608e+11
#>                       esttypemu:Zthiotepa   esttypecif1 esttypecif1:Ztime2
#> esttypemu                   -3.061933e-02  1.192316e-02       5.114046e-03
#> esttypemu:Ztime2             2.665131e-03 -1.772091e-03       6.227435e-04
#> esttypemu:Ztime3             6.100456e-03 -4.916760e-03      -7.913832e-04
#> esttypemu:Zthiotepa          7.947737e-02 -1.073970e-02      -2.616266e-03
#> esttypecif1                 -1.141588e-02  6.392335e-01       1.531400e-01
#> esttypecif1:Ztime2          -3.159043e-03  1.531400e-01       2.705566e-01
#> esttypecif1:Ztime3          -7.569679e-04  1.531400e-01       2.705566e-01
#> esttypecif1:Zthiotepa        7.573812e-03 -4.736493e-01      -7.297608e-01
#> esttypecif2                 -9.177911e+13 -3.101684e+14       4.322033e+13
#> esttypecif2:Ztime2           6.201602e+13  4.110850e+14       2.210162e+13
#> esttypecif2:Ztime3           1.363155e+14  4.110850e+14       2.210162e+13
#> esttypecif2:Zthiotepa        1.443420e+11 -3.192686e+13      -6.164636e+13
#>                       esttypecif1:Ztime3 esttypecif1:Zthiotepa   esttypecif2
#> esttypemu                   5.114046e-03         -1.141588e-02  4.073032e+13
#> esttypemu:Ztime2            6.227435e-04         -3.159043e-03 -2.761373e+13
#> esttypemu:Ztime3           -7.913832e-04         -7.569679e-04 -6.050363e+13
#> esttypemu:Zthiotepa        -2.616266e-03          7.573812e-03 -3.642738e+11
#> esttypecif1                 1.531400e-01         -4.736493e-01 -3.101684e+14
#> esttypecif1:Ztime2          2.705566e-01         -7.297608e-01  4.110850e+14
#> esttypecif1:Ztime3          2.705566e-01         -7.297608e-01  4.110850e+14
#> esttypecif1:Zthiotepa      -7.297608e-01          2.025684e+00 -3.192686e+13
#> esttypecif2                 4.322033e+13          7.428728e+14  3.523577e+31
#> esttypecif2:Ztime2          2.210162e+13         -9.793537e+14  9.486203e+30
#> esttypecif2:Ztime3          2.210162e+13         -9.793537e+14  1.503653e+31
#> esttypecif2:Zthiotepa      -6.164636e+13          2.000288e+14 -5.868653e+31
#>                       esttypecif2:Ztime2 esttypecif2:Ztime3
#> esttypemu                   1.031162e+12       1.031162e+12
#> esttypemu:Ztime2           -1.177545e+11      -1.177545e+11
#> esttypemu:Ztime3           -4.093913e+11      -4.093913e+11
#> esttypemu:Zthiotepa        -7.608608e+11      -7.608608e+11
#> esttypecif1                 4.322033e+13       4.322033e+13
#> esttypecif1:Ztime2          2.210162e+13       2.210162e+13
#> esttypecif1:Ztime3          2.210162e+13       2.210162e+13
#> esttypecif1:Zthiotepa      -6.164636e+13      -6.164636e+13
#> esttypecif2                 9.486203e+30       1.503653e+31
#> esttypecif2:Ztime2          9.586566e+30       1.521112e+31
#> esttypecif2:Ztime3          1.521112e+31       2.413689e+31
#> esttypecif2:Zthiotepa      -4.427555e+28      -3.081933e+28
#>                       esttypecif2:Zthiotepa
#> esttypemu                     -9.177911e+13
#> esttypemu:Ztime2               6.201602e+13
#> esttypemu:Ztime3               1.363155e+14
#> esttypemu:Zthiotepa            1.443420e+11
#> esttypecif1                    7.428728e+14
#> esttypecif1:Ztime2            -9.793537e+14
#> esttypecif1:Ztime3            -9.793537e+14
#> esttypecif1:Zthiotepa          2.000288e+14
#> esttypecif2                   -5.868653e+31
#> esttypecif2:Ztime2            -4.427555e+28
#> esttypecif2:Ztime3            -3.081933e+28
#> esttypecif2:Zthiotepa          1.330765e+32

# Treatment differences
xi_diff_3d <- as.matrix(c(fit_bladder_3d$xi[2] - fit_bladder_3d$xi[1],
                          fit_bladder_3d$xi[4] - fit_bladder_3d$xi[3],
                          fit_bladder_3d$xi[6] - fit_bladder_3d$xi[5]), ncol = 1)

mslabels <- c("treat, mu", "treat, cif1", "treat, cif2")
rownames(xi_diff_3d) <- mslabels
colnames(xi_diff_3d) <- ""
xi_diff_3d
#>                      
#> treat, mu    0.422968
#> treat, cif1 -1.043208
#> treat, cif2  4.883285


# Variance matrix for differences
sigma_diff_3d <- matrix(c(fit_bladder_3d$sigma[1,1] + fit_bladder_3d$sigma[2,2],
                          fit_bladder_3d$sigma[1,3] + fit_bladder_3d$sigma[1,5],
                          fit_bladder_3d$sigma[1,4] + fit_bladder_3d$sigma[1,6],

                          fit_bladder_3d$sigma[1,3] + fit_bladder_3d$sigma[1,5],
                          fit_bladder_3d$sigma[3,3] + fit_bladder_3d$sigma[4,4],
                          fit_bladder_3d$sigma[3,5] + fit_bladder_3d$sigma[4,6],

                          fit_bladder_3d$sigma[1,4] + fit_bladder_3d$sigma[1,6],
                          fit_bladder_3d$sigma[3,5] + fit_bladder_3d$sigma[4,6],
                          fit_bladder_3d$sigma[5,5] + fit_bladder_3d$sigma[6,6]

                          ),
                        ncol = 3, nrow = 3,
                        byrow = T)

rownames(sigma_diff_3d) <- colnames(sigma_diff_3d) <- mslabels
sigma_diff_3d
#>                treat, mu  treat, cif1  treat, cif2
#> treat, mu    0.037367709  0.004360506 -0.025505284
#> treat, cif1  0.004360506  0.089657474 -0.007533026
#> treat, cif2 -0.025505284 -0.007533026  0.909790069
```



```r
###----------------------- Compare - should match for some elements ---------------------------###

xi_diff_1d
#>                     
#> treat, mu -0.4269659
xi_diff_2d
#>                       
#> treat, mu   -0.4269659
#> treat, surv  0.0663246
xi_diff_3d
#>                      
#> treat, mu    0.422968
#> treat, cif1 -1.043208
#> treat, cif2  4.883285

sigma_diff_1d
#>            treat, mu
#> treat, mu 0.07761655
sigma_diff_2d
#>              treat, mu treat, surv
#> treat, mu   0.07761655  0.00481233
#> treat, surv 0.00481233  0.22785186
sigma_diff_3d
#>                treat, mu  treat, cif1  treat, cif2
#> treat, mu    0.037367709  0.004360506 -0.025505284
#> treat, cif1  0.004360506  0.089657474 -0.007533026
#> treat, cif2 -0.025505284 -0.007533026  0.909790069
```



```r
# if more than a binary treat

# Treatment, binary variable:
pseudo_bladder_1d$outdata_long$Z1_ <- as.factor(pseudo_bladder_1d$outdata_long$Z)

# A continuous variable
pseudo_bladder_1d$outdata_long$Z2_ <- rnorm(nrow(pseudo_bladder_1d$outdata_long), mean = 3, sd = 1)

# A categorical variable
pseudo_bladder_1d$outdata_long$Z3_ <- sample(x = c("A", "B", "C"), 
                                 size = nrow(pseudo_bladder_1d$outdata_long), 
                                 replace = TRUE, 
                                 prob = c(1/4, 1/2, 1/4))

fit1 <- pseudo.geefit(pseudodata = pseudo_bladder_1d, 
                      covar_names = c("Z1_", "Z2_", "Z3_"))

fit1$xi
fit1$sigma

```

# Citation 
To cite the `recurrentpseudo` package please use the following references,

> Julie K. Furberg, Per K. Andersen, Sofie Korn, Morten Overgaard, Henrik Ravn: Bivariate pseudo-observations for recurrent event analysis with terminal events (Lifetime Data Analysis, 2021)

