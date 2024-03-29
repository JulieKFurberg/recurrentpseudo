
<!-- README.md is generated from README.Rmd. Please edit that file -->

# recurrentpseudo: An R package for analysing recurrent events in the presence of terminal events using pseudo-observations

This package computes pseudo-observations for recurrent event data in
the presence of terminal events. Three versions exist: One-dimensional,
two-dimensional or three-dimensional pseudo-observations.

Following the computation of pseudo-observations, the marginal mean
function, survival probability and/or cumulative incidences can be
modelled using generalised estimating equations.

See Furberg et al. (*Bivariate pseudo-observations for recurrent event
analysis with terminal events (2021)*) for technical details on the
procedure.

## Notation

Let $D^*$ denote the survival time and let $N^*(t)$ denote the number of
recurrent events by time $t$. Let $C$ denote the time of censoring. Due
to right-censoring, the data consists of
$X=\lbrace N(\cdot), D, \delta, Z \rbrace$ where
$N(t) = N^*(t \wedge C)$, $D=D^* \wedge C$,
$\delta = I \left( D^* \leq C \right)$ and $Z$ denotes $p$ baseline
covariates.

We observe $X_i=\lbrace N_i(\cdot), D_i, \delta_i, Z_i \rbrace$ for each
individual $i= 1,\ldots, n$.

We consider the marginal mean function, $\mu (t)$, given by $$ 
\mu(t) = E(N^*(t)) = \int_0^t S(u^-) \, d R(u), \quad d R(t) = E(dN^*(t) \mid D^* \geq t)
$$ and the survival probability, $S(t)$, given by $$ 
S(t) = P(D^*> t).
$$

Moreover, we consider the cumulative incidences for death causes 1,
$C_1(t)$, and 2, $C_2(t)$ $$
C_1(t) = E(I(D^* \leq t, \Delta = 1)), \quad C_2(t) = E(I(D^* \leq t, \Delta = 2))
$$ where $\Delta = \lbrace 1, 2 \rbrace$ represents a cause-of-death
indicator.

## Introduction to pseudo-observations

The following section serves as a fast introduction to
pseudo-observations, which the methods of this package is based on.

For more detailed information, please see

-   Andersen and Perme (*Pseudo-observations in survival analysis
    (2010)*) or

-   Andersen, Klein and Rosthøj (*Generalised linear models for
    correlated pseudo-observations, with applications to multi-state
    models (2003)*)

We wish to formulate a model for $$ 
\theta = E(f(X))
$$ where $X=X_1, \ldots, X_n$ denotes a vector of survival times (or
other survival data) for $n$ individuals and $f$ denotes some function.
An example would be $\theta = E(I(D^*>t)) = P(D^*>t)$.

Assume that a sufficiently nice estimator $\hat{\theta}$ of $\theta$
exists. For a fixed time, $t \in [0, \tau]$, the pseudo-observation for
the i’th individual at $t$ is given by $$ 
\hat{\theta}_i (t)= n \cdot \hat{\theta}(t) - (n-1) \cdot \hat{\theta}^{-i}(t)
$$ where $\hat{\theta}(t)$ denotes the estimate based on the total data
set, and $\hat{\theta}^{-i}(t)$ denotes the estimate based on the same
data set but omitting observations from individual i.

Since the survival times are subject to right-censoring, standard
inference on survival data is adjusted to accommodate this, e.g. in
likelihood estimation.

However, since all subjects has a valid pseudo-observation,
$\hat{\theta}_i (t)$, at one or more times, these can be used as an
outcome variable in a generalised linear model. Note, that this is
regardless of the whether a subject is alive, censored or died at time
t.

Assume that $g$ denotes a link function, then we wish to fit

$$
g(E(f(X) \mid Z)) = \xi^T Z.
$$ Following, $f(X)$ is replaced by $\hat{\theta}_i (\cdot)$ in the
model fit.

The model parameters, $\xi$, are estimated using generalised estimating
equations (GEE), see Liang and Zeger (*Longitudinal data analysis using
generalized linear models (1986)*).

The GEE procedure accommodates the fact that each individual can have
several (pseudo-)observations.

## One-dimensional pseudo-observations

