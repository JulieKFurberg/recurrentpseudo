
<!-- README.md is generated from README.Rmd. Please edit that file -->

# recurrentpseudo: An R package for analysing recurrent events in the presence of terminal events using pseudo-observations

<!-- badges: start -->
<!-- badges: end -->

This package computes pseudo-observations for recurrent event data in
the presence of terminal events. Three versions exist: One-dimensional,
two-dimensional or three-dimensional pseudo-observations.

## Notation

Let
![D^\*](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;D%5E%2A "D^*")
denote the survival time and let
![N^\*(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;N%5E%2A%28t%29 "N^*(t)")
denote the number of recurrent events by time
![t](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;t "t").
Let
![C](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;C "C")
denote the time of censoring. Due to right-censoring, the data consists
of
![X=\\lbrace N(\\cdot), D, \\delta, Z \\rbrace](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;X%3D%5Clbrace%20N%28%5Ccdot%29%2C%20D%2C%20%5Cdelta%2C%20Z%20%5Crbrace "X=\lbrace N(\cdot), D, \delta, Z \rbrace")
where
![N(t) = N^\*(t \\wedge C)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;N%28t%29%20%3D%20N%5E%2A%28t%20%5Cwedge%20C%29 "N(t) = N^*(t \wedge C)"),
![D=D^\* \\wedge C](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;D%3DD%5E%2A%20%5Cwedge%20C "D=D^* \wedge C"),
![\\delta = I \\left( D^\* \\leq C \\right)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cdelta%20%3D%20I%20%5Cleft%28%20D%5E%2A%20%5Cleq%20C%20%5Cright%29 "\delta = I \left( D^* \leq C \right)")
and
![Z](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Z "Z")
denotes
![p](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;p "p")
baseline covariates.

We observe
![X_i=\\lbrace N_i(\\cdot), D_i, \\delta_i, Z_i \\rbrace](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;X_i%3D%5Clbrace%20N_i%28%5Ccdot%29%2C%20D_i%2C%20%5Cdelta_i%2C%20Z_i%20%5Crbrace "X_i=\lbrace N_i(\cdot), D_i, \delta_i, Z_i \rbrace")
for each individual
![i= 1,\\ldots, n](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;i%3D%201%2C%5Cldots%2C%20n "i= 1,\ldots, n").

We consider the marginal mean function,
![\\mu (t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cmu%20%28t%29 "\mu (t)"),
given by

![ 
\\mu(t) = E(N^\*(t)) = \\int_0^t S(u^-) \\, d R(u), \\quad d R(t) = E(dN^\*(t) \\mid D^\* \\geq t)
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%20%0A%5Cmu%28t%29%20%3D%20E%28N%5E%2A%28t%29%29%20%3D%20%5Cint_0%5Et%20S%28u%5E-%29%20%5C%2C%20d%20R%28u%29%2C%20%5Cquad%20d%20R%28t%29%20%3D%20E%28dN%5E%2A%28t%29%20%5Cmid%20D%5E%2A%20%5Cgeq%20t%29%0A " 
\mu(t) = E(N^*(t)) = \int_0^t S(u^-) \, d R(u), \quad d R(t) = E(dN^*(t) \mid D^* \geq t)
")

and the survival probability,
![S(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;S%28t%29 "S(t)")
given by

![ 
S(t) = P(D^\*\> t).
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%20%0AS%28t%29%20%3D%20P%28D%5E%2A%3E%20t%29.%0A " 
S(t) = P(D^*> t).
")

Moreover, we consider the cumulative incidences for death causes 1,
![C_1(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;C_1%28t%29 "C_1(t)"),
and 2,
![C_2(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;C_2%28t%29 "C_2(t)")

![
C_1(t) = E(I(D^\* \\leq t, \\Delta = 1)), \\quad C_2(t) = E(I(D^\* \\leq t, \\Delta = 2))
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0AC_1%28t%29%20%3D%20E%28I%28D%5E%2A%20%5Cleq%20t%2C%20%5CDelta%20%3D%201%29%29%2C%20%5Cquad%20C_2%28t%29%20%3D%20E%28I%28D%5E%2A%20%5Cleq%20t%2C%20%5CDelta%20%3D%202%29%29%0A "
C_1(t) = E(I(D^* \leq t, \Delta = 1)), \quad C_2(t) = E(I(D^* \leq t, \Delta = 2))
")

where
![\\Delta = \\lbrace 1, 2 \\rbrace](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5CDelta%20%3D%20%5Clbrace%201%2C%202%20%5Crbrace "\Delta = \lbrace 1, 2 \rbrace")
represents a cause-of-death indicator.

## Introduction to pseudo-observations

The following section serves as a fast introduction to
pseudo-observations, which the methods of this package is based on.

For more detailed information, please see + Andersen and Perme
(*Pseudo-observations in survival analysis (2010)*) or + Andersen, Klein
and Rosthøj (*Generalised linear models for correlated
pseudo-observations, with applications to multi-state models (2003)*)

We wish to formulate a model for

![ 
\\theta = E(f(X))
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%20%0A%5Ctheta%20%3D%20E%28f%28X%29%29%0A " 
\theta = E(f(X))
")

where
![X=X_1, \\ldots, X_n](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;X%3DX_1%2C%20%5Cldots%2C%20X_n "X=X_1, \ldots, X_n")
denotes a vector of survival times (or other survival data) for
![n](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;n "n")
individuals and
![f](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;f "f")
denotes some function.

An example would be
![\\theta = E(I(D^\*\>t)) = P(D^\*\>t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Ctheta%20%3D%20E%28I%28D%5E%2A%3Et%29%29%20%3D%20P%28D%5E%2A%3Et%29 "\theta = E(I(D^*>t)) = P(D^*>t)").

Assume that a sufficiently nice estimator
![\\hat{\\theta}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7B%5Ctheta%7D "\hat{\theta}")
of
![\\theta](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Ctheta "\theta")
exists.

For a fixed time,
![t \\in \[0, \\tau\]](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;t%20%5Cin%20%5B0%2C%20%5Ctau%5D "t \in [0, \tau]"),
the pseudo-observation for the i’th individual at
![t](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;t "t")
is given by

![ 
\\hat{\\theta}\_i (t)= n \\cdot \\hat{\\theta}(t) - (n-1) \\cdot \\hat{\\theta}^{-i}(t)
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%20%0A%5Chat%7B%5Ctheta%7D_i%20%28t%29%3D%20n%20%5Ccdot%20%5Chat%7B%5Ctheta%7D%28t%29%20-%20%28n-1%29%20%5Ccdot%20%5Chat%7B%5Ctheta%7D%5E%7B-i%7D%28t%29%0A " 
\hat{\theta}_i (t)= n \cdot \hat{\theta}(t) - (n-1) \cdot \hat{\theta}^{-i}(t)
")

where
![\\hat{\\theta}(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7B%5Ctheta%7D%28t%29 "\hat{\theta}(t)")
denotes the estimate based on the total data set, and
![\\hat{\\theta}^{-i}(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7B%5Ctheta%7D%5E%7B-i%7D%28t%29 "\hat{\theta}^{-i}(t)")
denotes the estimate based on the same data set but omitting
observations from individual i.

Since the survival times are subject to right-censoring, inference based
on likelihood is adjusted to accommodate this.

However, since all subjects has a valid pseudo-observation,
![\\hat{\\theta}\_i (t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7B%5Ctheta%7D_i%20%28t%29 "\hat{\theta}_i (t)"),
at one or more times, these can be used as an outcome variable in a
generalised linear model.

Note, that this is regardless of the whether a subject is censored or
died at time t.

Assume that
![g](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;g "g")
denotes a link function, then we wish to fit

![
g(E(f(X) \\mid Z)) = \\xi^T Z.
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0Ag%28E%28f%28X%29%20%5Cmid%20Z%29%29%20%3D%20%5Cxi%5ET%20Z.%0A "
g(E(f(X) \mid Z)) = \xi^T Z.
")

Following,
![f(X)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;f%28X%29 "f(X)")
is replaced by
![\\hat{\\theta}\_i (\\cdot)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7B%5Ctheta%7D_i%20%28%5Ccdot%29 "\hat{\theta}_i (\cdot)")
in the model fit.

The model parameters,
![\\xi](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cxi "\xi"),
are estimated using generalised estimating equations, see Liang and
Zeger (*Longitudinal data analysis using generalized linear models
(1986)*.

This can accomodate the fact that each individual can have several
pseudo-observations if more than one time point is used in the
computation.

## One-dimensional pseudo-observations

The one-dimensional pseudo-observations model is based on the parameter

![
\\hat{\\theta} = \\hat{\\mu}(t) =  \\int_0^t \\hat{S}(u^-) \\, d \\hat{R}(u),
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%5Chat%7B%5Ctheta%7D%20%3D%20%5Chat%7B%5Cmu%7D%28t%29%20%3D%20%20%5Cint_0%5Et%20%5Chat%7BS%7D%28u%5E-%29%20%5C%2C%20d%20%5Chat%7BR%7D%28u%29%2C%0A "
\hat{\theta} = \hat{\mu}(t) =  \int_0^t \hat{S}(u^-) \, d \hat{R}(u),
")

where
![\\hat{S}(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7BS%7D%28t%29 "\hat{S}(t)")
denotes the Kaplan-Meier estimator of
![S(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;S%28t%29 "S(t)")
and
![\\hat{R}(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7BR%7D%28t%29 "\hat{R}(t)")
denotes the Nelson-Aalen estimator of
![R(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;R%28t%29 "R(t)").

## Two-dimensional pseudo-observations

The two-dimensional pseudo-observations model is based on the parameter

![
\\hat{\\theta} = \\left( \\begin{matrix} \\hat{\\mu}(t) \\\\ \\hat{S}(t) \\end{matrix} \\right)
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%5Chat%7B%5Ctheta%7D%20%3D%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Chat%7B%5Cmu%7D%28t%29%20%5C%5C%20%5Chat%7BS%7D%28t%29%20%5Cend%7Bmatrix%7D%20%5Cright%29%0A "
\hat{\theta} = \left( \begin{matrix} \hat{\mu}(t) \\ \hat{S}(t) \end{matrix} \right)
")

## Three-dimensional pseudo-observations

The three-dimensional pseudo-observations model is based on the
parameter

![
\\hat{\\theta} = \\left( \\begin{matrix} \\hat{\\mu}(t) \\\\ \\hat{C}\_1(t) \\\\ \\hat{C}\_2(t) \\end{matrix} \\right)
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%5Chat%7B%5Ctheta%7D%20%3D%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Chat%7B%5Cmu%7D%28t%29%20%5C%5C%20%5Chat%7BC%7D_1%28t%29%20%5C%5C%20%5Chat%7BC%7D_2%28t%29%20%5Cend%7Bmatrix%7D%20%5Cright%29%0A "
\hat{\theta} = \left( \begin{matrix} \hat{\mu}(t) \\ \hat{C}_1(t) \\ \hat{C}_2(t) \end{matrix} \right)
")

where
![\\hat{C}\_1(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7BC%7D_1%28t%29 "\hat{C}_1(t)")
and
![\\hat{C}\_2(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7BC%7D_2%28t%29 "\hat{C}_2(t)")
are the Aalen-Johansen estimates of the cumulative incidences for causes
1,
![C_1(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;C_1%28t%29 "C_1(t)"),
and 2,
![C_2(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;C_2%28t%29 "C_2(t)"),
respectively.

# Install package from GitHub

``` r
require(devtools)
#> Indlæser krævet pakke: devtools
#> Indlæser krævet pakke: usethis

devtools::install_github("JulieKFurberg/recurrentpseudo")
#> Skipping install of 'recurrentpseudo' from a github remote, the SHA1 (876806c5) has not changed since last install.
#>   Use `force = TRUE` to force installation

require(recurrentpseudo)
#> Indlæser krævet pakke: recurrentpseudo
#> Warning: replacing previous import 'dplyr::filter' by 'stats::filter' when
#> loading 'recurrentpseudo'
#> Warning: replacing previous import 'dplyr::lag' by 'stats::lag' when loading
#> 'recurrentpseudo'
```

# Example - Bladder cancer data from survival package

We consider the well-known bladder cancer data from the survival
package.

We focus on the comparison between placebo and thiotepa.

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

One-dimensional pseudo-observations can be computed using the following
code

``` r
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

Two-dimensional pseudo-observations can be computed using the following
code

``` r
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

Three-dimensional pseudo-observations can be computed using the
following code

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
                                     tk = c(20, 30, 40),
                                     data = bladdersub)
pseudo_bladder_3d
#> $outdata_long
#>      k ts  id esttype             y        Z
#> 1    3 20   1      mu  0.000000e+00  placebo
#> 2    3 20   1    surv  0.000000e+00  placebo
#> 3    3 20   1    cif1  0.000000e+00  placebo
#> 4    3 20   1    cif2  7.283953e+00  placebo
#> 5    3 30   1      mu  1.421085e-14  placebo
#> 6    3 30   1    surv  1.421085e-14  placebo
#> 7    3 30   1    cif1  0.000000e+00  placebo
#> 8    3 30   1    cif2  1.364508e+01  placebo
#> 9    3 40   1      mu  0.000000e+00  placebo
#> 10   3 40   1    surv  1.421085e-14  placebo
#> 11   3 40   1    cif1  0.000000e+00  placebo
#> 12   3 40   1    cif2  1.738641e+01  placebo
#> 13   3 20   2      mu  0.000000e+00  placebo
#> 14   3 20   2    surv  0.000000e+00  placebo
#> 15   3 20   2    cif1  0.000000e+00  placebo
#> 16   3 20   2    cif2  7.283953e+00  placebo
#> 17   3 30   2      mu  1.421085e-14  placebo
#> 18   3 30   2    surv  1.421085e-14  placebo
#> 19   3 30   2    cif1  0.000000e+00  placebo
#> 20   3 30   2    cif2  1.364508e+01  placebo
#> 21   3 40   2      mu  0.000000e+00  placebo
#> 22   3 40   2    surv  1.421085e-14  placebo
#> 23   3 40   2    cif1  0.000000e+00  placebo
#> 24   3 40   2    cif2  1.738641e+01  placebo
#> 25   3 20   3      mu  6.673453e-01  placebo
#> 26   3 20   3    surv  8.812079e-01  placebo
#> 27   3 20   3    cif1  1.355704e-02  placebo
#> 28   3 20   3    cif2  7.297510e+00  placebo
#> 29   3 30   3      mu  1.208604e+00  placebo
#> 30   3 30   3    surv  8.170875e-01  placebo
#> 31   3 30   3    cif1  2.732928e-02  placebo
#> 32   3 30   3    cif2  1.367241e+01  placebo
#> 33   3 40   3      mu  1.517393e+00  placebo
#> 34   3 40   3    surv  7.720112e-01  placebo
#> 35   3 40   3    cif1  2.732928e-02  placebo
#> 36   3 40   3    cif2  1.741374e+01  placebo
#> 37   3 20   4      mu  5.129305e-01  placebo
#> 38   3 20   4    surv  8.812079e-01  placebo
#> 39   3 20   4    cif1  1.355704e-02  placebo
#> 40   3 20   4    cif2  7.297510e+00  placebo
#> 41   3 30   4      mu  1.054189e+00  placebo
#> 42   3 30   4    surv  8.170875e-01  placebo
#> 43   3 30   4    cif1  2.732928e-02  placebo
#> 44   3 30   4    cif2  1.367241e+01  placebo
#> 45   3 40   4      mu  1.362978e+00  placebo
#> 46   3 40   4    surv  7.720112e-01  placebo
#> 47   3 40   4    cif1  2.732928e-02  placebo
#> 48   3 40   4    cif2  1.741374e+01  placebo
#> 49   3 20   5      mu -8.057054e-02  placebo
#> 50   3 20   5    surv -5.722129e-02  placebo
#> 51   3 20   5    cif1 -8.803276e-04  placebo
#> 52   3 20   5    cif2  7.283073e+00  placebo
#> 53   3 30   5      mu -1.157172e-01  placebo
#> 54   3 30   5    surv -5.305763e-02  placebo
#> 55   3 30   5    cif1 -1.774629e-03  placebo
#> 56   3 30   5    cif2  1.364331e+01  placebo
#> 57   3 40   5      mu -1.357684e-01  placebo
#> 58   3 40   5    surv -5.013059e-02  placebo
#> 59   3 40   5    cif1 -1.774629e-03  placebo
#> 60   3 40   5    cif2  1.738464e+01  placebo
#> 61   3 20   6      mu  9.574041e-01  placebo
#> 62   3 20   6    surv -5.722129e-02  placebo
#> 63   3 20   6    cif1 -8.803276e-04  placebo
#> 64   3 20   6    cif2  7.283073e+00  placebo
#> 65   3 30   6      mu  9.222575e-01  placebo
#> 66   3 30   6    surv -5.305763e-02  placebo
#> 67   3 30   6    cif1 -1.774629e-03  placebo
#> 68   3 30   6    cif2  1.364331e+01  placebo
#> 69   3 40   6      mu  9.022063e-01  placebo
#> 70   3 40   6    surv -5.013059e-02  placebo
#> 71   3 40   6    cif1 -1.774629e-03  placebo
#> 72   3 40   6    cif2  1.738464e+01  placebo
#> 73   3 20   7      mu  2.844923e-01  placebo
#> 74   3 20   7    surv  9.187451e-01  placebo
#> 75   3 20   7    cif1  1.413454e-02  placebo
#> 76   3 20   7    cif2  7.298088e+00  placebo
#> 77   3 30   7      mu  8.488068e-01  placebo
#> 78   3 30   7    surv  8.518933e-01  placebo
#> 79   3 30   7    cif1  2.849344e-02  placebo
#> 80   3 30   7    cif2  1.367357e+01  placebo
#> 81   3 40   7      mu  1.170750e+00  placebo
#> 82   3 40   7    surv  8.048968e-01  placebo
#> 83   3 40   7    cif1  2.849344e-02  placebo
#> 84   3 40   7    cif2  1.741491e+01  placebo
#> 85   3 20   8      mu  3.256033e-02  placebo
#> 86   3 20   8    surv  9.946559e-01  placebo
#> 87   3 20   8    cif1  1.530240e-02  placebo
#> 88   3 20   8    cif2  7.299256e+00  placebo
#> 89   3 30   8      mu  6.435010e-01  placebo
#> 90   3 30   8    surv  9.222804e-01  placebo
#> 91   3 30   8    cif1  3.084769e-02  placebo
#> 92   3 30   8    cif2  1.367593e+01  placebo
#> 93   3 40   8      mu  9.920443e-01  placebo
#> 94   3 40   8    surv  8.714009e-01  placebo
#> 95   3 40   8    cif1  3.084769e-02  placebo
#> 96   3 40   8    cif2  1.741726e+01  placebo
#> 97   3 20   9      mu  9.583828e-01  placebo
#> 98   3 20   9    surv -9.845931e-02  placebo
#> 99   3 20   9    cif1 -1.514759e-03  placebo
#> 100  3 20   9    cif2  7.282439e+00  placebo
#> 101  3 30   9      mu  8.979068e-01  placebo
#> 102  3 30   9    surv -9.129499e-02  placebo
#> 103  3 30   9    cif1 -3.053561e-03  placebo
#> 104  3 30   9    cif2  1.364203e+01  placebo
#> 105  3 40   9      mu  8.634051e-01  placebo
#> 106  3 40   9    surv -8.625851e-02  placebo
#> 107  3 40   9    cif1 -3.053561e-03  placebo
#> 108  3 40   9    cif2  1.738336e+01  placebo
#> 109  3 20  10      mu  2.108250e+00  placebo
#> 110  3 20  10    surv -9.845931e-02  placebo
#> 111  3 20  10    cif1 -1.514759e-03  placebo
#> 112  3 20  10    cif2  7.282439e+00  placebo
#> 113  3 30  10      mu  2.047774e+00  placebo
#> 114  3 30  10    surv -9.129499e-02  placebo
#> 115  3 30  10    cif1 -3.053561e-03  placebo
#> 116  3 30  10    cif2  1.364203e+01  placebo
#> 117  3 40  10      mu  2.013272e+00  placebo
#> 118  3 40  10    surv -8.625851e-02  placebo
#> 119  3 40  10    cif1 -3.053561e-03  placebo
#> 120  3 40  10    cif2  1.738336e+01  placebo
#> 121  3 20  11      mu -5.125478e-02  placebo
#> 122  3 20  11    surv  1.011732e+00  placebo
#> 123  3 20  11    cif1 -1.773484e-03  placebo
#> 124  3 20  11    cif2  7.282180e+00  placebo
#> 125  3 30  11      mu  4.146931e-01  placebo
#> 126  3 30  11    surv  9.718363e-01  placebo
#> 127  3 30  11    cif1 -3.863651e-03  placebo
#> 128  3 30  11    cif2  1.364122e+01  placebo
#> 129  3 40  11      mu  7.819642e-01  placebo
#> 130  3 40  11    surv  9.182230e-01  placebo
#> 131  3 40  11    cif1 -3.863651e-03  placebo
#> 132  3 40  11    cif2  1.738255e+01  placebo
#> 133  3 20  12      mu  2.082122e+00  placebo
#> 134  3 20  12    surv  1.011732e+00  placebo
#> 135  3 20  12    cif1 -1.773484e-03  placebo
#> 136  3 20  12    cif2  7.282180e+00  placebo
#> 137  3 30  12      mu  2.548069e+00  placebo
#> 138  3 30  12    surv  9.718363e-01  placebo
#> 139  3 30  12    cif1 -3.863651e-03  placebo
#> 140  3 30  12    cif2  1.364122e+01  placebo
#> 141  3 40  12      mu  2.915341e+00  placebo
#> 142  3 40  12    surv  9.182230e-01  placebo
#> 143  3 40  12    cif1 -3.863651e-03  placebo
#> 144  3 40  12    cif2  1.738255e+01  placebo
#> 145  3 20  13      mu  2.071023e+00  placebo
#> 146  3 20  13    surv  1.011732e+00  placebo
#> 147  3 20  13    cif1 -1.773484e-03  placebo
#> 148  3 20  13    cif2  7.282180e+00  placebo
#> 149  3 30  13      mu  3.663686e+00  placebo
#> 150  3 30  13    surv  9.718363e-01  placebo
#> 151  3 30  13    cif1 -3.863651e-03  placebo
#> 152  3 30  13    cif2  1.364122e+01  placebo
#> 153  3 40  13      mu  4.030957e+00  placebo
#> 154  3 40  13    surv  9.182230e-01  placebo
#> 155  3 40  13    cif1 -3.863651e-03  placebo
#> 156  3 40  13    cif2  1.738255e+01  placebo
#> 157  3 20  14      mu  2.012373e+00  placebo
#> 158  3 20  14    surv  1.011732e+00  placebo
#> 159  3 20  14    cif1 -1.773484e-03  placebo
#> 160  3 20  14    cif2  7.282180e+00  placebo
#> 161  3 30  14      mu  2.950692e+00  placebo
#> 162  3 30  14    surv -1.240067e-01  placebo
#> 163  3 30  14    cif1  1.141322e+00  placebo
#> 164  3 30  14    cif2  1.478640e+01  placebo
#> 165  3 40  14      mu  2.903828e+00  placebo
#> 166  3 40  14    surv -1.171656e-01  placebo
#> 167  3 40  14    cif1  1.141322e+00  placebo
#> 168  3 40  14    cif2  1.852774e+01  placebo
#> 169  3 20  15      mu  3.120096e+00  placebo
#> 170  3 20  15    surv  1.011732e+00  placebo
#> 171  3 20  15    cif1 -1.773484e-03  placebo
#> 172  3 20  15    cif2  7.282180e+00  placebo
#> 173  3 30  15      mu  4.667980e+00  placebo
#> 174  3 30  15    surv  9.718363e-01  placebo
#> 175  3 30  15    cif1 -3.863651e-03  placebo
#> 176  3 30  15    cif2  1.364122e+01  placebo
#> 177  3 40  15      mu  5.035251e+00  placebo
#> 178  3 40  15    surv  9.182230e-01  placebo
#> 179  3 40  15    cif1 -3.863651e-03  placebo
#> 180  3 40  15    cif2  1.738255e+01  placebo
#> 181  3 20  16      mu  2.071023e+00  placebo
#> 182  3 20  16    surv  1.011732e+00  placebo
#> 183  3 20  16    cif1 -1.773484e-03  placebo
#> 184  3 20  16    cif2  7.282180e+00  placebo
#> 185  3 30  16      mu  3.597777e+00  placebo
#> 186  3 30  16    surv  9.718363e-01  placebo
#> 187  3 30  16    cif1 -3.863651e-03  placebo
#> 188  3 30  16    cif2  1.364122e+01  placebo
#> 189  3 40  16      mu  3.965048e+00  placebo
#> 190  3 40  16    surv  9.182230e-01  placebo
#> 191  3 40  16    cif1 -3.863651e-03  placebo
#> 192  3 40  16    cif2  1.738255e+01  placebo
#> 193  3 20  17      mu -5.125478e-02  placebo
#> 194  3 20  17    surv  1.011732e+00  placebo
#> 195  3 20  17    cif1 -1.773484e-03  placebo
#> 196  3 20  17    cif2  7.282180e+00  placebo
#> 197  3 30  17      mu  1.279083e-01  placebo
#> 198  3 30  17    surv  9.718363e-01  placebo
#> 199  3 30  17    cif1 -3.863651e-03  placebo
#> 200  3 30  17    cif2  1.364122e+01  placebo
#> 201  3 40  17      mu  4.951794e-01  placebo
#> 202  3 40  17    surv  9.182230e-01  placebo
#> 203  3 40  17    cif1 -3.863651e-03  placebo
#> 204  3 40  17    cif2  1.738255e+01  placebo
#> 205  3 20  18      mu -5.125478e-02  placebo
#> 206  3 20  18    surv  1.011732e+00  placebo
#> 207  3 20  18    cif1 -1.773484e-03  placebo
#> 208  3 20  18    cif2  7.282180e+00  placebo
#> 209  3 30  18      mu  1.279083e-01  placebo
#> 210  3 30  18    surv  9.718363e-01  placebo
#> 211  3 30  18    cif1 -3.863651e-03  placebo
#> 212  3 30  18    cif2  1.364122e+01  placebo
#> 213  3 40  18      mu  4.951794e-01  placebo
#> 214  3 40  18    surv  9.182230e-01  placebo
#> 215  3 40  18    cif1 -3.863651e-03  placebo
#> 216  3 40  18    cif2  1.738255e+01  placebo
#> 217  3 20  19      mu  9.610909e-01  placebo
#> 218  3 20  19    surv  1.011732e+00  placebo
#> 219  3 20  19    cif1 -1.773484e-03  placebo
#> 220  3 20  19    cif2  7.282180e+00  placebo
#> 221  3 30  19      mu  2.458298e+00  placebo
#> 222  3 30  19    surv  9.718363e-01  placebo
#> 223  3 30  19    cif1 -3.863651e-03  placebo
#> 224  3 30  19    cif2  1.364122e+01  placebo
#> 225  3 40  19      mu  2.825569e+00  placebo
#> 226  3 40  19    surv  9.182230e-01  placebo
#> 227  3 40  19    cif1 -3.863651e-03  placebo
#> 228  3 40  19    cif2  1.738255e+01  placebo
#> 229  3 20  20      mu -5.125478e-02  placebo
#> 230  3 20  20    surv  1.011732e+00  placebo
#> 231  3 20  20    cif1 -1.773484e-03  placebo
#> 232  3 20  20    cif2  7.282180e+00  placebo
#> 233  3 30  20      mu  1.181193e+00  placebo
#> 234  3 30  20    surv  9.718363e-01  placebo
#> 235  3 30  20    cif1 -3.863651e-03  placebo
#> 236  3 30  20    cif2  1.364122e+01  placebo
#> 237  3 40  20      mu  1.548464e+00  placebo
#> 238  3 40  20    surv  9.182230e-01  placebo
#> 239  3 40  20    cif1 -3.863651e-03  placebo
#> 240  3 40  20    cif2  1.738255e+01  placebo
#> 241  3 20  21      mu -5.125478e-02  placebo
#> 242  3 20  21    surv  1.011732e+00  placebo
#> 243  3 20  21    cif1 -1.773484e-03  placebo
#> 244  3 20  21    cif2  7.282180e+00  placebo
#> 245  3 30  21      mu -1.312755e-01  placebo
#> 246  3 30  21    surv  1.002097e+00  placebo
#> 247  3 30  21    cif1 -3.863651e-03  placebo
#> 248  3 30  21    cif2  1.364122e+01  placebo
#> 249  3 40  21      mu  2.474316e-01  placebo
#> 250  3 40  21    surv  9.468145e-01  placebo
#> 251  3 40  21    cif1 -3.863651e-03  placebo
#> 252  3 40  21    cif2  1.738255e+01  placebo
#> 253  3 20  22      mu -5.125478e-02  placebo
#> 254  3 20  22    surv  1.011732e+00  placebo
#> 255  3 20  22    cif1 -1.773484e-03  placebo
#> 256  3 20  22    cif2  7.282180e+00  placebo
#> 257  3 30  22      mu -1.312755e-01  placebo
#> 258  3 30  22    surv  1.002097e+00  placebo
#> 259  3 30  22    cif1 -3.863651e-03  placebo
#> 260  3 30  22    cif2  1.364122e+01  placebo
#> 261  3 40  22      mu  2.474316e-01  placebo
#> 262  3 40  22    surv  9.468145e-01  placebo
#> 263  3 40  22    cif1 -3.863651e-03  placebo
#> 264  3 40  22    cif2  1.738255e+01  placebo
#> 265  3 20  23      mu -5.125478e-02  placebo
#> 266  3 20  23    surv  1.011732e+00  placebo
#> 267  3 20  23    cif1 -1.773484e-03  placebo
#> 268  3 20  23    cif2  7.282180e+00  placebo
#> 269  3 30  23      mu -3.251819e-01  placebo
#> 270  3 30  23    surv -4.504280e-01  placebo
#> 271  3 30  23    cif1 -3.863651e-03  placebo
#> 272  3 30  23    cif2  1.364122e+01  placebo
#> 273  3 40  23      mu -4.954052e-01  placebo
#> 274  3 40  23    surv -4.255792e-01  placebo
#> 275  3 40  23    cif1 -3.863651e-03  placebo
#> 276  3 40  23    cif2  1.738255e+01  placebo
#> 277  3 20  24      mu -5.125478e-02  placebo
#> 278  3 20  24    surv  1.011732e+00  placebo
#> 279  3 20  24    cif1 -1.773484e-03  placebo
#> 280  3 20  24    cif2  7.282180e+00  placebo
#> 281  3 30  24      mu  2.773664e+00  placebo
#> 282  3 30  24    surv  1.038234e+00  placebo
#> 283  3 30  24    cif1 -3.863651e-03  placebo
#> 284  3 30  24    cif2  1.364122e+01  placebo
#> 285  3 40  24      mu  3.166028e+00  placebo
#> 286  3 40  24    surv  9.809573e-01  placebo
#> 287  3 40  24    cif1 -3.863651e-03  placebo
#> 288  3 40  24    cif2  1.738255e+01  placebo
#> 289  3 20  25      mu  2.055390e+00  placebo
#> 290  3 20  25    surv  1.011732e+00  placebo
#> 291  3 20  25    cif1 -1.773484e-03  placebo
#> 292  3 20  25    cif2  7.282180e+00  placebo
#> 293  3 30  25      mu  2.998954e+00  placebo
#> 294  3 30  25    surv  1.038234e+00  placebo
#> 295  3 30  25    cif1 -3.863651e-03  placebo
#> 296  3 30  25    cif2  1.364122e+01  placebo
#> 297  3 40  25      mu  3.391317e+00  placebo
#> 298  3 40  25    surv  9.809573e-01  placebo
#> 299  3 40  25    cif1 -3.863651e-03  placebo
#> 300  3 40  25    cif2  1.738255e+01  placebo
#> 301  3 20  26      mu  4.115283e+00  placebo
#> 302  3 20  26    surv  1.011732e+00  placebo
#> 303  3 20  26    cif1 -1.773484e-03  placebo
#> 304  3 20  26    cif2  7.282180e+00  placebo
#> 305  3 30  26      mu  5.138952e+00  placebo
#> 306  3 30  26    surv -5.517670e-01  placebo
#> 307  3 30  26    cif1 -3.863651e-03  placebo
#> 308  3 30  26    cif2  1.364122e+01  placebo
#> 309  3 40  26      mu  4.930431e+00  placebo
#> 310  3 40  26    surv -5.213276e-01  placebo
#> 311  3 40  26    cif1 -3.863651e-03  placebo
#> 312  3 40  26    cif2  1.738255e+01  placebo
#> 313  3 20  27      mu  2.123613e+00  placebo
#> 314  3 20  27    surv  1.011732e+00  placebo
#> 315  3 20  27    cif1 -1.773484e-03  placebo
#> 316  3 20  27    cif2  7.282180e+00  placebo
#> 317  3 30  27      mu  3.144587e+00  placebo
#> 318  3 30  27    surv  1.038234e+00  placebo
#> 319  3 30  27    cif1 -3.863651e-03  placebo
#> 320  3 30  27    cif2  1.364122e+01  placebo
#> 321  3 40  27      mu  3.536951e+00  placebo
#> 322  3 40  27    surv  9.809573e-01  placebo
#> 323  3 40  27    cif1 -3.863651e-03  placebo
#> 324  3 40  27    cif2  1.738255e+01  placebo
#> 325  3 20  28      mu -5.125478e-02  placebo
#> 326  3 20  28    surv  1.011732e+00  placebo
#> 327  3 20  28    cif1 -1.773484e-03  placebo
#> 328  3 20  28    cif2  7.282180e+00  placebo
#> 329  3 30  28      mu -2.346997e-01  placebo
#> 330  3 30  28    surv  1.038234e+00  placebo
#> 331  3 30  28    cif1 -3.863651e-03  placebo
#> 332  3 30  28    cif2  1.364122e+01  placebo
#> 333  3 40  28      mu  1.148563e-01  placebo
#> 334  3 40  28    surv  9.809573e-01  placebo
#> 335  3 40  28    cif1 -3.863651e-03  placebo
#> 336  3 40  28    cif2  1.738255e+01  placebo
#> 337  3 20  29      mu -5.125478e-02  placebo
#> 338  3 20  29    surv  1.011732e+00  placebo
#> 339  3 20  29    cif1 -1.773484e-03  placebo
#> 340  3 20  29    cif2  7.282180e+00  placebo
#> 341  3 30  29      mu -2.346997e-01  placebo
#> 342  3 30  29    surv  1.038234e+00  placebo
#> 343  3 30  29    cif1 -3.863651e-03  placebo
#> 344  3 30  29    cif2  1.364122e+01  placebo
#> 345  3 40  29      mu -5.954664e-01  placebo
#> 346  3 40  29    surv -6.794629e-01  placebo
#> 347  3 40  29    cif1 -3.863651e-03  placebo
#> 348  3 40  29    cif2  1.738255e+01  placebo
#> 349  3 20  30      mu -5.125478e-02  placebo
#> 350  3 20  30    surv  1.011732e+00  placebo
#> 351  3 20  30    cif1 -1.773484e-03  placebo
#> 352  3 20  30    cif2  7.282180e+00  placebo
#> 353  3 30  30      mu -2.346997e-01  placebo
#> 354  3 30  30    surv  1.038234e+00  placebo
#> 355  3 30  30    cif1 -3.863651e-03  placebo
#> 356  3 30  30    cif2  1.364122e+01  placebo
#> 357  3 40  30      mu -1.878053e-01  placebo
#> 358  3 40  30    surv  1.024653e+00  placebo
#> 359  3 40  30    cif1 -3.863651e-03  placebo
#> 360  3 40  30    cif2  1.738255e+01  placebo
#> 361  3 20  31      mu -5.125478e-02  placebo
#> 362  3 20  31    surv  1.011732e+00  placebo
#> 363  3 20  31    cif1 -1.773484e-03  placebo
#> 364  3 20  31    cif2  7.282180e+00  placebo
#> 365  3 30  31      mu  1.219982e+00  placebo
#> 366  3 30  31    surv  1.038234e+00  placebo
#> 367  3 30  31    cif1 -3.863651e-03  placebo
#> 368  3 30  31    cif2  1.364122e+01  placebo
#> 369  3 40  31      mu  1.266876e+00  placebo
#> 370  3 40  31    surv  1.024653e+00  placebo
#> 371  3 40  31    cif1 -3.863651e-03  placebo
#> 372  3 40  31    cif2  1.738255e+01  placebo
#> 373  3 20  32      mu -5.125478e-02  placebo
#> 374  3 20  32    surv  1.011732e+00  placebo
#> 375  3 20  32    cif1 -1.773484e-03  placebo
#> 376  3 20  32    cif2  7.282180e+00  placebo
#> 377  3 30  32      mu -2.346997e-01  placebo
#> 378  3 30  32    surv  1.038234e+00  placebo
#> 379  3 30  32    cif1 -3.863651e-03  placebo
#> 380  3 30  32    cif2  1.364122e+01  placebo
#> 381  3 40  32      mu -2.424462e-01  placebo
#> 382  3 40  32    surv  1.024653e+00  placebo
#> 383  3 40  32    cif1 -3.863651e-03  placebo
#> 384  3 40  32    cif2  1.738255e+01  placebo
#> 385  3 20  33      mu  2.094327e+00  placebo
#> 386  3 20  33    surv  1.011732e+00  placebo
#> 387  3 20  33    cif1 -1.773484e-03  placebo
#> 388  3 20  33    cif2  7.282180e+00  placebo
#> 389  3 30  33      mu  4.242310e+00  placebo
#> 390  3 30  33    surv  1.038234e+00  placebo
#> 391  3 30  33    cif1 -3.863651e-03  placebo
#> 392  3 30  33    cif2  1.364122e+01  placebo
#> 393  3 40  33      mu  3.929382e+00  placebo
#> 394  3 40  33    surv  1.086227e+00  placebo
#> 395  3 40  33    cif1 -3.863651e-03  placebo
#> 396  3 40  33    cif2  1.738255e+01  placebo
#> 397  3 20  34      mu  2.168347e+00  placebo
#> 398  3 20  34    surv  1.011732e+00  placebo
#> 399  3 20  34    cif1 -1.773484e-03  placebo
#> 400  3 20  34    cif2  7.282180e+00  placebo
#> 401  3 30  34      mu  4.566299e+00  placebo
#> 402  3 30  34    surv  1.038234e+00  placebo
#> 403  3 30  34    cif1 -3.863651e-03  placebo
#> 404  3 30  34    cif2  1.364122e+01  placebo
#> 405  3 40  34      mu  8.064184e+00  placebo
#> 406  3 40  34    surv  1.086227e+00  placebo
#> 407  3 40  34    cif1 -3.863651e-03  placebo
#> 408  3 40  34    cif2  1.738255e+01  placebo
#> 409  3 20  35      mu -5.125478e-02  placebo
#> 410  3 20  35    surv  1.011732e+00  placebo
#> 411  3 20  35    cif1 -1.773484e-03  placebo
#> 412  3 20  35    cif2  7.282180e+00  placebo
#> 413  3 30  35      mu -2.346997e-01  placebo
#> 414  3 30  35    surv  1.038234e+00  placebo
#> 415  3 30  35    cif1 -3.863651e-03  placebo
#> 416  3 30  35    cif2  1.364122e+01  placebo
#> 417  3 40  35      mu -5.476268e-01  placebo
#> 418  3 40  35    surv  1.086227e+00  placebo
#> 419  3 40  35    cif1 -3.863651e-03  placebo
#> 420  3 40  35    cif2  1.738255e+01  placebo
#> 421  3 20  36      mu  9.610909e-01  placebo
#> 422  3 20  36    surv  1.011732e+00  placebo
#> 423  3 20  36    cif1 -1.773484e-03  placebo
#> 424  3 20  36    cif2  7.282180e+00  placebo
#> 425  3 30  36      mu  7.776460e-01  placebo
#> 426  3 30  36    surv  1.038234e+00  placebo
#> 427  3 30  36    cif1 -3.863651e-03  placebo
#> 428  3 30  36    cif2  1.364122e+01  placebo
#> 429  3 40  36      mu  4.647189e-01  placebo
#> 430  3 40  36    surv  1.086227e+00  placebo
#> 431  3 40  36    cif1 -3.863651e-03  placebo
#> 432  3 40  36    cif2  1.738255e+01  placebo
#> 433  3 20  37      mu  9.867199e-01  placebo
#> 434  3 20  37    surv  1.011732e+00  placebo
#> 435  3 20  37    cif1 -1.773484e-03  placebo
#> 436  3 20  37    cif2  7.282180e+00  placebo
#> 437  3 30  37      mu  8.032750e-01  placebo
#> 438  3 30  37    surv  1.038234e+00  placebo
#> 439  3 30  37    cif1 -3.863651e-03  placebo
#> 440  3 30  37    cif2  1.364122e+01  placebo
#> 441  3 40  37      mu  4.903479e-01  placebo
#> 442  3 40  37    surv  1.086227e+00  placebo
#> 443  3 40  37    cif1 -3.863651e-03  placebo
#> 444  3 40  37    cif2  1.738255e+01  placebo
#> 445  3 20  38      mu  3.050348e+00  placebo
#> 446  3 20  38    surv  1.011732e+00  placebo
#> 447  3 20  38    cif1 -1.773484e-03  placebo
#> 448  3 20  38    cif2  7.282180e+00  placebo
#> 449  3 30  38      mu  2.866903e+00  placebo
#> 450  3 30  38    surv  1.038234e+00  placebo
#> 451  3 30  38    cif1 -3.863651e-03  placebo
#> 452  3 30  38    cif2  1.364122e+01  placebo
#> 453  3 40  38      mu  2.553976e+00  placebo
#> 454  3 40  38    surv  1.086227e+00  placebo
#> 455  3 40  38    cif1 -3.863651e-03  placebo
#> 456  3 40  38    cif2  1.738255e+01  placebo
#> 457  3 20  39      mu  3.191971e+00  placebo
#> 458  3 20  39    surv  1.011732e+00  placebo
#> 459  3 20  39    cif1 -1.773484e-03  placebo
#> 460  3 20  39    cif2  7.282180e+00  placebo
#> 461  3 30  39      mu  5.879593e+00  placebo
#> 462  3 30  39    surv  1.038234e+00  placebo
#> 463  3 30  39    cif1 -3.863651e-03  placebo
#> 464  3 30  39    cif2  1.364122e+01  placebo
#> 465  3 40  39      mu  5.566666e+00  placebo
#> 466  3 40  39    surv  1.086227e+00  placebo
#> 467  3 40  39    cif1 -3.863651e-03  placebo
#> 468  3 40  39    cif2  1.738255e+01  placebo
#> 469  3 20  40      mu  9.952528e-01  placebo
#> 470  3 20  40    surv  1.011732e+00  placebo
#> 471  3 20  40    cif1 -1.773484e-03  placebo
#> 472  3 20  40    cif2  7.282180e+00  placebo
#> 473  3 30  40      mu  8.118079e-01  placebo
#> 474  3 30  40    surv  1.038234e+00  placebo
#> 475  3 30  40    cif1 -3.863651e-03  placebo
#> 476  3 30  40    cif2  1.364122e+01  placebo
#> 477  3 40  40      mu  4.988808e-01  placebo
#> 478  3 40  40    surv  1.086227e+00  placebo
#> 479  3 40  40    cif1 -3.863651e-03  placebo
#> 480  3 40  40    cif2  1.738255e+01  placebo
#> 481  3 20  41      mu -5.125478e-02  placebo
#> 482  3 20  41    surv  1.011732e+00  placebo
#> 483  3 20  41    cif1 -1.773484e-03  placebo
#> 484  3 20  41    cif2  7.282180e+00  placebo
#> 485  3 30  41      mu -2.346997e-01  placebo
#> 486  3 30  41    surv  1.038234e+00  placebo
#> 487  3 30  41    cif1 -3.863651e-03  placebo
#> 488  3 30  41    cif2  1.364122e+01  placebo
#> 489  3 40  41      mu -5.476268e-01  placebo
#> 490  3 40  41    surv  1.086227e+00  placebo
#> 491  3 40  41    cif1 -3.863651e-03  placebo
#> 492  3 40  41    cif2  1.738255e+01  placebo
#> 493  3 20  42      mu -5.125478e-02  placebo
#> 494  3 20  42    surv  1.011732e+00  placebo
#> 495  3 20  42    cif1 -1.773484e-03  placebo
#> 496  3 20  42    cif2  7.282180e+00  placebo
#> 497  3 30  42      mu -2.346997e-01  placebo
#> 498  3 30  42    surv  1.038234e+00  placebo
#> 499  3 30  42    cif1 -3.863651e-03  placebo
#> 500  3 30  42    cif2  1.364122e+01  placebo
#> 501  3 40  42      mu  1.209742e+00  placebo
#> 502  3 40  42    surv  1.086227e+00  placebo
#> 503  3 40  42    cif1 -3.863651e-03  placebo
#> 504  3 40  42    cif2  1.738255e+01  placebo
#> 505  3 20  43      mu  1.043045e+00  placebo
#> 506  3 20  43    surv  1.011732e+00  placebo
#> 507  3 20  43    cif1 -1.773484e-03  placebo
#> 508  3 20  43    cif2  7.282180e+00  placebo
#> 509  3 30  43      mu  8.595998e-01  placebo
#> 510  3 30  43    surv  1.038234e+00  placebo
#> 511  3 30  43    cif1 -3.863651e-03  placebo
#> 512  3 30  43    cif2  1.364122e+01  placebo
#> 513  3 40  43      mu  5.466726e-01  placebo
#> 514  3 40  43    surv  1.086227e+00  placebo
#> 515  3 40  43    cif1 -3.863651e-03  placebo
#> 516  3 40  43    cif2  1.738255e+01  placebo
#> 517  3 20  44      mu  2.071023e+00  placebo
#> 518  3 20  44    surv  1.011732e+00  placebo
#> 519  3 20  44    cif1 -1.773484e-03  placebo
#> 520  3 20  44    cif2  7.282180e+00  placebo
#> 521  3 30  44      mu  1.887578e+00  placebo
#> 522  3 30  44    surv  1.038234e+00  placebo
#> 523  3 30  44    cif1 -3.863651e-03  placebo
#> 524  3 30  44    cif2  1.364122e+01  placebo
#> 525  3 40  44      mu  1.574651e+00  placebo
#> 526  3 40  44    surv  1.086227e+00  placebo
#> 527  3 40  44    cif1 -3.863651e-03  placebo
#> 528  3 40  44    cif2  1.738255e+01  placebo
#> 529  3 20  45      mu -5.125478e-02  placebo
#> 530  3 20  45    surv  1.011732e+00  placebo
#> 531  3 20  45    cif1 -1.773484e-03  placebo
#> 532  3 20  45    cif2  7.282180e+00  placebo
#> 533  3 30  45      mu -2.346997e-01  placebo
#> 534  3 30  45    surv  1.038234e+00  placebo
#> 535  3 30  45    cif1 -3.863651e-03  placebo
#> 536  3 30  45    cif2  1.364122e+01  placebo
#> 537  3 40  45      mu -5.476268e-01  placebo
#> 538  3 40  45    surv  1.086227e+00  placebo
#> 539  3 40  45    cif1 -3.863651e-03  placebo
#> 540  3 40  45    cif2  1.738255e+01  placebo
#> 541  3 20  46      mu  2.071023e+00  placebo
#> 542  3 20  46    surv  1.011732e+00  placebo
#> 543  3 20  46    cif1 -1.773484e-03  placebo
#> 544  3 20  46    cif2  7.282180e+00  placebo
#> 545  3 30  46      mu  4.645022e+00  placebo
#> 546  3 30  46    surv  1.038234e+00  placebo
#> 547  3 30  46    cif1 -3.863651e-03  placebo
#> 548  3 30  46    cif2  1.364122e+01  placebo
#> 549  3 40  46      mu  8.011676e+00  placebo
#> 550  3 40  46    surv  1.086227e+00  placebo
#> 551  3 40  46    cif1 -3.863651e-03  placebo
#> 552  3 40  46    cif2  1.738255e+01  placebo
#> 553  3 20  47      mu  3.162938e+00  placebo
#> 554  3 20  47    surv  1.011732e+00  placebo
#> 555  3 20  47    cif1 -1.773484e-03  placebo
#> 556  3 20  47    cif2  7.282180e+00  placebo
#> 557  3 30  47      mu  4.405133e+00  placebo
#> 558  3 30  47    surv  1.038234e+00  placebo
#> 559  3 30  47    cif1 -3.863651e-03  placebo
#> 560  3 30  47    cif2  1.364122e+01  placebo
#> 561  3 40  47      mu  4.092205e+00  placebo
#> 562  3 40  47    surv  1.086227e+00  placebo
#> 563  3 40  47    cif1 -3.863651e-03  placebo
#> 564  3 40  47    cif2  1.738255e+01  placebo
#> 565  3 20  48      mu  5.236543e+00  placebo
#> 566  3 20  48    surv  1.011732e+00  placebo
#> 567  3 20  48    cif1 -1.773484e-03  placebo
#> 568  3 20  48    cif2  7.282180e+00  placebo
#> 569  3 30  48      mu  6.162496e+00  placebo
#> 570  3 30  48    surv  1.038234e+00  placebo
#> 571  3 30  48    cif1 -3.863651e-03  placebo
#> 572  3 30  48    cif2  1.364122e+01  placebo
#> 573  3 40  48      mu  7.606938e+00  placebo
#> 574  3 40  48    surv  1.086227e+00  placebo
#> 575  3 40  48    cif1 -3.863651e-03  placebo
#> 576  3 40  48    cif2  1.738255e+01  placebo
#> 577  3 20  81      mu  9.019132e-01 thiotepa
#> 578  3 20  81    surv  8.812079e-01 thiotepa
#> 579  3 20  81    cif1  1.355704e-02 thiotepa
#> 580  3 20  81    cif2  7.297510e+00 thiotepa
#> 581  3 30  81      mu  1.443171e+00 thiotepa
#> 582  3 30  81    surv  8.170875e-01 thiotepa
#> 583  3 30  81    cif1  2.732928e-02 thiotepa
#> 584  3 30  81    cif2  1.367241e+01 thiotepa
#> 585  3 40  81      mu  1.751961e+00 thiotepa
#> 586  3 40  81    surv  7.720112e-01 thiotepa
#> 587  3 40  81    cif1  2.732928e-02 thiotepa
#> 588  3 40  81    cif2  1.741374e+01 thiotepa
#> 589  3 20  82      mu  0.000000e+00 thiotepa
#> 590  3 20  82    surv  0.000000e+00 thiotepa
#> 591  3 20  82    cif1  0.000000e+00 thiotepa
#> 592  3 20  82    cif2  7.283953e+00 thiotepa
#> 593  3 30  82      mu  1.421085e-14 thiotepa
#> 594  3 30  82    surv  1.421085e-14 thiotepa
#> 595  3 30  82    cif1  0.000000e+00 thiotepa
#> 596  3 30  82    cif2  1.364508e+01 thiotepa
#> 597  3 40  82      mu  0.000000e+00 thiotepa
#> 598  3 40  82    surv  1.421085e-14 thiotepa
#> 599  3 40  82    cif1  0.000000e+00 thiotepa
#> 600  3 40  82    cif2  1.738641e+01 thiotepa
#> 601  3 20  83      mu  1.641728e+00 thiotepa
#> 602  3 20  83    surv  8.812079e-01 thiotepa
#> 603  3 20  83    cif1  1.355704e-02 thiotepa
#> 604  3 20  83    cif2  7.297510e+00 thiotepa
#> 605  3 30  83      mu  2.182986e+00 thiotepa
#> 606  3 30  83    surv  8.170875e-01 thiotepa
#> 607  3 30  83    cif1  2.732928e-02 thiotepa
#> 608  3 30  83    cif2  1.367241e+01 thiotepa
#> 609  3 40  83      mu  2.491776e+00 thiotepa
#> 610  3 40  83    surv  7.720112e-01 thiotepa
#> 611  3 40  83    cif1  2.732928e-02 thiotepa
#> 612  3 40  83    cif2  1.741374e+01 thiotepa
#> 613  3 20  84      mu  4.330863e-01 thiotepa
#> 614  3 20  84    surv  8.812079e-01 thiotepa
#> 615  3 20  84    cif1  1.355704e-02 thiotepa
#> 616  3 20  84    cif2  7.297510e+00 thiotepa
#> 617  3 30  84      mu  9.743446e-01 thiotepa
#> 618  3 30  84    surv  8.170875e-01 thiotepa
#> 619  3 30  84    cif1  2.732928e-02 thiotepa
#> 620  3 30  84    cif2  1.367241e+01 thiotepa
#> 621  3 40  84      mu  1.283134e+00 thiotepa
#> 622  3 40  84    surv  7.720112e-01 thiotepa
#> 623  3 40  84    cif1  2.732928e-02 thiotepa
#> 624  3 40  84    cif2  1.741374e+01 thiotepa
#> 625  3 20  85      mu -8.057054e-02 thiotepa
#> 626  3 20  85    surv -5.722129e-02 thiotepa
#> 627  3 20  85    cif1 -8.803276e-04 thiotepa
#> 628  3 20  85    cif2  7.283073e+00 thiotepa
#> 629  3 30  85      mu -1.157172e-01 thiotepa
#> 630  3 30  85    surv -5.305763e-02 thiotepa
#> 631  3 30  85    cif1 -1.774629e-03 thiotepa
#> 632  3 30  85    cif2  1.364331e+01 thiotepa
#> 633  3 40  85      mu -1.357684e-01 thiotepa
#> 634  3 40  85    surv -5.013059e-02 thiotepa
#> 635  3 40  85    cif1 -1.774629e-03 thiotepa
#> 636  3 40  85    cif2  1.738464e+01 thiotepa
#> 637  3 20  86      mu  2.990805e-01 thiotepa
#> 638  3 20  86    surv  9.187451e-01 thiotepa
#> 639  3 20  86    cif1  1.413454e-02 thiotepa
#> 640  3 20  86    cif2  7.298088e+00 thiotepa
#> 641  3 30  86      mu  8.633950e-01 thiotepa
#> 642  3 30  86    surv  8.518933e-01 thiotepa
#> 643  3 30  86    cif1  2.849344e-02 thiotepa
#> 644  3 30  86    cif2  1.367357e+01 thiotepa
#> 645  3 40  86      mu  1.185338e+00 thiotepa
#> 646  3 40  86    surv  8.048968e-01 thiotepa
#> 647  3 40  86    cif1  2.849344e-02 thiotepa
#> 648  3 40  86    cif2  1.741491e+01 thiotepa
#> 649  3 20  87      mu  1.296838e+00 thiotepa
#> 650  3 20  87    surv  9.187451e-01 thiotepa
#> 651  3 20  87    cif1  1.413454e-02 thiotepa
#> 652  3 20  87    cif2  7.298088e+00 thiotepa
#> 653  3 30  87      mu  1.861153e+00 thiotepa
#> 654  3 30  87    surv  8.518933e-01 thiotepa
#> 655  3 30  87    cif1  2.849344e-02 thiotepa
#> 656  3 30  87    cif2  1.367357e+01 thiotepa
#> 657  3 40  87      mu  2.183095e+00 thiotepa
#> 658  3 40  87    surv  8.048968e-01 thiotepa
#> 659  3 40  87    cif1  2.849344e-02 thiotepa
#> 660  3 40  87    cif2  1.741491e+01 thiotepa
#> 661  3 20  88      mu  3.953313e+00 thiotepa
#> 662  3 20  88    surv -9.845931e-02 thiotepa
#> 663  3 20  88    cif1 -1.514759e-03 thiotepa
#> 664  3 20  88    cif2  7.282439e+00 thiotepa
#> 665  3 30  88      mu  3.892837e+00 thiotepa
#> 666  3 30  88    surv -9.129499e-02 thiotepa
#> 667  3 30  88    cif1 -3.053561e-03 thiotepa
#> 668  3 30  88    cif2  1.364203e+01 thiotepa
#> 669  3 40  88      mu  3.858335e+00 thiotepa
#> 670  3 40  88    surv -8.625851e-02 thiotepa
#> 671  3 40  88    cif1 -3.053561e-03 thiotepa
#> 672  3 40  88    cif2  1.738336e+01 thiotepa
#> 673  3 20  89      mu -6.661721e-02 thiotepa
#> 674  3 20  89    surv -9.845931e-02 thiotepa
#> 675  3 20  89    cif1 -1.514759e-03 thiotepa
#> 676  3 20  89    cif2  7.282439e+00 thiotepa
#> 677  3 30  89      mu -1.270932e-01 thiotepa
#> 678  3 30  89    surv -9.129499e-02 thiotepa
#> 679  3 30  89    cif1 -3.053561e-03 thiotepa
#> 680  3 30  89    cif2  1.364203e+01 thiotepa
#> 681  3 40  89      mu -1.615949e-01 thiotepa
#> 682  3 40  89    surv -8.625851e-02 thiotepa
#> 683  3 40  89    cif1 -3.053561e-03 thiotepa
#> 684  3 40  89    cif2  1.738336e+01 thiotepa
#> 685  3 20  90      mu  1.027682e+00 thiotepa
#> 686  3 20  90    surv -9.845931e-02 thiotepa
#> 687  3 20  90    cif1 -1.514759e-03 thiotepa
#> 688  3 20  90    cif2  7.282439e+00 thiotepa
#> 689  3 30  90      mu  9.672063e-01 thiotepa
#> 690  3 30  90    surv -9.129499e-02 thiotepa
#> 691  3 30  90    cif1 -3.053561e-03 thiotepa
#> 692  3 30  90    cif2  1.364203e+01 thiotepa
#> 693  3 40  90      mu  9.327046e-01 thiotepa
#> 694  3 40  90    surv -8.625851e-02 thiotepa
#> 695  3 40  90    cif1 -3.053561e-03 thiotepa
#> 696  3 40  90    cif2  1.738336e+01 thiotepa
#> 697  3 20  91      mu  9.090751e-01 thiotepa
#> 698  3 20  91    surv -1.152765e-01 thiotepa
#> 699  3 20  91    cif1  1.125235e+00 thiotepa
#> 700  3 20  91    cif2  8.409188e+00 thiotepa
#> 701  3 30  91      mu  8.382697e-01 thiotepa
#> 702  3 30  91    surv -1.068885e-01 thiotepa
#> 703  3 30  91    cif1  1.123433e+00 thiotepa
#> 704  3 30  91    cif2  1.476851e+01 thiotepa
#> 705  3 40  91      mu  7.978749e-01 thiotepa
#> 706  3 40  91    surv -1.009917e-01 thiotepa
#> 707  3 40  91    cif1  1.123433e+00 thiotepa
#> 708  3 40  91    cif2  1.850985e+01 thiotepa
#> 709  3 20  92      mu  2.152714e+00 thiotepa
#> 710  3 20  92    surv  1.011732e+00 thiotepa
#> 711  3 20  92    cif1 -1.773484e-03 thiotepa
#> 712  3 20  92    cif2  7.282180e+00 thiotepa
#> 713  3 30  92      mu  2.047232e+00 thiotepa
#> 714  3 30  92    surv -1.068885e-01 thiotepa
#> 715  3 30  92    cif1 -3.575119e-03 thiotepa
#> 716  3 30  92    cif2  1.364151e+01 thiotepa
#> 717  3 40  92      mu  2.006837e+00 thiotepa
#> 718  3 40  92    surv -1.009917e-01 thiotepa
#> 719  3 40  92    cif1 -3.575119e-03 thiotepa
#> 720  3 40  92    cif2  1.738284e+01 thiotepa
#> 721  3 20  93      mu -5.125478e-02 thiotepa
#> 722  3 20  93    surv  1.011732e+00 thiotepa
#> 723  3 20  93    cif1 -1.773484e-03 thiotepa
#> 724  3 20  93    cif2  7.282180e+00 thiotepa
#> 725  3 30  93      mu  4.940266e-01 thiotepa
#> 726  3 30  93    surv  9.544420e-01 thiotepa
#> 727  3 30  93    cif1  1.431390e-02 thiotepa
#> 728  3 30  93    cif2  1.365939e+01 thiotepa
#> 729  3 40  93      mu  8.547242e-01 thiotepa
#> 730  3 40  93    surv  9.017882e-01 thiotepa
#> 731  3 40  93    cif1  1.431390e-02 thiotepa
#> 732  3 40  93    cif2  1.740073e+01 thiotepa
#> 733  3 20  94      mu -5.125478e-02 thiotepa
#> 734  3 20  94    surv  1.011732e+00 thiotepa
#> 735  3 20  94    cif1 -1.773484e-03 thiotepa
#> 736  3 20  94    cif2  7.282180e+00 thiotepa
#> 737  3 30  94      mu  2.499494e-01 thiotepa
#> 738  3 30  94    surv  9.718363e-01 thiotepa
#> 739  3 30  94    cif1 -3.863651e-03 thiotepa
#> 740  3 30  94    cif2  1.364122e+01 thiotepa
#> 741  3 40  94      mu  6.172205e-01 thiotepa
#> 742  3 40  94    surv  9.182230e-01 thiotepa
#> 743  3 40  94    cif1 -3.863651e-03 thiotepa
#> 744  3 40  94    cif2  1.738255e+01 thiotepa
#> 745  3 20  95      mu -5.125478e-02 thiotepa
#> 746  3 20  95    surv  1.011732e+00 thiotepa
#> 747  3 20  95    cif1 -1.773484e-03 thiotepa
#> 748  3 20  95    cif2  7.282180e+00 thiotepa
#> 749  3 30  95      mu  2.499494e-01 thiotepa
#> 750  3 30  95    surv  9.718363e-01 thiotepa
#> 751  3 30  95    cif1 -3.863651e-03 thiotepa
#> 752  3 30  95    cif2  1.364122e+01 thiotepa
#> 753  3 40  95      mu  6.172205e-01 thiotepa
#> 754  3 40  95    surv  9.182230e-01 thiotepa
#> 755  3 40  95    cif1 -3.863651e-03 thiotepa
#> 756  3 40  95    cif2  1.738255e+01 thiotepa
#> 757  3 20  96      mu -5.125478e-02 thiotepa
#> 758  3 20  96    surv  1.011732e+00 thiotepa
#> 759  3 20  96    cif1 -1.773484e-03 thiotepa
#> 760  3 20  96    cif2  7.282180e+00 thiotepa
#> 761  3 30  96      mu  2.499494e-01 thiotepa
#> 762  3 30  96    surv  9.718363e-01 thiotepa
#> 763  3 30  96    cif1 -3.863651e-03 thiotepa
#> 764  3 30  96    cif2  1.364122e+01 thiotepa
#> 765  3 40  96      mu  6.172205e-01 thiotepa
#> 766  3 40  96    surv  9.182230e-01 thiotepa
#> 767  3 40  96    cif1 -3.863651e-03 thiotepa
#> 768  3 40  96    cif2  1.738255e+01 thiotepa
#> 769  3 20  97      mu  3.116590e+00 thiotepa
#> 770  3 20  97    surv  1.011732e+00 thiotepa
#> 771  3 20  97    cif1 -1.773484e-03 thiotepa
#> 772  3 20  97    cif2  7.282180e+00 thiotepa
#> 773  3 30  97      mu  3.295753e+00 thiotepa
#> 774  3 30  97    surv  9.718363e-01 thiotepa
#> 775  3 30  97    cif1 -3.863651e-03 thiotepa
#> 776  3 30  97    cif2  1.364122e+01 thiotepa
#> 777  3 40  97      mu  3.663024e+00 thiotepa
#> 778  3 40  97    surv  9.182230e-01 thiotepa
#> 779  3 40  97    cif1 -3.863651e-03 thiotepa
#> 780  3 40  97    cif2  1.738255e+01 thiotepa
#> 781  3 20  98      mu  9.867199e-01 thiotepa
#> 782  3 20  98    surv  1.011732e+00 thiotepa
#> 783  3 20  98    cif1 -1.773484e-03 thiotepa
#> 784  3 20  98    cif2  7.282180e+00 thiotepa
#> 785  3 30  98      mu  1.023319e+00 thiotepa
#> 786  3 30  98    surv  9.718363e-01 thiotepa
#> 787  3 30  98    cif1 -3.863651e-03 thiotepa
#> 788  3 30  98    cif2  1.364122e+01 thiotepa
#> 789  3 40  98      mu  1.390590e+00 thiotepa
#> 790  3 40  98    surv  9.182230e-01 thiotepa
#> 791  3 40  98    cif1 -3.863651e-03 thiotepa
#> 792  3 40  98    cif2  1.738255e+01 thiotepa
#> 793  3 20  99      mu  9.610909e-01 thiotepa
#> 794  3 20  99    surv  1.011732e+00 thiotepa
#> 795  3 20  99    cif1 -1.773484e-03 thiotepa
#> 796  3 20  99    cif2  7.282180e+00 thiotepa
#> 797  3 30  99      mu  8.810702e-01 thiotepa
#> 798  3 30  99    surv  1.002097e+00 thiotepa
#> 799  3 30  99    cif1 -3.863651e-03 thiotepa
#> 800  3 30  99    cif2  1.364122e+01 thiotepa
#> 801  3 40  99      mu  1.259777e+00 thiotepa
#> 802  3 40  99    surv  9.468145e-01 thiotepa
#> 803  3 40  99    cif1 -3.863651e-03 thiotepa
#> 804  3 40  99    cif2  1.738255e+01 thiotepa
#> 805  3 20 100      mu -5.125478e-02 thiotepa
#> 806  3 20 100    surv  1.011732e+00 thiotepa
#> 807  3 20 100    cif1 -1.773484e-03 thiotepa
#> 808  3 20 100    cif2  7.282180e+00 thiotepa
#> 809  3 30 100      mu  1.083344e+00 thiotepa
#> 810  3 30 100    surv  1.038234e+00 thiotepa
#> 811  3 30 100    cif1 -3.863651e-03 thiotepa
#> 812  3 30 100    cif2  1.364122e+01 thiotepa
#> 813  3 40 100      mu  2.887608e+00 thiotepa
#> 814  3 40 100    surv  1.024653e+00 thiotepa
#> 815  3 40 100    cif1 -3.863651e-03 thiotepa
#> 816  3 40 100    cif2  1.738255e+01 thiotepa
#> 817  3 20 101      mu -5.125478e-02 thiotepa
#> 818  3 20 101    surv  1.011732e+00 thiotepa
#> 819  3 20 101    cif1 -1.773484e-03 thiotepa
#> 820  3 20 101    cif2  7.282180e+00 thiotepa
#> 821  3 30 101      mu -2.346997e-01 thiotepa
#> 822  3 30 101    surv  1.038234e+00 thiotepa
#> 823  3 30 101    cif1 -3.863651e-03 thiotepa
#> 824  3 30 101    cif2  1.364122e+01 thiotepa
#> 825  3 40 101      mu -3.583511e-01 thiotepa
#> 826  3 40 101    surv  1.024653e+00 thiotepa
#> 827  3 40 101    cif1 -3.863651e-03 thiotepa
#> 828  3 40 101    cif2  1.738255e+01 thiotepa
#> 829  3 20 102      mu -5.125478e-02 thiotepa
#> 830  3 20 102    surv  1.011732e+00 thiotepa
#> 831  3 20 102    cif1 -1.773484e-03 thiotepa
#> 832  3 20 102    cif2  7.282180e+00 thiotepa
#> 833  3 30 102      mu  3.444663e+00 thiotepa
#> 834  3 30 102    surv  1.038234e+00 thiotepa
#> 835  3 30 102    cif1 -3.863651e-03 thiotepa
#> 836  3 30 102    cif2  1.364122e+01 thiotepa
#> 837  3 40 102      mu  4.979508e+00 thiotepa
#> 838  3 40 102    surv  1.086227e+00 thiotepa
#> 839  3 40 102    cif1 -3.863651e-03 thiotepa
#> 840  3 40 102    cif2  1.738255e+01 thiotepa
#> 841  3 20 103      mu  2.071023e+00 thiotepa
#> 842  3 20 103    surv  1.011732e+00 thiotepa
#> 843  3 20 103    cif1 -1.773484e-03 thiotepa
#> 844  3 20 103    cif2  7.282180e+00 thiotepa
#> 845  3 30 103      mu  4.439933e+00 thiotepa
#> 846  3 30 103    surv  1.038234e+00 thiotepa
#> 847  3 30 103    cif1 -3.863651e-03 thiotepa
#> 848  3 30 103    cif2  1.364122e+01 thiotepa
#> 849  3 40 103      mu  9.495046e+00 thiotepa
#> 850  3 40 103    surv -9.457309e-01 thiotepa
#> 851  3 40 103    cif1 -3.863651e-03 thiotepa
#> 852  3 40 103    cif2  1.738255e+01 thiotepa
#> 853  3 20 104      mu -5.125478e-02 thiotepa
#> 854  3 20 104    surv  1.011732e+00 thiotepa
#> 855  3 20 104    cif1 -1.773484e-03 thiotepa
#> 856  3 20 104    cif2  7.282180e+00 thiotepa
#> 857  3 30 104      mu  3.742445e+00 thiotepa
#> 858  3 30 104    surv  1.038234e+00 thiotepa
#> 859  3 30 104    cif1 -3.863651e-03 thiotepa
#> 860  3 30 104    cif2  1.364122e+01 thiotepa
#> 861  3 40 104      mu  5.529208e+00 thiotepa
#> 862  3 40 104    surv  1.086227e+00 thiotepa
#> 863  3 40 104    cif1 -3.863651e-03 thiotepa
#> 864  3 40 104    cif2  1.738255e+01 thiotepa
#> 865  3 20 105      mu -5.125478e-02 thiotepa
#> 866  3 20 105    surv  1.011732e+00 thiotepa
#> 867  3 20 105    cif1 -1.773484e-03 thiotepa
#> 868  3 20 105    cif2  7.282180e+00 thiotepa
#> 869  3 30 105      mu -2.346997e-01 thiotepa
#> 870  3 30 105    surv  1.038234e+00 thiotepa
#> 871  3 30 105    cif1 -3.863651e-03 thiotepa
#> 872  3 30 105    cif2  1.364122e+01 thiotepa
#> 873  3 40 105      mu -5.476268e-01 thiotepa
#> 874  3 40 105    surv  1.086227e+00 thiotepa
#> 875  3 40 105    cif1 -3.863651e-03 thiotepa
#> 876  3 40 105    cif2  1.738255e+01 thiotepa
#> 877  3 20 106      mu -5.125478e-02 thiotepa
#> 878  3 20 106    surv  1.011732e+00 thiotepa
#> 879  3 20 106    cif1 -1.773484e-03 thiotepa
#> 880  3 20 106    cif2  7.282180e+00 thiotepa
#> 881  3 30 106      mu -2.346997e-01 thiotepa
#> 882  3 30 106    surv  1.038234e+00 thiotepa
#> 883  3 30 106    cif1 -3.863651e-03 thiotepa
#> 884  3 30 106    cif2  1.364122e+01 thiotepa
#> 885  3 40 106      mu -5.476268e-01 thiotepa
#> 886  3 40 106    surv  1.086227e+00 thiotepa
#> 887  3 40 106    cif1 -3.863651e-03 thiotepa
#> 888  3 40 106    cif2  1.738255e+01 thiotepa
#> 889  3 20 107      mu -5.125478e-02 thiotepa
#> 890  3 20 107    surv  1.011732e+00 thiotepa
#> 891  3 20 107    cif1 -1.773484e-03 thiotepa
#> 892  3 20 107    cif2  7.282180e+00 thiotepa
#> 893  3 30 107      mu  1.190940e+00 thiotepa
#> 894  3 30 107    surv  1.038234e+00 thiotepa
#> 895  3 30 107    cif1 -3.863651e-03 thiotepa
#> 896  3 30 107    cif2  1.364122e+01 thiotepa
#> 897  3 40 107      mu  8.780126e-01 thiotepa
#> 898  3 40 107    surv  1.086227e+00 thiotepa
#> 899  3 40 107    cif1 -3.863651e-03 thiotepa
#> 900  3 40 107    cif2  1.738255e+01 thiotepa
#> 901  3 20 108      mu -5.125478e-02 thiotepa
#> 902  3 20 108    surv  1.011732e+00 thiotepa
#> 903  3 20 108    cif1 -1.773484e-03 thiotepa
#> 904  3 20 108    cif2  7.282180e+00 thiotepa
#> 905  3 30 108      mu -2.346997e-01 thiotepa
#> 906  3 30 108    surv  1.038234e+00 thiotepa
#> 907  3 30 108    cif1 -3.863651e-03 thiotepa
#> 908  3 30 108    cif2  1.364122e+01 thiotepa
#> 909  3 40 108      mu -5.476268e-01 thiotepa
#> 910  3 40 108    surv  1.086227e+00 thiotepa
#> 911  3 40 108    cif1 -3.863651e-03 thiotepa
#> 912  3 40 108    cif2  1.738255e+01 thiotepa
#> 913  3 20 109      mu  2.088099e+00 thiotepa
#> 914  3 20 109    surv  1.011732e+00 thiotepa
#> 915  3 20 109    cif1 -1.773484e-03 thiotepa
#> 916  3 20 109    cif2  7.282180e+00 thiotepa
#> 917  3 30 109      mu  4.457009e+00 thiotepa
#> 918  3 30 109    surv  1.038234e+00 thiotepa
#> 919  3 30 109    cif1 -3.863651e-03 thiotepa
#> 920  3 30 109    cif2  1.364122e+01 thiotepa
#> 921  3 40 109      mu  6.114465e+00 thiotepa
#> 922  3 40 109    surv  1.086227e+00 thiotepa
#> 923  3 40 109    cif1 -3.863651e-03 thiotepa
#> 924  3 40 109    cif2  1.738255e+01 thiotepa
#> 925  3 20 110      mu -5.125478e-02 thiotepa
#> 926  3 20 110    surv  1.011732e+00 thiotepa
#> 927  3 20 110    cif1 -1.773484e-03 thiotepa
#> 928  3 20 110    cif2  7.282180e+00 thiotepa
#> 929  3 30 110      mu -2.346997e-01 thiotepa
#> 930  3 30 110    surv  1.038234e+00 thiotepa
#> 931  3 30 110    cif1 -3.863651e-03 thiotepa
#> 932  3 30 110    cif2  1.364122e+01 thiotepa
#> 933  3 40 110      mu -5.476268e-01 thiotepa
#> 934  3 40 110    surv  1.086227e+00 thiotepa
#> 935  3 40 110    cif1 -3.863651e-03 thiotepa
#> 936  3 40 110    cif2  1.738255e+01 thiotepa
#> 937  3 20 111      mu  9.610909e-01 thiotepa
#> 938  3 20 111    surv  1.011732e+00 thiotepa
#> 939  3 20 111    cif1 -1.773484e-03 thiotepa
#> 940  3 20 111    cif2  7.282180e+00 thiotepa
#> 941  3 30 111      mu  7.776460e-01 thiotepa
#> 942  3 30 111    surv  1.038234e+00 thiotepa
#> 943  3 30 111    cif1 -3.863651e-03 thiotepa
#> 944  3 30 111    cif2  1.364122e+01 thiotepa
#> 945  3 40 111      mu  4.647189e-01 thiotepa
#> 946  3 40 111    surv  1.086227e+00 thiotepa
#> 947  3 40 111    cif1 -3.863651e-03 thiotepa
#> 948  3 40 111    cif2  1.738255e+01 thiotepa
#> 949  3 20 112      mu -5.125478e-02 thiotepa
#> 950  3 20 112    surv  1.011732e+00 thiotepa
#> 951  3 20 112    cif1 -1.773484e-03 thiotepa
#> 952  3 20 112    cif2  7.282180e+00 thiotepa
#> 953  3 30 112      mu -2.346997e-01 thiotepa
#> 954  3 30 112    surv  1.038234e+00 thiotepa
#> 955  3 30 112    cif1 -3.863651e-03 thiotepa
#> 956  3 30 112    cif2  1.364122e+01 thiotepa
#> 957  3 40 112      mu -5.476268e-01 thiotepa
#> 958  3 40 112    surv  1.086227e+00 thiotepa
#> 959  3 40 112    cif1 -3.863651e-03 thiotepa
#> 960  3 40 112    cif2  1.738255e+01 thiotepa
#> 961  3 20 113      mu -5.125478e-02 thiotepa
#> 962  3 20 113    surv  1.011732e+00 thiotepa
#> 963  3 20 113    cif1 -1.773484e-03 thiotepa
#> 964  3 20 113    cif2  7.282180e+00 thiotepa
#> 965  3 30 113      mu -2.346997e-01 thiotepa
#> 966  3 30 113    surv  1.038234e+00 thiotepa
#> 967  3 30 113    cif1 -3.863651e-03 thiotepa
#> 968  3 30 113    cif2  1.364122e+01 thiotepa
#> 969  3 40 113      mu -5.476268e-01 thiotepa
#> 970  3 40 113    surv  1.086227e+00 thiotepa
#> 971  3 40 113    cif1 -3.863651e-03 thiotepa
#> 972  3 40 113    cif2  1.738255e+01 thiotepa
#> 973  3 20 114      mu -5.125478e-02 thiotepa
#> 974  3 20 114    surv  1.011732e+00 thiotepa
#> 975  3 20 114    cif1 -1.773484e-03 thiotepa
#> 976  3 20 114    cif2  7.282180e+00 thiotepa
#> 977  3 30 114      mu -2.346997e-01 thiotepa
#> 978  3 30 114    surv  1.038234e+00 thiotepa
#> 979  3 30 114    cif1 -3.863651e-03 thiotepa
#> 980  3 30 114    cif2  1.364122e+01 thiotepa
#> 981  3 40 114      mu -5.476268e-01 thiotepa
#> 982  3 40 114    surv  1.086227e+00 thiotepa
#> 983  3 40 114    cif1 -3.863651e-03 thiotepa
#> 984  3 40 114    cif2  1.738255e+01 thiotepa
#> 985  3 20 115      mu  9.610909e-01 thiotepa
#> 986  3 20 115    surv  1.011732e+00 thiotepa
#> 987  3 20 115    cif1 -1.773484e-03 thiotepa
#> 988  3 20 115    cif2  7.282180e+00 thiotepa
#> 989  3 30 115      mu  1.982066e+00 thiotepa
#> 990  3 30 115    surv  1.038234e+00 thiotepa
#> 991  3 30 115    cif1 -3.863651e-03 thiotepa
#> 992  3 30 115    cif2  1.364122e+01 thiotepa
#> 993  3 40 115      mu  1.669138e+00 thiotepa
#> 994  3 40 115    surv  1.086227e+00 thiotepa
#> 995  3 40 115    cif1 -3.863651e-03 thiotepa
#> 996  3 40 115    cif2  1.738255e+01 thiotepa
#> 997  3 20 116      mu -5.125478e-02 thiotepa
#> 998  3 20 116    surv  1.011732e+00 thiotepa
#> 999  3 20 116    cif1 -1.773484e-03 thiotepa
#> 1000 3 20 116    cif2  7.282180e+00 thiotepa
#> 1001 3 30 116      mu -2.346997e-01 thiotepa
#> 1002 3 30 116    surv  1.038234e+00 thiotepa
#> 1003 3 30 116    cif1 -3.863651e-03 thiotepa
#> 1004 3 30 116    cif2  1.364122e+01 thiotepa
#> 1005 3 40 116      mu -5.476268e-01 thiotepa
#> 1006 3 40 116    surv  1.086227e+00 thiotepa
#> 1007 3 40 116    cif1 -3.863651e-03 thiotepa
#> 1008 3 40 116    cif2  1.738255e+01 thiotepa
#> 1009 3 20 117      mu -5.125478e-02 thiotepa
#> 1010 3 20 117    surv  1.011732e+00 thiotepa
#> 1011 3 20 117    cif1 -1.773484e-03 thiotepa
#> 1012 3 20 117    cif2  7.282180e+00 thiotepa
#> 1013 3 30 117      mu -2.346997e-01 thiotepa
#> 1014 3 30 117    surv  1.038234e+00 thiotepa
#> 1015 3 30 117    cif1 -3.863651e-03 thiotepa
#> 1016 3 30 117    cif2  1.364122e+01 thiotepa
#> 1017 3 40 117      mu  1.422757e+00 thiotepa
#> 1018 3 40 117    surv  1.086227e+00 thiotepa
#> 1019 3 40 117    cif1 -3.863651e-03 thiotepa
#> 1020 3 40 117    cif2  1.738255e+01 thiotepa
#> 1021 3 20 118      mu -5.125478e-02 thiotepa
#> 1022 3 20 118    surv  1.011732e+00 thiotepa
#> 1023 3 20 118    cif1 -1.773484e-03 thiotepa
#> 1024 3 20 118    cif2  7.282180e+00 thiotepa
#> 1025 3 30 118      mu -2.346997e-01 thiotepa
#> 1026 3 30 118    surv  1.038234e+00 thiotepa
#> 1027 3 30 118    cif1 -3.863651e-03 thiotepa
#> 1028 3 30 118    cif2  1.364122e+01 thiotepa
#> 1029 3 40 118      mu -5.476268e-01 thiotepa
#> 1030 3 40 118    surv  1.086227e+00 thiotepa
#> 1031 3 40 118    cif1 -3.863651e-03 thiotepa
#> 1032 3 40 118    cif2  1.738255e+01 thiotepa
#> 
#> $outdata
#>                mu          surv          cif1      cif2 k ts  id        Z
#> 1    0.000000e+00  0.000000e+00  0.0000000000  7.283953 3 20   1  placebo
#> 2    1.421085e-14  1.421085e-14  0.0000000000 13.645080 3 30   1  placebo
#> 3    0.000000e+00  1.421085e-14  0.0000000000 17.386414 3 40   1  placebo
#> 4    0.000000e+00  0.000000e+00  0.0000000000  7.283953 3 20   2  placebo
#> 5    1.421085e-14  1.421085e-14  0.0000000000 13.645080 3 30   2  placebo
#> 6    0.000000e+00  1.421085e-14  0.0000000000 17.386414 3 40   2  placebo
#> 7    6.673453e-01  8.812079e-01  0.0135570448  7.297510 3 20   3  placebo
#> 8    1.208604e+00  8.170875e-01  0.0273292808 13.672410 3 30   3  placebo
#> 9    1.517393e+00  7.720112e-01  0.0273292808 17.413743 3 40   3  placebo
#> 10   5.129305e-01  8.812079e-01  0.0135570448  7.297510 3 20   4  placebo
#> 11   1.054189e+00  8.170875e-01  0.0273292808 13.672410 3 30   4  placebo
#> 12   1.362978e+00  7.720112e-01  0.0273292808 17.413743 3 40   4  placebo
#> 13  -8.057054e-02 -5.722129e-02 -0.0008803276  7.283073 3 20   5  placebo
#> 14  -1.157172e-01 -5.305763e-02 -0.0017746286 13.643306 3 30   5  placebo
#> 15  -1.357684e-01 -5.013059e-02 -0.0017746286 17.384639 3 40   5  placebo
#> 16   9.574041e-01 -5.722129e-02 -0.0008803276  7.283073 3 20   6  placebo
#> 17   9.222575e-01 -5.305763e-02 -0.0017746286 13.643306 3 30   6  placebo
#> 18   9.022063e-01 -5.013059e-02 -0.0017746286 17.384639 3 40   6  placebo
#> 19   2.844923e-01  9.187451e-01  0.0141345397  7.298088 3 20   7  placebo
#> 20   8.488068e-01  8.518933e-01  0.0284934372 13.673574 3 30   7  placebo
#> 21   1.170750e+00  8.048968e-01  0.0284934372 17.414907 3 40   7  placebo
#> 22   3.256033e-02  9.946559e-01  0.0153023978  7.299256 3 20   8  placebo
#> 23   6.435010e-01  9.222804e-01  0.0308476908 13.675928 3 30   8  placebo
#> 24   9.920443e-01  8.714009e-01  0.0308476908 17.417262 3 40   8  placebo
#> 25   9.583828e-01 -9.845931e-02 -0.0015147586  7.282439 3 20   9  placebo
#> 26   8.979068e-01 -9.129499e-02 -0.0030535610 13.642027 3 30   9  placebo
#> 27   8.634051e-01 -8.625851e-02 -0.0030535610 17.383360 3 40   9  placebo
#> 28   2.108250e+00 -9.845931e-02 -0.0015147586  7.282439 3 20  10  placebo
#> 29   2.047774e+00 -9.129499e-02 -0.0030535610 13.642027 3 30  10  placebo
#> 30   2.013272e+00 -8.625851e-02 -0.0030535610 17.383360 3 40  10  placebo
#> 31  -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  11  placebo
#> 32   4.146931e-01  9.718363e-01 -0.0038636513 13.641217 3 30  11  placebo
#> 33   7.819642e-01  9.182230e-01 -0.0038636513 17.382550 3 40  11  placebo
#> 34   2.082122e+00  1.011732e+00 -0.0017734841  7.282180 3 20  12  placebo
#> 35   2.548069e+00  9.718363e-01 -0.0038636513 13.641217 3 30  12  placebo
#> 36   2.915341e+00  9.182230e-01 -0.0038636513 17.382550 3 40  12  placebo
#> 37   2.071023e+00  1.011732e+00 -0.0017734841  7.282180 3 20  13  placebo
#> 38   3.663686e+00  9.718363e-01 -0.0038636513 13.641217 3 30  13  placebo
#> 39   4.030957e+00  9.182230e-01 -0.0038636513 17.382550 3 40  13  placebo
#> 40   2.012373e+00  1.011732e+00 -0.0017734841  7.282180 3 20  14  placebo
#> 41   2.950692e+00 -1.240067e-01  1.1413221035 14.786402 3 30  14  placebo
#> 42   2.903828e+00 -1.171656e-01  1.1413221035 18.527736 3 40  14  placebo
#> 43   3.120096e+00  1.011732e+00 -0.0017734841  7.282180 3 20  15  placebo
#> 44   4.667980e+00  9.718363e-01 -0.0038636513 13.641217 3 30  15  placebo
#> 45   5.035251e+00  9.182230e-01 -0.0038636513 17.382550 3 40  15  placebo
#> 46   2.071023e+00  1.011732e+00 -0.0017734841  7.282180 3 20  16  placebo
#> 47   3.597777e+00  9.718363e-01 -0.0038636513 13.641217 3 30  16  placebo
#> 48   3.965048e+00  9.182230e-01 -0.0038636513 17.382550 3 40  16  placebo
#> 49  -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  17  placebo
#> 50   1.279083e-01  9.718363e-01 -0.0038636513 13.641217 3 30  17  placebo
#> 51   4.951794e-01  9.182230e-01 -0.0038636513 17.382550 3 40  17  placebo
#> 52  -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  18  placebo
#> 53   1.279083e-01  9.718363e-01 -0.0038636513 13.641217 3 30  18  placebo
#> 54   4.951794e-01  9.182230e-01 -0.0038636513 17.382550 3 40  18  placebo
#> 55   9.610909e-01  1.011732e+00 -0.0017734841  7.282180 3 20  19  placebo
#> 56   2.458298e+00  9.718363e-01 -0.0038636513 13.641217 3 30  19  placebo
#> 57   2.825569e+00  9.182230e-01 -0.0038636513 17.382550 3 40  19  placebo
#> 58  -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  20  placebo
#> 59   1.181193e+00  9.718363e-01 -0.0038636513 13.641217 3 30  20  placebo
#> 60   1.548464e+00  9.182230e-01 -0.0038636513 17.382550 3 40  20  placebo
#> 61  -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  21  placebo
#> 62  -1.312755e-01  1.002097e+00 -0.0038636513 13.641217 3 30  21  placebo
#> 63   2.474316e-01  9.468145e-01 -0.0038636513 17.382550 3 40  21  placebo
#> 64  -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  22  placebo
#> 65  -1.312755e-01  1.002097e+00 -0.0038636513 13.641217 3 30  22  placebo
#> 66   2.474316e-01  9.468145e-01 -0.0038636513 17.382550 3 40  22  placebo
#> 67  -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  23  placebo
#> 68  -3.251819e-01 -4.504280e-01 -0.0038636513 13.641217 3 30  23  placebo
#> 69  -4.954052e-01 -4.255792e-01 -0.0038636513 17.382550 3 40  23  placebo
#> 70  -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  24  placebo
#> 71   2.773664e+00  1.038234e+00 -0.0038636513 13.641217 3 30  24  placebo
#> 72   3.166028e+00  9.809573e-01 -0.0038636513 17.382550 3 40  24  placebo
#> 73   2.055390e+00  1.011732e+00 -0.0017734841  7.282180 3 20  25  placebo
#> 74   2.998954e+00  1.038234e+00 -0.0038636513 13.641217 3 30  25  placebo
#> 75   3.391317e+00  9.809573e-01 -0.0038636513 17.382550 3 40  25  placebo
#> 76   4.115283e+00  1.011732e+00 -0.0017734841  7.282180 3 20  26  placebo
#> 77   5.138952e+00 -5.517670e-01 -0.0038636513 13.641217 3 30  26  placebo
#> 78   4.930431e+00 -5.213276e-01 -0.0038636513 17.382550 3 40  26  placebo
#> 79   2.123613e+00  1.011732e+00 -0.0017734841  7.282180 3 20  27  placebo
#> 80   3.144587e+00  1.038234e+00 -0.0038636513 13.641217 3 30  27  placebo
#> 81   3.536951e+00  9.809573e-01 -0.0038636513 17.382550 3 40  27  placebo
#> 82  -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  28  placebo
#> 83  -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30  28  placebo
#> 84   1.148563e-01  9.809573e-01 -0.0038636513 17.382550 3 40  28  placebo
#> 85  -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  29  placebo
#> 86  -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30  29  placebo
#> 87  -5.954664e-01 -6.794629e-01 -0.0038636513 17.382550 3 40  29  placebo
#> 88  -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  30  placebo
#> 89  -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30  30  placebo
#> 90  -1.878053e-01  1.024653e+00 -0.0038636513 17.382550 3 40  30  placebo
#> 91  -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  31  placebo
#> 92   1.219982e+00  1.038234e+00 -0.0038636513 13.641217 3 30  31  placebo
#> 93   1.266876e+00  1.024653e+00 -0.0038636513 17.382550 3 40  31  placebo
#> 94  -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  32  placebo
#> 95  -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30  32  placebo
#> 96  -2.424462e-01  1.024653e+00 -0.0038636513 17.382550 3 40  32  placebo
#> 97   2.094327e+00  1.011732e+00 -0.0017734841  7.282180 3 20  33  placebo
#> 98   4.242310e+00  1.038234e+00 -0.0038636513 13.641217 3 30  33  placebo
#> 99   3.929382e+00  1.086227e+00 -0.0038636513 17.382550 3 40  33  placebo
#> 100  2.168347e+00  1.011732e+00 -0.0017734841  7.282180 3 20  34  placebo
#> 101  4.566299e+00  1.038234e+00 -0.0038636513 13.641217 3 30  34  placebo
#> 102  8.064184e+00  1.086227e+00 -0.0038636513 17.382550 3 40  34  placebo
#> 103 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  35  placebo
#> 104 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30  35  placebo
#> 105 -5.476268e-01  1.086227e+00 -0.0038636513 17.382550 3 40  35  placebo
#> 106  9.610909e-01  1.011732e+00 -0.0017734841  7.282180 3 20  36  placebo
#> 107  7.776460e-01  1.038234e+00 -0.0038636513 13.641217 3 30  36  placebo
#> 108  4.647189e-01  1.086227e+00 -0.0038636513 17.382550 3 40  36  placebo
#> 109  9.867199e-01  1.011732e+00 -0.0017734841  7.282180 3 20  37  placebo
#> 110  8.032750e-01  1.038234e+00 -0.0038636513 13.641217 3 30  37  placebo
#> 111  4.903479e-01  1.086227e+00 -0.0038636513 17.382550 3 40  37  placebo
#> 112  3.050348e+00  1.011732e+00 -0.0017734841  7.282180 3 20  38  placebo
#> 113  2.866903e+00  1.038234e+00 -0.0038636513 13.641217 3 30  38  placebo
#> 114  2.553976e+00  1.086227e+00 -0.0038636513 17.382550 3 40  38  placebo
#> 115  3.191971e+00  1.011732e+00 -0.0017734841  7.282180 3 20  39  placebo
#> 116  5.879593e+00  1.038234e+00 -0.0038636513 13.641217 3 30  39  placebo
#> 117  5.566666e+00  1.086227e+00 -0.0038636513 17.382550 3 40  39  placebo
#> 118  9.952528e-01  1.011732e+00 -0.0017734841  7.282180 3 20  40  placebo
#> 119  8.118079e-01  1.038234e+00 -0.0038636513 13.641217 3 30  40  placebo
#> 120  4.988808e-01  1.086227e+00 -0.0038636513 17.382550 3 40  40  placebo
#> 121 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  41  placebo
#> 122 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30  41  placebo
#> 123 -5.476268e-01  1.086227e+00 -0.0038636513 17.382550 3 40  41  placebo
#> 124 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  42  placebo
#> 125 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30  42  placebo
#> 126  1.209742e+00  1.086227e+00 -0.0038636513 17.382550 3 40  42  placebo
#> 127  1.043045e+00  1.011732e+00 -0.0017734841  7.282180 3 20  43  placebo
#> 128  8.595998e-01  1.038234e+00 -0.0038636513 13.641217 3 30  43  placebo
#> 129  5.466726e-01  1.086227e+00 -0.0038636513 17.382550 3 40  43  placebo
#> 130  2.071023e+00  1.011732e+00 -0.0017734841  7.282180 3 20  44  placebo
#> 131  1.887578e+00  1.038234e+00 -0.0038636513 13.641217 3 30  44  placebo
#> 132  1.574651e+00  1.086227e+00 -0.0038636513 17.382550 3 40  44  placebo
#> 133 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  45  placebo
#> 134 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30  45  placebo
#> 135 -5.476268e-01  1.086227e+00 -0.0038636513 17.382550 3 40  45  placebo
#> 136  2.071023e+00  1.011732e+00 -0.0017734841  7.282180 3 20  46  placebo
#> 137  4.645022e+00  1.038234e+00 -0.0038636513 13.641217 3 30  46  placebo
#> 138  8.011676e+00  1.086227e+00 -0.0038636513 17.382550 3 40  46  placebo
#> 139  3.162938e+00  1.011732e+00 -0.0017734841  7.282180 3 20  47  placebo
#> 140  4.405133e+00  1.038234e+00 -0.0038636513 13.641217 3 30  47  placebo
#> 141  4.092205e+00  1.086227e+00 -0.0038636513 17.382550 3 40  47  placebo
#> 142  5.236543e+00  1.011732e+00 -0.0017734841  7.282180 3 20  48  placebo
#> 143  6.162496e+00  1.038234e+00 -0.0038636513 13.641217 3 30  48  placebo
#> 144  7.606938e+00  1.086227e+00 -0.0038636513 17.382550 3 40  48  placebo
#> 145  9.019132e-01  8.812079e-01  0.0135570448  7.297510 3 20  81 thiotepa
#> 146  1.443171e+00  8.170875e-01  0.0273292808 13.672410 3 30  81 thiotepa
#> 147  1.751961e+00  7.720112e-01  0.0273292808 17.413743 3 40  81 thiotepa
#> 148  0.000000e+00  0.000000e+00  0.0000000000  7.283953 3 20  82 thiotepa
#> 149  1.421085e-14  1.421085e-14  0.0000000000 13.645080 3 30  82 thiotepa
#> 150  0.000000e+00  1.421085e-14  0.0000000000 17.386414 3 40  82 thiotepa
#> 151  1.641728e+00  8.812079e-01  0.0135570448  7.297510 3 20  83 thiotepa
#> 152  2.182986e+00  8.170875e-01  0.0273292808 13.672410 3 30  83 thiotepa
#> 153  2.491776e+00  7.720112e-01  0.0273292808 17.413743 3 40  83 thiotepa
#> 154  4.330863e-01  8.812079e-01  0.0135570448  7.297510 3 20  84 thiotepa
#> 155  9.743446e-01  8.170875e-01  0.0273292808 13.672410 3 30  84 thiotepa
#> 156  1.283134e+00  7.720112e-01  0.0273292808 17.413743 3 40  84 thiotepa
#> 157 -8.057054e-02 -5.722129e-02 -0.0008803276  7.283073 3 20  85 thiotepa
#> 158 -1.157172e-01 -5.305763e-02 -0.0017746286 13.643306 3 30  85 thiotepa
#> 159 -1.357684e-01 -5.013059e-02 -0.0017746286 17.384639 3 40  85 thiotepa
#> 160  2.990805e-01  9.187451e-01  0.0141345397  7.298088 3 20  86 thiotepa
#> 161  8.633950e-01  8.518933e-01  0.0284934372 13.673574 3 30  86 thiotepa
#> 162  1.185338e+00  8.048968e-01  0.0284934372 17.414907 3 40  86 thiotepa
#> 163  1.296838e+00  9.187451e-01  0.0141345397  7.298088 3 20  87 thiotepa
#> 164  1.861153e+00  8.518933e-01  0.0284934372 13.673574 3 30  87 thiotepa
#> 165  2.183095e+00  8.048968e-01  0.0284934372 17.414907 3 40  87 thiotepa
#> 166  3.953313e+00 -9.845931e-02 -0.0015147586  7.282439 3 20  88 thiotepa
#> 167  3.892837e+00 -9.129499e-02 -0.0030535610 13.642027 3 30  88 thiotepa
#> 168  3.858335e+00 -8.625851e-02 -0.0030535610 17.383360 3 40  88 thiotepa
#> 169 -6.661721e-02 -9.845931e-02 -0.0015147586  7.282439 3 20  89 thiotepa
#> 170 -1.270932e-01 -9.129499e-02 -0.0030535610 13.642027 3 30  89 thiotepa
#> 171 -1.615949e-01 -8.625851e-02 -0.0030535610 17.383360 3 40  89 thiotepa
#> 172  1.027682e+00 -9.845931e-02 -0.0015147586  7.282439 3 20  90 thiotepa
#> 173  9.672063e-01 -9.129499e-02 -0.0030535610 13.642027 3 30  90 thiotepa
#> 174  9.327046e-01 -8.625851e-02 -0.0030535610 17.383360 3 40  90 thiotepa
#> 175  9.090751e-01 -1.152765e-01  1.1252347190  8.409188 3 20  91 thiotepa
#> 176  8.382697e-01 -1.068885e-01  1.1234330844 14.768513 3 30  91 thiotepa
#> 177  7.978749e-01 -1.009917e-01  1.1234330844 18.509847 3 40  91 thiotepa
#> 178  2.152714e+00  1.011732e+00 -0.0017734841  7.282180 3 20  92 thiotepa
#> 179  2.047232e+00 -1.068885e-01 -0.0035751187 13.641505 3 30  92 thiotepa
#> 180  2.006837e+00 -1.009917e-01 -0.0035751187 17.382839 3 40  92 thiotepa
#> 181 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  93 thiotepa
#> 182  4.940266e-01  9.544420e-01  0.0143139004 13.659394 3 30  93 thiotepa
#> 183  8.547242e-01  9.017882e-01  0.0143139004 17.400728 3 40  93 thiotepa
#> 184 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  94 thiotepa
#> 185  2.499494e-01  9.718363e-01 -0.0038636513 13.641217 3 30  94 thiotepa
#> 186  6.172205e-01  9.182230e-01 -0.0038636513 17.382550 3 40  94 thiotepa
#> 187 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  95 thiotepa
#> 188  2.499494e-01  9.718363e-01 -0.0038636513 13.641217 3 30  95 thiotepa
#> 189  6.172205e-01  9.182230e-01 -0.0038636513 17.382550 3 40  95 thiotepa
#> 190 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20  96 thiotepa
#> 191  2.499494e-01  9.718363e-01 -0.0038636513 13.641217 3 30  96 thiotepa
#> 192  6.172205e-01  9.182230e-01 -0.0038636513 17.382550 3 40  96 thiotepa
#> 193  3.116590e+00  1.011732e+00 -0.0017734841  7.282180 3 20  97 thiotepa
#> 194  3.295753e+00  9.718363e-01 -0.0038636513 13.641217 3 30  97 thiotepa
#> 195  3.663024e+00  9.182230e-01 -0.0038636513 17.382550 3 40  97 thiotepa
#> 196  9.867199e-01  1.011732e+00 -0.0017734841  7.282180 3 20  98 thiotepa
#> 197  1.023319e+00  9.718363e-01 -0.0038636513 13.641217 3 30  98 thiotepa
#> 198  1.390590e+00  9.182230e-01 -0.0038636513 17.382550 3 40  98 thiotepa
#> 199  9.610909e-01  1.011732e+00 -0.0017734841  7.282180 3 20  99 thiotepa
#> 200  8.810702e-01  1.002097e+00 -0.0038636513 13.641217 3 30  99 thiotepa
#> 201  1.259777e+00  9.468145e-01 -0.0038636513 17.382550 3 40  99 thiotepa
#> 202 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 100 thiotepa
#> 203  1.083344e+00  1.038234e+00 -0.0038636513 13.641217 3 30 100 thiotepa
#> 204  2.887608e+00  1.024653e+00 -0.0038636513 17.382550 3 40 100 thiotepa
#> 205 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 101 thiotepa
#> 206 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30 101 thiotepa
#> 207 -3.583511e-01  1.024653e+00 -0.0038636513 17.382550 3 40 101 thiotepa
#> 208 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 102 thiotepa
#> 209  3.444663e+00  1.038234e+00 -0.0038636513 13.641217 3 30 102 thiotepa
#> 210  4.979508e+00  1.086227e+00 -0.0038636513 17.382550 3 40 102 thiotepa
#> 211  2.071023e+00  1.011732e+00 -0.0017734841  7.282180 3 20 103 thiotepa
#> 212  4.439933e+00  1.038234e+00 -0.0038636513 13.641217 3 30 103 thiotepa
#> 213  9.495046e+00 -9.457309e-01 -0.0038636513 17.382550 3 40 103 thiotepa
#> 214 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 104 thiotepa
#> 215  3.742445e+00  1.038234e+00 -0.0038636513 13.641217 3 30 104 thiotepa
#> 216  5.529208e+00  1.086227e+00 -0.0038636513 17.382550 3 40 104 thiotepa
#> 217 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 105 thiotepa
#> 218 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30 105 thiotepa
#> 219 -5.476268e-01  1.086227e+00 -0.0038636513 17.382550 3 40 105 thiotepa
#> 220 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 106 thiotepa
#> 221 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30 106 thiotepa
#> 222 -5.476268e-01  1.086227e+00 -0.0038636513 17.382550 3 40 106 thiotepa
#> 223 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 107 thiotepa
#> 224  1.190940e+00  1.038234e+00 -0.0038636513 13.641217 3 30 107 thiotepa
#> 225  8.780126e-01  1.086227e+00 -0.0038636513 17.382550 3 40 107 thiotepa
#> 226 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 108 thiotepa
#> 227 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30 108 thiotepa
#> 228 -5.476268e-01  1.086227e+00 -0.0038636513 17.382550 3 40 108 thiotepa
#> 229  2.088099e+00  1.011732e+00 -0.0017734841  7.282180 3 20 109 thiotepa
#> 230  4.457009e+00  1.038234e+00 -0.0038636513 13.641217 3 30 109 thiotepa
#> 231  6.114465e+00  1.086227e+00 -0.0038636513 17.382550 3 40 109 thiotepa
#> 232 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 110 thiotepa
#> 233 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30 110 thiotepa
#> 234 -5.476268e-01  1.086227e+00 -0.0038636513 17.382550 3 40 110 thiotepa
#> 235  9.610909e-01  1.011732e+00 -0.0017734841  7.282180 3 20 111 thiotepa
#> 236  7.776460e-01  1.038234e+00 -0.0038636513 13.641217 3 30 111 thiotepa
#> 237  4.647189e-01  1.086227e+00 -0.0038636513 17.382550 3 40 111 thiotepa
#> 238 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 112 thiotepa
#> 239 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30 112 thiotepa
#> 240 -5.476268e-01  1.086227e+00 -0.0038636513 17.382550 3 40 112 thiotepa
#> 241 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 113 thiotepa
#> 242 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30 113 thiotepa
#> 243 -5.476268e-01  1.086227e+00 -0.0038636513 17.382550 3 40 113 thiotepa
#> 244 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 114 thiotepa
#> 245 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30 114 thiotepa
#> 246 -5.476268e-01  1.086227e+00 -0.0038636513 17.382550 3 40 114 thiotepa
#> 247  9.610909e-01  1.011732e+00 -0.0017734841  7.282180 3 20 115 thiotepa
#> 248  1.982066e+00  1.038234e+00 -0.0038636513 13.641217 3 30 115 thiotepa
#> 249  1.669138e+00  1.086227e+00 -0.0038636513 17.382550 3 40 115 thiotepa
#> 250 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 116 thiotepa
#> 251 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30 116 thiotepa
#> 252 -5.476268e-01  1.086227e+00 -0.0038636513 17.382550 3 40 116 thiotepa
#> 253 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 117 thiotepa
#> 254 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30 117 thiotepa
#> 255  1.422757e+00  1.086227e+00 -0.0038636513 17.382550 3 40 117 thiotepa
#> 256 -5.125478e-02  1.011732e+00 -0.0017734841  7.282180 3 20 118 thiotepa
#> 257 -2.346997e-01  1.038234e+00 -0.0038636513 13.641217 3 30 118 thiotepa
#> 258 -5.476268e-01  1.086227e+00 -0.0038636513 17.382550 3 40 118 thiotepa
#> 
#> $k
#> [1] 3
#> 
#> $ts
#> [1] 20 30 40
#> 
#> $indata
#>      id treatment number size recur start stop status rtumor rsize enum status3
#> 1     1   placebo      1    1     0     0    1      2      .     .    1       2
#> 2     2   placebo      1    3     0     0    1      2      .     .    1       2
#> 3     3   placebo      2    1     0     0    4      0      .     .    1       0
#> 4     4   placebo      1    1     0     0    7      0      .     .    1       0
#> 5     5   placebo      5    1     0     0   10      2      .     .    1       2
#> 6     6   placebo      4    1     1     0    6      1      1     1    1       1
#> 7     6   placebo      4    1     1     6   10      2      .     .    2       2
#> 8     7   placebo      1    1     0     0   14      0      .     .    1       0
#> 9     8   placebo      1    1     0     0   18      0      .     .    1       0
#> 10    9   placebo      1    3     1     0    5      1      2     4    1       1
#> 11    9   placebo      1    3     1     5   18      2      .     .    2       2
#> 12   10   placebo      1    1     2     0   12      1      2     2    1       1
#> 13   10   placebo      1    1     2    12   16      1      3     .    2       1
#> 14   10   placebo      1    1     2    16   18      2      .     .    3       2
#> 15   11   placebo      3    3     0     0   23      0      .     .    1       0
#> 16   12   placebo      1    3     2     0   10      1      6     1    1       1
#> 17   12   placebo      1    3     2    10   15      1      3     1    2       1
#> 18   12   placebo      1    3     2    15   23      0      .     .    3       0
#> 19   13   placebo      1    1     3     0    3      1      8     1    1       1
#> 20   13   placebo      1    1     3     3   16      1      8     .    2       1
#> 21   13   placebo      1    1     3    16   23      1      8     .    3       1
#> 22   14   placebo      3    1     3     0    3      1      1     1    1       1
#> 23   14   placebo      3    1     3     3    9      1      1     2    2       1
#> 24   14   placebo      3    1     3     9   21      1      8     8    3       1
#> 25   14   placebo      3    1     3    21   23      2      .     .    4       2
#> 26   15   placebo      2    3     4     0    7      1      8     2    1       1
#> 27   15   placebo      2    3     4     7   10      1      7     1    2       1
#> 28   15   placebo      2    3     4    10   16      1      5     3    3       1
#> 29   15   placebo      2    3     4    16   24      1      7     .    4       1
#> 30   16   placebo      1    1     3     0    3      1      1     1    1       1
#> 31   16   placebo      1    1     3     3   15      1      1     .    2       1
#> 32   16   placebo      1    1     3    15   25      1      3     .    3       1
#> 33   17   placebo      1    2     0     0   26      0      .     .    1       0
#> 34   18   placebo      8    1     1     0    1      1      8     1    1       1
#> 35   18   placebo      8    1     1     1   26      0      .     .    2       0
#> 36   19   placebo      1    4     2     0    2      1      4     1    1       1
#> 37   19   placebo      1    4     2     2   26      1      8     .    2       1
#> 38   20   placebo      1    2     1     0   25      1      3     .    1       1
#> 39   20   placebo      1    2     1    25   28      0      .     .    2       0
#> 40   21   placebo      1    4     0     0   29      0      .     .    1       0
#> 41   22   placebo      1    2     0     0   29      0      .     .    1       0
#> 42   23   placebo      4    1     0     0   29      2      .     .    1       2
#> 43   24   placebo      1    6     2     0   28      1      2     1    1       1
#> 44   24   placebo      1    6     2    28   30      1      1     1    2       1
#> 45   25   placebo      1    5     3     0    2      1      4     1    1       1
#> 46   25   placebo      1    5     3     2   17      1      2     1    2       1
#> 47   25   placebo      1    5     3    17   22      1      4     .    3       1
#> 48   25   placebo      1    5     3    22   30      0      .     .    4       0
#> 49   26   placebo      2    1     5     0    3      1      1     .    1       1
#> 50   26   placebo      2    1     5     3    6      1      3     .    2       1
#> 51   26   placebo      2    1     5     6    8      1      3     .    3       1
#> 52   26   placebo      2    1     5     8   12      1      3     .    4       1
#> 53   26   placebo      2    1     5    12   26      1      3     .    5       1
#> 54   26   placebo      2    1     5    26   30      2      .     .    6       2
#> 55   27   placebo      1    3     3     0   12      1      2     .    1       1
#> 56   27   placebo      1    3     3    12   15      1      3     1    2       1
#> 57   27   placebo      1    3     3    15   24      1      1     .    3       1
#> 58   27   placebo      1    3     3    24   31      0      .     .    4       0
#> 59   28   placebo      1    2     0     0   32      0      .     .    1       0
#> 60   29   placebo      2    1     0     0   34      2      .     .    1       2
#> 61   30   placebo      2    1     0     0   36      0      .     .    1       0
#> 62   31   placebo      3    1     1     0   29      1      8     1    1       1
#> 63   31   placebo      3    1     1    29   36      0      .     .    2       0
#> 64   32   placebo      1    2     0     0   37      0      .     .    1       0
#> 65   33   placebo      4    1     4     0    9      1      8     1    1       1
#> 66   33   placebo      4    1     4     9   17      1      2     1    2       1
#> 67   33   placebo      4    1     4    17   22      1      5     .    3       1
#> 68   33   placebo      4    1     4    22   24      1      1     .    4       1
#> 69   33   placebo      4    1     4    24   40      0      .     .    5       0
#> 70   34   placebo      5    1     6     0   16      1      1     1    1       1
#> 71   34   placebo      5    1     6    16   19      1      8     1    2       1
#> 72   34   placebo      5    1     6    19   23      1      1     1    3       1
#> 73   34   placebo      5    1     6    23   29      1      2     1    4       1
#> 74   34   placebo      5    1     6    29   34      1      1     1    5       1
#> 75   34   placebo      5    1     6    34   40      1      3     .    6       1
#> 76   35   placebo      1    2     0     0   41      0      .     .    1       0
#> 77   36   placebo      1    1     1     0    3      1      3     1    1       1
#> 78   36   placebo      1    1     1     3   43      0      .     .    2       0
#> 79   37   placebo      2    6     1     0    6      1      1     1    1       1
#> 80   37   placebo      2    6     1     6   43      0      .     .    2       0
#> 81   38   placebo      2    1     3     0    3      1      5     1    1       1
#> 82   38   placebo      2    1     3     3    6      1      3     1    2       1
#> 83   38   placebo      2    1     3     6    9      1      4     1    3       1
#> 84   38   placebo      2    1     3     9   44      0      .     .    4       0
#> 85   39   placebo      1    1     5     0    9      1      1     1    1       1
#> 86   39   placebo      1    1     5     9   11      1      3     1    2       1
#> 87   39   placebo      1    1     5    11   20      1      1     1    3       1
#> 88   39   placebo      1    1     5    20   26      1      4     1    4       1
#> 89   39   placebo      1    1     5    26   30      1      3     1    5       1
#> 90   39   placebo      1    1     5    30   45      2      .     .    6       2
#> 91   40   placebo      1    1     1     0   18      1      1     1    1       1
#> 92   40   placebo      1    1     1    18   48      0      .     .    2       0
#> 93   41   placebo      1    3     0     0   49      0      .     .    1       0
#> 94   42   placebo      3    1     1     0   35      1      1     1    1       1
#> 95   42   placebo      3    1     1    35   51      0      .     .    2       0
#> 96   43   placebo      1    7     1     0   17      1      1     1    1       1
#> 97   43   placebo      1    7     1    17   53      0      .     .    2       0
#> 98   44   placebo      3    1     5     0    3      1      7     1    1       1
#> 99   44   placebo      3    1     5     3   15      1      2     1    2       1
#> 100  44   placebo      3    1     5    15   46      1      3     .    3       1
#> 101  44   placebo      3    1     5    46   51      1      2     .    4       1
#> 102  44   placebo      3    1     5    51   53      1      1     1    5       1
#> 103  45   placebo      1    1     0     0   59      0      .     .    1       0
#> 104  46   placebo      3    2     9     0    2      1      1     3    1       1
#> 105  46   placebo      3    2     9     2   15      1      3     1    2       1
#> 106  46   placebo      3    2     9    15   24      1      4     1    3       1
#> 107  46   placebo      3    2     9    24   30      1      3     2    4       1
#> 108  46   placebo      3    2     9    30   34      1      4     1    5       1
#> 109  46   placebo      3    2     9    34   39      1      1     .    6       1
#> 110  46   placebo      3    2     9    39   43      1      1     .    7       1
#> 111  46   placebo      3    2     9    43   49      1      1     .    8       1
#> 112  46   placebo      3    2     9    49   52      1      1     .    9       1
#> 113  46   placebo      3    2     9    52   61      0      .     .   10       0
#> 114  47   placebo      1    3     5     0    5      1      3     1    1       1
#> 115  47   placebo      1    3     5     5   14      1      4     1    2       1
#> 116  47   placebo      1    3     5    14   19      1      2     1    3       1
#> 117  47   placebo      1    3     5    19   27      1      5     1    4       1
#> 118  47   placebo      1    3     5    27   41      1      .     .    5       1
#> 119  47   placebo      1    3     5    41   64      0      .     .    6       0
#> 120  48   placebo      2    3     8     0    2      1      1     1    1       1
#> 121  48   placebo      2    3     8     2    8      1      3     1    2       1
#> 122  48   placebo      2    3     8     8   12      1      6     1    3       1
#> 123  48   placebo      2    3     8    12   13      1      2     1    4       1
#> 124  48   placebo      2    3     8    13   17      1      2     1    5       1
#> 125  48   placebo      2    3     8    17   21      1      1     1    6       1
#> 126  48   placebo      2    3     8    21   33      1      1     1    7       1
#> 127  48   placebo      2    3     8    33   49      1      1     .    8       1
#> 128  48   placebo      2    3     8    49   64      0      .     .    9       0
#> 214  81  thiotepa      1    3     0     0    1      0      .     .    1       0
#> 215  82  thiotepa      1    1     0     0    1      2      .     .    1       2
#> 216  83  thiotepa      8    1     1     0    5      1      8     1    1       1
#> 217  84  thiotepa      1    2     0     0    9      0      .     .    1       0
#> 218  85  thiotepa      1    1     0     0   10      2      .     .    1       2
#> 219  86  thiotepa      1    1     0     0   13      0      .     .    1       0
#> 220  87  thiotepa      2    6     1     0    3      1      1     1    1       1
#> 221  87  thiotepa      2    6     1     3   14      0      .     .    2       0
#> 222  88  thiotepa      5    3     5     0    1      1      5     2    1       1
#> 223  88  thiotepa      5    3     5     1    3      1      2     1    2       1
#> 224  88  thiotepa      5    3     5     3    5      1      5     1    3       1
#> 225  88  thiotepa      5    3     5     5    7      1      2     1    4       1
#> 226  88  thiotepa      5    3     5     7   10      1      2     1    5       1
#> 227  88  thiotepa      5    3     5    10   17      2      .     .    6       2
#> 228  89  thiotepa      5    1     0     0   18      2      .     .    1       2
#> 229  90  thiotepa      1    3     1     0   17      1      2     1    1       1
#> 230  90  thiotepa      1    3     1    17   18      2      .     .    2       2
#> 231  91  thiotepa      5    1     1     0    2      1      2     1    1       1
#> 232  91  thiotepa      5    1     1     2   19      2      .     .    2       2
#> 233  92  thiotepa      1    1     2     0   17      1      1     1    1       1
#> 234  92  thiotepa      1    1     2    17   19      1      1     1    2       1
#> 235  92  thiotepa      1    1     2    19   21      2      .     .    3       2
#> 236  93  thiotepa      1    1     0     0   22      0      .     .    1       0
#> 237  94  thiotepa      1    3     0     0   25      0      .     .    1       0
#> 238  95  thiotepa      1    5     0     0   25      0      .     .    1       0
#> 239  96  thiotepa      1    1     0     0   25      0      .     .    1       0
#> 240  97  thiotepa      1    1     3     0    6      1      2     1    1       1
#> 241  97  thiotepa      1    1     3     6   12      1      3     1    2       1
#> 242  97  thiotepa      1    1     3    12   13      1      1     .    3       1
#> 243  97  thiotepa      1    1     3    13   26      0      .     .    4       0
#> 244  98  thiotepa      1    1     1     0    6      1      1     1    1       1
#> 245  98  thiotepa      1    1     1     6   27      0      .     .    2       0
#> 246  99  thiotepa      2    1     1     0    2      1      2     .    1       1
#> 247  99  thiotepa      2    1     1     2   29      0      .     .    2       0
#> 248 100  thiotepa      8    3     2     0   26      1      3     .    1       1
#> 249 100  thiotepa      8    3     2    26   35      1      3     .    2       1
#> 250 100  thiotepa      8    3     2    35   36      0      .     .    3       0
#> 251 101  thiotepa      1    1     0     0   38      0      .     .    1       0
#> 252 102  thiotepa      1    1     4     0   22      1      2     1    1       1
#> 253 102  thiotepa      1    1     4    22   23      1      1     1    2       1
#> 254 102  thiotepa      1    1     4    23   27      1      2     1    3       1
#> 255 102  thiotepa      1    1     4    27   32      1      3     .    4       1
#> 256 102  thiotepa      1    1     4    32   39      0      .     .    5       0
#> 257 103  thiotepa      6    1     7     0    4      1      1     1    1       1
#> 258 103  thiotepa      6    1     7     4   16      1      3     1    2       1
#> 259 103  thiotepa      6    1     7    16   23      1      3     1    3       1
#> 260 103  thiotepa      6    1     7    23   27      1      3     1    4       1
#> 261 103  thiotepa      6    1     7    27   33      1      8     .    5       1
#> 262 103  thiotepa      6    1     7    33   36      1      .     .    6       1
#> 263 103  thiotepa      6    1     7    36   37      1      8     1    7       1
#> 264 103  thiotepa      6    1     7    37   39      2      .     .    8       2
#> 265 104  thiotepa      3    1     4     0   24      1      3     1    1       1
#> 266 104  thiotepa      3    1     4    24   26      1      2     .    2       1
#> 267 104  thiotepa      3    1     4    26   29      1      1     .    3       1
#> 268 104  thiotepa      3    1     4    29   40      1      2     .    4       1
#> 269 105  thiotepa      3    2     0     0   41      0      .     .    1       0
#> 270 106  thiotepa      1    1     0     0   41      2      .     .    1       2
#> 271 107  thiotepa      1    1     2     0    1      1      1     2    1       1
#> 272 107  thiotepa      1    1     2     1   27      1      1     .    2       1
#> 273 107  thiotepa      1    1     2    27   43      0      .     .    3       0
#> 274 108  thiotepa      1    1     0     0   44      0      .     .    1       0
#> 275 109  thiotepa      6    1     5     0    2      1      2     1    1       1
#> 276 109  thiotepa      6    1     5     2   20      1      1     1    2       1
#> 277 109  thiotepa      6    1     5    20   23      1      2     1    3       1
#> 278 109  thiotepa      6    1     5    23   27      1      1     1    4       1
#> 279 109  thiotepa      6    1     5    27   38      1      8     .    5       1
#> 280 109  thiotepa      6    1     5    38   44      0      .     .    6       0
#> 281 110  thiotepa      1    2     0     0   45      0      .     .    1       0
#> 282 111  thiotepa      1    4     1     0    2      1      1     1    1       1
#> 283 111  thiotepa      1    4     1     2   46      0      .     .    2       0
#> 284 112  thiotepa      1    4     0     0   46      2      .     .    1       2
#> 285 113  thiotepa      3    3     0     0   49      0      .     .    1       0
#> 286 114  thiotepa      1    1     0     0   50      0      .     .    1       0
#> 287 115  thiotepa      4    1     3     0    4      1      1     1    1       1
#> 288 115  thiotepa      4    1     3     4   24      1      1     1    2       1
#> 289 115  thiotepa      4    1     3    24   47      1      1     .    3       1
#> 290 115  thiotepa      4    1     3    47   50      0      .     .    4       0
#> 291 116  thiotepa      3    4     0     0   54      0      .     .    1       0
#> 292 117  thiotepa      2    1     1     0   38      1      2     1    1       1
#> 293 117  thiotepa      2    1     1    38   54      0      .     .    2       0
#> 294 118  thiotepa      1    3     0     0   59      2      .     .    1       2
#>            Z deathtype tstart tstop
#> 1    placebo         2      0     1
#> 2    placebo         2      0     1
#> 3    placebo         0      0     4
#> 4    placebo         0      0     7
#> 5    placebo         2      0    10
#> 6    placebo         0      0     6
#> 7    placebo         2      6    10
#> 8    placebo         0      0    14
#> 9    placebo         0      0    18
#> 10   placebo         0      0     5
#> 11   placebo         2      5    18
#> 12   placebo         0      0    12
#> 13   placebo         0     12    16
#> 14   placebo         2     16    18
#> 15   placebo         0      0    23
#> 16   placebo         0      0    10
#> 17   placebo         0     10    15
#> 18   placebo         0     15    23
#> 19   placebo         0      0     3
#> 20   placebo         0      3    16
#> 21   placebo         0     16    23
#> 22   placebo         0      0     3
#> 23   placebo         0      3     9
#> 24   placebo         0      9    21
#> 25   placebo         1     21    23
#> 26   placebo         0      0     7
#> 27   placebo         0      7    10
#> 28   placebo         0     10    16
#> 29   placebo         0     16    24
#> 30   placebo         0      0     3
#> 31   placebo         0      3    15
#> 32   placebo         0     15    25
#> 33   placebo         0      0    26
#> 34   placebo         0      0     1
#> 35   placebo         0      1    26
#> 36   placebo         0      0     2
#> 37   placebo         0      2    26
#> 38   placebo         0      0    25
#> 39   placebo         0     25    28
#> 40   placebo         0      0    29
#> 41   placebo         0      0    29
#> 42   placebo         2      0    29
#> 43   placebo         0      0    28
#> 44   placebo         0     28    30
#> 45   placebo         0      0     2
#> 46   placebo         0      2    17
#> 47   placebo         0     17    22
#> 48   placebo         0     22    30
#> 49   placebo         0      0     3
#> 50   placebo         0      3     6
#> 51   placebo         0      6     8
#> 52   placebo         0      8    12
#> 53   placebo         0     12    26
#> 54   placebo         2     26    30
#> 55   placebo         0      0    12
#> 56   placebo         0     12    15
#> 57   placebo         0     15    24
#> 58   placebo         0     24    31
#> 59   placebo         0      0    32
#> 60   placebo         2      0    34
#> 61   placebo         0      0    36
#> 62   placebo         0      0    29
#> 63   placebo         0     29    36
#> 64   placebo         0      0    37
#> 65   placebo         0      0     9
#> 66   placebo         0      9    17
#> 67   placebo         0     17    22
#> 68   placebo         0     22    24
#> 69   placebo         0     24    40
#> 70   placebo         0      0    16
#> 71   placebo         0     16    19
#> 72   placebo         0     19    23
#> 73   placebo         0     23    29
#> 74   placebo         0     29    34
#> 75   placebo         0     34    40
#> 76   placebo         0      0    41
#> 77   placebo         0      0     3
#> 78   placebo         0      3    43
#> 79   placebo         0      0     6
#> 80   placebo         0      6    43
#> 81   placebo         0      0     3
#> 82   placebo         0      3     6
#> 83   placebo         0      6     9
#> 84   placebo         0      9    44
#> 85   placebo         0      0     9
#> 86   placebo         0      9    11
#> 87   placebo         0     11    20
#> 88   placebo         0     20    26
#> 89   placebo         0     26    30
#> 90   placebo         2     30    45
#> 91   placebo         0      0    18
#> 92   placebo         0     18    48
#> 93   placebo         0      0    49
#> 94   placebo         0      0    35
#> 95   placebo         0     35    51
#> 96   placebo         0      0    17
#> 97   placebo         0     17    53
#> 98   placebo         0      0     3
#> 99   placebo         0      3    15
#> 100  placebo         0     15    46
#> 101  placebo         0     46    51
#> 102  placebo         0     51    53
#> 103  placebo         0      0    59
#> 104  placebo         0      0     2
#> 105  placebo         0      2    15
#> 106  placebo         0     15    24
#> 107  placebo         0     24    30
#> 108  placebo         0     30    34
#> 109  placebo         0     34    39
#> 110  placebo         0     39    43
#> 111  placebo         0     43    49
#> 112  placebo         0     49    52
#> 113  placebo         0     52    61
#> 114  placebo         0      0     5
#> 115  placebo         0      5    14
#> 116  placebo         0     14    19
#> 117  placebo         0     19    27
#> 118  placebo         0     27    41
#> 119  placebo         0     41    64
#> 120  placebo         0      0     2
#> 121  placebo         0      2     8
#> 122  placebo         0      8    12
#> 123  placebo         0     12    13
#> 124  placebo         0     13    17
#> 125  placebo         0     17    21
#> 126  placebo         0     21    33
#> 127  placebo         0     33    49
#> 128  placebo         0     49    64
#> 214 thiotepa         0      0     1
#> 215 thiotepa         2      0     1
#> 216 thiotepa         0      0     5
#> 217 thiotepa         0      0     9
#> 218 thiotepa         2      0    10
#> 219 thiotepa         0      0    13
#> 220 thiotepa         0      0     3
#> 221 thiotepa         0      3    14
#> 222 thiotepa         0      0     1
#> 223 thiotepa         0      1     3
#> 224 thiotepa         0      3     5
#> 225 thiotepa         0      5     7
#> 226 thiotepa         0      7    10
#> 227 thiotepa         2     10    17
#> 228 thiotepa         2      0    18
#> 229 thiotepa         0      0    17
#> 230 thiotepa         2     17    18
#> 231 thiotepa         0      0     2
#> 232 thiotepa         1      2    19
#> 233 thiotepa         0      0    17
#> 234 thiotepa         0     17    19
#> 235 thiotepa         2     19    21
#> 236 thiotepa         0      0    22
#> 237 thiotepa         0      0    25
#> 238 thiotepa         0      0    25
#> 239 thiotepa         0      0    25
#> 240 thiotepa         0      0     6
#> 241 thiotepa         0      6    12
#> 242 thiotepa         0     12    13
#> 243 thiotepa         0     13    26
#> 244 thiotepa         0      0     6
#> 245 thiotepa         0      6    27
#> 246 thiotepa         0      0     2
#> 247 thiotepa         0      2    29
#> 248 thiotepa         0      0    26
#> 249 thiotepa         0     26    35
#> 250 thiotepa         0     35    36
#> 251 thiotepa         0      0    38
#> 252 thiotepa         0      0    22
#> 253 thiotepa         0     22    23
#> 254 thiotepa         0     23    27
#> 255 thiotepa         0     27    32
#> 256 thiotepa         0     32    39
#> 257 thiotepa         0      0     4
#> 258 thiotepa         0      4    16
#> 259 thiotepa         0     16    23
#> 260 thiotepa         0     23    27
#> 261 thiotepa         0     27    33
#> 262 thiotepa         0     33    36
#> 263 thiotepa         0     36    37
#> 264 thiotepa         2     37    39
#> 265 thiotepa         0      0    24
#> 266 thiotepa         0     24    26
#> 267 thiotepa         0     26    29
#> 268 thiotepa         0     29    40
#> 269 thiotepa         0      0    41
#> 270 thiotepa         2      0    41
#> 271 thiotepa         0      0     1
#> 272 thiotepa         0      1    27
#> 273 thiotepa         0     27    43
#> 274 thiotepa         0      0    44
#> 275 thiotepa         0      0     2
#> 276 thiotepa         0      2    20
#> 277 thiotepa         0     20    23
#> 278 thiotepa         0     23    27
#> 279 thiotepa         0     27    38
#> 280 thiotepa         0     38    44
#> 281 thiotepa         0      0    45
#> 282 thiotepa         0      0     2
#> 283 thiotepa         0      2    46
#> 284 thiotepa         2      0    46
#> 285 thiotepa         0      0    49
#> 286 thiotepa         0      0    50
#> 287 thiotepa         0      0     4
#> 288 thiotepa         0      4    24
#> 289 thiotepa         0     24    47
#> 290 thiotepa         0     47    50
#> 291 thiotepa         0      0    54
#> 292 thiotepa         0      0    38
#> 293 thiotepa         0     38    54
#> 294 thiotepa         2      0    59
#> 
#> $dim
#> [1] "threedim"

# GEE fit
fit_bladder_3d <- pseudo.geefit(pseudodata = pseudo_bladder_3d,
                                covar_names = c("Z"))
fit_bladder_3d
#> $xi
#>                                    
#> Zplacebo:esttypemu     4.427632e-01
#> Zthiotepa:esttypemu    1.579732e-02
#> Zplacebo:esttypecif1  -4.178356e+00
#> Zthiotepa:esttypecif1 -3.476012e+00
#> Zplacebo:esttypecif2   1.327101e+18
#> Zthiotepa:esttypecif2  1.328818e+18
#> 
#> $sigma
#>                       Zplacebo:esttypemu Zthiotepa:esttypemu
#> Zplacebo:esttypemu          2.637790e-02        0.000000e+00
#> Zthiotepa:esttypemu         0.000000e+00        5.123865e-02
#> Zplacebo:esttypecif1        1.336165e-02        0.000000e+00
#> Zthiotepa:esttypecif1       0.000000e+00       -3.438434e-03
#> Zplacebo:esttypecif2        9.080882e+11        0.000000e+00
#> Zthiotepa:esttypecif2       0.000000e+00       -4.643814e+11
#>                       Zplacebo:esttypecif1 Zthiotepa:esttypecif1
#> Zplacebo:esttypemu            1.336165e-02          0.000000e+00
#> Zthiotepa:esttypemu           0.000000e+00         -3.438434e-03
#> Zplacebo:esttypecif1          1.085574e+00          0.000000e+00
#> Zthiotepa:esttypecif1         0.000000e+00          9.481261e-01
#> Zplacebo:esttypecif2          7.377809e+13          0.000000e+00
#> Zthiotepa:esttypecif2         0.000000e+00          1.280502e+14
#>                       Zplacebo:esttypecif2 Zthiotepa:esttypecif2
#> Zplacebo:esttypemu            9.080882e+11          0.000000e+00
#> Zthiotepa:esttypemu           0.000000e+00         -4.643814e+11
#> Zplacebo:esttypecif1          7.377809e+13          0.000000e+00
#> Zthiotepa:esttypecif1         0.000000e+00          1.280502e+14
#> Zplacebo:esttypecif2          5.871156e+31          0.000000e+00
#> Zthiotepa:esttypecif2         0.000000e+00          7.436495e+31

# Treatment differences
xi_diff_3d <- as.matrix(c(fit_bladder_3d$xi[2] - fit_bladder_3d$xi[1],
                          fit_bladder_3d$xi[4] - fit_bladder_3d$xi[3],
                          fit_bladder_3d$xi[6] - fit_bladder_3d$xi[5]), ncol = 1)

mslabels <- c("treat, mu", "treat, cif1", "treat, cif2")
rownames(xi_diff_3d) <- mslabels
colnames(xi_diff_3d) <- ""
xi_diff_3d
#>                          
#> treat, mu   -4.269659e-01
#> treat, cif1  7.023444e-01
#> treat, cif2  1.717020e+15


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
#> treat, mu   7.761655e-02 9.080882e+11 0.000000e+00
#> treat, cif1 9.080882e+11 2.033700e+00 2.018283e+14
#> treat, cif2 0.000000e+00 2.018283e+14 1.330765e+32
```

``` r
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
#> treat, mu   -4.269659e-01
#> treat, cif1  7.023444e-01
#> treat, cif2  1.717020e+15

sigma_diff_1d
#>            treat, mu
#> treat, mu 0.07761655
sigma_diff_2d
#>              treat, mu treat, surv
#> treat, mu   0.07761655  0.00481233
#> treat, surv 0.00481233  0.22785186
sigma_diff_3d
#>                treat, mu  treat, cif1  treat, cif2
#> treat, mu   7.761655e-02 9.080882e+11 0.000000e+00
#> treat, cif1 9.080882e+11 2.033700e+00 2.018283e+14
#> treat, cif2 0.000000e+00 2.018283e+14 1.330765e+32
```

``` r
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
```

# Citation

To cite the `recurrentpseudo` package please use the following
references,

> Julie K. Furberg, Per K. Andersen, Sofie Korn, Morten Overgaard,
> Henrik Ravn: Bivariate pseudo-observations for recurrent event
> analysis with terminal events (Lifetime Data Analysis, 2021)