The one-dimensional pseudo-observations model is based on the parameter
$\theta = \mu(t)$, which is estimated by $$
\hat{\theta} = \hat{\mu}(t) =  \int_0^t \hat{S}(u^-) \, d \hat{R}(u),
$$ where $\hat{S}(t)$ denotes the Kaplan-Meier estimator of $S(t)$ and
$\hat{R}(t)$ denotes the Nelson-Aalen estimator of $R(t)$.

We assume that $$
\log \left( \mu(t \mid Z) \right) = \log(\mu_0(t)) + \beta^T Z.
$$

## Two-dimensional pseudo-observations

The two-dimensional pseudo-observations model is based on the parameter
$\theta = (\mu(t), S(t))$, which is estimated by $$
\hat{\theta} = \left( \begin{matrix} \hat{\mu}(t) \\ \hat{S}(t) \end{matrix} \right).
$$

We assume that $$
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left( S( t \mid Z) \right) \end{matrix} \right) =  \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + {\beta}^T {Z} \\ \log \left(\Lambda_0(t)\right) + {\gamma}^T {Z}  \end{matrix} \right).
$$

## Three-dimensional pseudo-observations

The three-dimensional pseudo-observations model is based on the
parameter $\theta = (\mu(t), C_1(t), C_2(t))$, which is estimated by $$
\hat{\theta} = \left( \begin{matrix} \hat{\mu}(t) \\ \hat{C}_1(t) \\ \hat{C}_2(t) \end{matrix} \right)
$$ where $\hat{C}_1(t)$ and $\hat{C}_2(t)$ are the Aalen-Johansen
estimates of the cumulative incidences for causes 1, $C_1(t)$, and 2,
$C_2(t)$, respectively.

We assume that $$
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left(1- C_1( t \mid Z) \right) \\ \text{cloglog} \left(1- C_2( t \mid Z) \right) \end{matrix} \right) =  \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + {\beta}^T {Z} \\ \log \left(\Lambda_{10}(t)\right) + {\gamma_1}^T {Z} \\ \log \left(\Lambda_{20}(t)\right) + {\gamma_2}^T {Z}  \end{matrix} \right)
$$

# Install package from GitHub

``` r
require(devtools)

# devtools::install_github("JulieKFurberg/recurrentpseudo", force = TRUE)

require(recurrentpseudo)
```

``` r
# Main functions
#?pseudo.onedim
#?pseudo.twodim
#?pseudo.threedim

#?pseudo.geefit
```

# Example - Bladder cancer data from survival package

The functions in `recurrentpseudo` will be exemplified using the
well-known bladder cancer data from the survival package. This data set
considers data from a clinical cancer trial conducted by the Veterans
Administration Cooperative Urological Research Group (Byar: *The
veterans administration study of chemoprophylaxis for recurrent stage I
bladder tumours: comparisons of placebo, pyridoxine and topical
thiotepa* (1980)) Here, 118 patients with stage I bladder cancer were
randomised to receive placebo, pyridoxine or thiotepa. After
randomisation, information on occurrences of superficial bladder tumours
and any deaths were collected.

We focus on the comparison between placebo and thiotepa ($n=86$ in
total). We model recurrent bladder tumours, and adjust for death (cause
1: bladder cancer disease death, cause 2: other causes).

One-, two- and three-dimensional pseudo-observations are computed based
on a single time point, $t=30$ months.

For the comparison between placebo and thiotepa on recurrent bladder
tumours, the effect measure of interest is the mean ratio $\exp(\beta)$.

``` r
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

We fit the univariate pseudo-observation model using the binary
treatment indicator as covariate, i.e. we model $$
\log \left( \mu(t \mid Z) \right) = \log(\mu_0(t)) + \beta Z
$$

One-dimensional pseudo-observations and GEE fit can be computed using
the following code,

``` r
# Pseudo observations at t = 30
pseudo_bladder_1d <- pseudo.onedim(tstart = bladdersub$start,
                                   tstop = bladdersub$stop,
                                   status = bladdersub$status3,
                                   id = bladdersub$id,
                                   covar_names = "Z",
                                   tk = c(30),
                                   data = bladdersub)
head(pseudo_bladder_1d$outdata)
#>              mu k ts id       Z
#> 1 -0.0004269178 1 30  1 placebo
#> 2 -0.0004269178 1 30  2 placebo
#> 3  1.2359654463 1 30  3 placebo
#> 4  1.0739859010 1 30  4 placebo
#> 5 -0.0958639918 1 30  5 placebo
#> 6  1.0122441163 1 30  6 placebo

# GEE fit
fit_bladder_1d <- pseudo.geefit(pseudodata = pseudo_bladder_1d,
                                covar_names = c("Z"))
fit_bladder_1d
#> $xi
#>                       
#> (Intercept)  0.5590869
#> Zthiotepa   -0.4359054
#> 
#> $sigma
#>             (Intercept)   Zthiotepa
#> (Intercept)  0.02662095 -0.02662095
#> Zthiotepa   -0.02662095  0.07934314
#> 
#> attr(,"class")
#> [1] "pseudo.geefit"

# Treatment differences
xi_diff_1d <- as.matrix(c(fit_bladder_1d$xi[2]), ncol = 1)

mslabels <- c("treat, mu")
rownames(xi_diff_1d) <- mslabels
colnames(xi_diff_1d) <- ""
xi_diff_1d
#>                     
#> treat, mu -0.4359054

# Variance matrix for differences
sigma_diff_1d <- matrix(c(fit_bladder_1d$sigma[2,2]),
                          ncol = 1, nrow = 1,
                          byrow = T)

rownames(sigma_diff_1d) <- colnames(sigma_diff_1d) <- mslabels
sigma_diff_1d
#>            treat, mu
#> treat, mu 0.07934314
```

Thus, the estimated mean ratio is $\exp(\hat{\beta})=$ 0.6466789
(standard error and confidence intervals can be found using the Delta
method).

Alternatively, the bivariate pseudo-observation model using the binary
treatment indicator as covariate can be fitted, i.e.  $$
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left( S( t \mid Z) \right) \end{matrix} \right) = \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + {\beta} {Z} \\ \log \left(\Lambda_0(t)\right) + {\gamma} {Z}  \end{matrix} \right)
$$

Two-dimensional pseudo-observations and GEE fit can be computed using
the following code

``` r
# Pseudo observations at t = 30
pseudo_bladder_2d <- pseudo.twodim(tstart = bladdersub$start,
                                   tstop = bladdersub$stop,
                                   status = bladdersub$status3,
                                   id = bladdersub$id,
                                   covar_names = "Z",
                                   tk = c(30),
                                   data = bladdersub)
head(pseudo_bladder_2d$outdata)
#>              mu          surv k ts id       Z
#> 1 -0.0004269178  1.421085e-14 1 30  1 placebo
#> 2 -0.0004269178  1.421085e-14 1 30  2 placebo
#> 3  1.2359654463  8.170875e-01 1 30  3 placebo
#> 4  1.0739859010  8.170875e-01 1 30  4 placebo
#> 5 -0.0958639918 -5.305763e-02 1 30  5 placebo
#> 6  1.0122441163 -5.305763e-02 1 30  6 placebo

# GEE fit
fit_bladder_2d <- pseudo.geefit(pseudodata = pseudo_bladder_2d,
                                covar_names = c("Z"))
fit_bladder_2d
#> $xi
#>                                  
#> esttypemu              0.55908687
#> esttypemu:Zthiotepa   -0.43590539
#> esttypesurv           -1.41652478
#> esttypesurv:Zthiotepa -0.04800778
#> 
#> $sigma
#>                          esttypemu esttypemu:Zthiotepa  esttypesurv
#> esttypemu              0.026620952        -0.026620952 -0.003481085
#> esttypemu:Zthiotepa   -0.026620952         0.079343139  0.003481085
#> esttypesurv           -0.003481085         0.003481085  0.123251791
#> esttypesurv:Zthiotepa  0.003481085         0.002758847 -0.123251791
#>                       esttypesurv:Zthiotepa
#> esttypemu                       0.003481085
#> esttypemu:Zthiotepa             0.002758847
#> esttypesurv                    -0.123251791
#> esttypesurv:Zthiotepa           0.260915569
#> 
#> attr(,"class")
#> [1] "pseudo.geefit"

# Treatment differences
xi_diff_2d <- as.matrix(c(fit_bladder_2d$xi[2],
                          fit_bladder_2d$xi[4]), ncol = 1)

mslabels <- c("treat, mu", "treat, surv")
rownames(xi_diff_2d) <- mslabels
colnames(xi_diff_2d) <- ""
xi_diff_2d
#>                        
#> treat, mu   -0.43590539
#> treat, surv -0.04800778

# Variance matrix for differences
sigma_diff_2d <- matrix(c(fit_bladder_2d$sigma[2,2],
                          fit_bladder_2d$sigma[2,4],
                          fit_bladder_2d$sigma[2,4],
                          fit_bladder_2d$sigma[4,4]),
                          ncol = 2, nrow = 2,
                          byrow = T)

rownames(sigma_diff_2d) <- colnames(sigma_diff_2d) <- mslabels
sigma_diff_2d
#>               treat, mu treat, surv
#> treat, mu   0.079343139 0.002758847
#> treat, surv 0.002758847 0.260915569
```

Finally, one could fit the three-dimensional pseudo-observation model to
the bladder cancer data.

Three-dimensional pseudo-observations and GEE fit can be computed using
the following code

``` r
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
                                     tk = c(30), 
                                     data = bladdersub)
head(pseudo_bladder_3d$outdata_long)
#>   k ts id esttype             y       Z
#> 1 1 30  1      mu -4.269178e-04 placebo
#> 2 1 30  1    surv  1.421085e-14 placebo
#> 3 1 30  1    cif1  0.000000e+00 placebo
#> 4 1 30  1    cif2  1.000000e+00 placebo
#> 5 1 30  2      mu -4.269178e-04 placebo
#> 6 1 30  2    surv  1.421085e-14 placebo

# GEE fit
fit_bladder_3d <- pseudo.geefit(pseudodata = pseudo_bladder_3d,
                                covar_names = c("Z"))
fit_bladder_3d
#> $xi
#>                                 
#> esttypemu              0.5590869
#> esttypemu:Zthiotepa   -0.4359054
#> esttypecif1           -3.7618319
#> esttypecif1:Zthiotepa  0.2930357
#> esttypecif2           -1.5431978
#> esttypecif2:Zthiotepa -0.1005109
#> 
#> $sigma
#>                          esttypemu esttypemu:Zthiotepa esttypecif1
#> esttypemu              0.026620952        -0.026620952  0.01663610
#> esttypemu:Zthiotepa   -0.026620952         0.079343139 -0.01663610
#> esttypecif1            0.016636098        -0.016636098  1.07839851
#> esttypecif1:Zthiotepa -0.016636098         0.013359996 -1.07839851
#> esttypecif2           -0.006027688         0.006027688 -0.02642283
#> esttypecif2:Zthiotepa  0.006027688         0.001779996  0.02642283
#>                       esttypecif1:Zthiotepa  esttypecif2 esttypecif2:Zthiotepa
#> esttypemu                       -0.01663610 -0.006027688           0.006027688
#> esttypemu:Zthiotepa              0.01336000  0.006027688           0.001779996
#> esttypecif1                     -1.07839851 -0.026422825           0.026422825
#> esttypecif1:Zthiotepa            2.01305239  0.026422825          -0.057715255
#> esttypecif2                      0.02642283  0.138167379          -0.138167379
#> esttypecif2:Zthiotepa           -0.05771525 -0.138167379           0.299045959
#> 
#> attr(,"class")
#> [1] "pseudo.geefit"

# Treatment differences
xi_diff_3d <- as.matrix(c(fit_bladder_3d$xi[2],
                          fit_bladder_3d$xi[4],
                          fit_bladder_3d$xi[6]), ncol = 1)

mslabels <- c("treat, mu", "treat, cif1", "treat, cif2")
rownames(xi_diff_3d) <- mslabels
colnames(xi_diff_3d) <- ""
xi_diff_3d
#>                       
#> treat, mu   -0.4359054
#> treat, cif1  0.2930357
#> treat, cif2 -0.1005109


# Variance matrix for differences
sigma_diff_3d <- matrix(c(fit_bladder_3d$sigma[2,2],
                          fit_bladder_3d$sigma[2,4],
                          fit_bladder_3d$sigma[2,6],

                          fit_bladder_3d$sigma[2,4],
                          fit_bladder_3d$sigma[4,4],
                          fit_bladder_3d$sigma[4,6],

                          fit_bladder_3d$sigma[2,6],
                          fit_bladder_3d$sigma[4,6],
                          fit_bladder_3d$sigma[6,6]

                          ),
                        ncol = 3, nrow = 3,
                        byrow = T)

rownames(sigma_diff_3d) <- colnames(sigma_diff_3d) <- mslabels
sigma_diff_3d
#>               treat, mu treat, cif1  treat, cif2
#> treat, mu   0.079343139  0.01336000  0.001779996
#> treat, cif1 0.013359996  2.01305239 -0.057715255
#> treat, cif2 0.001779996 -0.05771525  0.299045959
```

We can compare the three model fits. Note, that the $\mu$ components
match each other.

``` r
# Compare - should match for mu elements 
xi_diff_1d
#>                     
#> treat, mu -0.4359054
xi_diff_2d
#>                        
#> treat, mu   -0.43590539
#> treat, surv -0.04800778
xi_diff_3d
#>                       
#> treat, mu   -0.4359054
#> treat, cif1  0.2930357
#> treat, cif2 -0.1005109

sigma_diff_1d
#>            treat, mu
#> treat, mu 0.07934314
sigma_diff_2d
#>               treat, mu treat, surv
#> treat, mu   0.079343139 0.002758847
#> treat, surv 0.002758847 0.260915569
sigma_diff_3d
#>               treat, mu treat, cif1  treat, cif2
#> treat, mu   0.079343139  0.01336000  0.001779996
#> treat, cif1 0.013359996  2.01305239 -0.057715255
#> treat, cif2 0.001779996 -0.05771525  0.299045959
```

### More covariates

Assume that we wish to add extra baseline covariates to the model fit.
For the sake of illustration, we have simulated a continuous covariate,
$Z_2$, and a categorical covariate, $Z_3$. The covariate $Z_1$
corresponds to the binary treatment covariate ($Z=1$ is thiotepa and
$Z=0$ is placebo). In order to make estimation for these models
possible, the pseudo-observations are calculated at three time points,
namely $t=20, 30, 40$ months.

For the one-dimensional model for $\mu$ it holds that,

$$
\log \left( \mu(t \mid Z) \right) = \log(\mu_0(t)) + \beta_1 Z_1 + \beta_2 Z_2 + \beta_3 Z_3.
$$

This can be fitted using the below code,

``` r
## One-dim
# A binary variable, Z1_
# A continuous variable, Z2_
# A categorical variable, Z3_
set.seed(0308)
require(magrittr)
require(dplyr)

bladdersub <- as.data.frame(
  bladdersub %>% group_by(id) %>% 
  mutate(Z1_ = Z,
         Z2_ = rnorm(1, mean = 3, sd = 1),
         Z3_ = sample(x = c("A", "B", "C"), 
                      size = 1, replace = TRUE, 
                      prob = c(1/4, 1/2, 1/4))
         ))
# head(bladdersub, 20)

# Make pseudo obs at more timepoints (more data)
# Pseudo observations at t = 20, 30, 40
pseudo_bladder_1d_3t <- pseudo.onedim(tstart = bladdersub$start,
                                      tstop = bladdersub$stop,
                                      status = bladdersub$status3,
                                      id = bladdersub$id,
                                      covar_names = c("Z1_", "Z2_", "Z3_"),
                                      tk = c(20, 30, 40),
                                      data = bladdersub)

fit1 <- pseudo.geefit(pseudodata = pseudo_bladder_1d_3t, 
                      covar_names = c("Z1_", "Z2_", "Z3_"))

fit1$xi
#>                        
#> (Intercept)  0.39412273
#> Ztime30      0.42336922
#> Ztime40      0.59966454
#> Z1_thiotepa -0.29479824
#> Z2_         -0.08253287
#> Z3_B         0.01965615
#> Z3_C        -0.38332247
fit1$sigma
#>              (Intercept)       Ztime30       Ztime40  Z1_thiotepa           Z2_
#> (Intercept)  0.136673486 -0.0061702979 -0.0109943095 -0.036100986 -0.0247560186
#> Ztime30     -0.006170298  0.0046658382  0.0061013009  0.001167246  0.0002746085
#> Ztime40     -0.010994310  0.0061013009  0.0100442253  0.005504053 -0.0004015364
#> Z1_thiotepa -0.036100986  0.0011672458  0.0055040527  0.090063224 -0.0078557067
#> Z2_         -0.024756019  0.0002746085 -0.0004015364 -0.007855707  0.0109918233
#> Z3_B        -0.055441417  0.0005892506  0.0051883496  0.037829933 -0.0035769385
#> Z3_C        -0.041748863  0.0075014896  0.0141048652  0.023020550 -0.0082026411
#>                      Z3_B         Z3_C
#> (Intercept) -0.0554414168 -0.041748863
#> Ztime30      0.0005892506  0.007501490
#> Ztime40      0.0051883496  0.014104865
#> Z1_thiotepa  0.0378299330  0.023020550
#> Z2_         -0.0035769385 -0.008202641
#> Z3_B         0.0869004239  0.050773663
#> Z3_C         0.0507736625  0.200303239

fit1$xi[4]
#> [1] -0.2947982
```

Or for two-dimensional pseudo-observations, it holds that

$$
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left( S( t \mid Z) \right) \end{matrix} \right) =  \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + \beta_1 {Z_1} + \beta_2 {Z_2} + \beta_3 {Z_3} \\ \log \left(\Lambda_0(t)\right) + {\gamma_1} Z_1 + {\gamma_2} Z_2 + {\gamma_3} Z_3 \end{matrix} \right).
$$ Or for three-dimensional pseudo-observations, it holds that $$
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left( 1-C_1( t \mid Z) \right) \\ \text{cloglog} \left( 1-C_2( t \mid Z) \right) \end{matrix} \right) =  \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + {\beta_1} {Z_1} + {\beta_2} {Z_2} + {\beta_3} Z_3\\ \log \left(\Lambda_{10}(t)\right) + \gamma_{11} {Z_1} + \gamma_{12} {Z_2} + \gamma_{13} {Z_3} \\ \log \left(\Lambda_{20}(t)\right) + \gamma_{21} {Z_1} + \gamma_{22} {Z_2}  + \gamma_{23} {Z_3} \end{matrix} \right).
$$

These two models are fitted using the below code,

``` r
## Two-dim
# Pseudo observations at t = 20, 30, 40
pseudo_bladder_2d_3t <- pseudo.twodim(tstart = bladdersub$start,
                                      tstop = bladdersub$stop,
                                      status = bladdersub$status3,
                                      id = bladdersub$id,
                                      covar_names = c("Z1_", "Z2_", "Z3_"),
                                      tk = c(20, 30, 40),
                                      data = bladdersub)

fit2 <- pseudo.geefit(pseudodata = pseudo_bladder_2d_3t, 
                      covar_names = c("Z1_", "Z2_", "Z3_"))

# fit2$xi
# fit2$sigma


## Three-dim
pseudo_bladder_3d_3t <- pseudo.threedim(tstart = bladdersub$start,
                                        tstop = bladdersub$stop,
                                        status = bladdersub$status3,
                                        id = bladdersub$id,
                                        covar_names = c("Z1_", "Z2_", "Z3_"),
                                        deathtype = bladdersub$deathtype,
                                        tk = c(20, 30, 40),
                                        data = bladdersub)

fit3 <- pseudo.geefit(pseudodata = pseudo_bladder_3d_3t, 
                      covar_names = c("Z1_", "Z2_", "Z3_"))

# fit3$xi
# fit3$sigma

## Compare for mu
fit1$xi[4]
#> [1] -0.2947982
fit2$xi[4]
#> [1] -0.2947982
fit3$xi[4]
#> [1] -0.2948043
```

# Citation

To cite the `recurrentpseudo` package please use the following
references,

> Julie K. Furberg, Per K. Andersen, Sofie Korn, Morten Overgaard,
> Henrik Ravn: Bivariate pseudo-observations for recurrent event
> analysis with terminal events (Lifetime Data Analysis, 2021)
