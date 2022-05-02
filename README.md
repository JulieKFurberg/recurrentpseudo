
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

devtools::install_github("JulieKFurberg/recurrentpseudo", force = TRUE)
#> Downloading GitHub repo JulieKFurberg/recurrentpseudo@HEAD
#> cli      (3.2.0 -> 3.3.0) [CRAN]
#> magrittr (2.0.2 -> 2.0.3) [CRAN]
#> Installing 2 packages: cli, magrittr
#> Warning in download.file(url, destfile, method, mode = "wb", ...): cannot open
#> URL 'https://cloud.r-project.org/bin/windows/contrib/4.1/cli_3.3.0.zip': HTTP
#> status was '403 Forbidden'
#> Error in download.file(url, destfile, method, mode = "wb", ...) : 
#>   kan ikke åbne adresse 'https://cloud.r-project.org/bin/windows/contrib/4.1/cli_3.3.0.zip'
#> Warning in download.packages(pkgs, destdir = tmpd, available = available, :
#> download of package 'cli' failed
#> Warning in download.file(url, destfile, method, mode = "wb", ...): cannot open
#> URL 'https://cloud.r-project.org/bin/windows/contrib/4.1/magrittr_2.0.3.zip':
#> HTTP status was '403 Forbidden'
#> Error in download.file(url, destfile, method, mode = "wb", ...) : 
#>   kan ikke åbne adresse 'https://cloud.r-project.org/bin/windows/contrib/4.1/magrittr_2.0.3.zip'
#> Warning in download.packages(pkgs, destdir = tmpd, available = available, :
#> download of package 'magrittr' failed
#> * checking for file 'C:\Users\jukf\AppData\Local\Temp\RtmpKucQWS\remotes2db411962f0c\JulieKFurberg-recurrentpseudo-9b4b234/DESCRIPTION' ... OK
#> * preparing 'recurrentpseudo':
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building 'recurrentpseudo_0.0.0.9000.tar.gz'
#> 

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
#> Ztime1     0.03597979
#> Ztime2     0.49493265
#> Ztime3     0.67579159
#> Zthiotepa -0.40340296
#> 
#> $sigma
#>                Ztime1      Ztime2      Ztime3   Zthiotepa
#> Ztime1     0.03232763  0.02721307  0.02476484 -0.03061935
#> Ztime2     0.02721307  0.02713876  0.02606670 -0.02795419
#> Ztime3     0.02476484  0.02606670  0.02738219 -0.02451885
#> Zthiotepa -0.03061935 -0.02795419 -0.02451885  0.07947750

# Treatment differences
xi_diff_1d <- as.matrix(c(fit_bladder_1d$xi[2] - fit_bladder_1d$xi[1]), ncol = 1)

mslabels <- c("treat, mu")
rownames(xi_diff_1d) <- mslabels
colnames(xi_diff_1d) <- ""
xi_diff_1d
#>                    
#> treat, mu 0.4589529

# Variance matrix for differences
sigma_diff_1d <- matrix(c(fit_bladder_1d$sigma[1,1] + fit_bladder_1d$sigma[2,2]),
                     ncol = 1, nrow = 1,
                     byrow = T)

rownames(sigma_diff_1d) <- colnames(sigma_diff_1d) <- mslabels
sigma_diff_1d
#>            treat, mu
#> treat, mu 0.05946639
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
#> esttypemu              0.03598265
#> esttypemu:Ztime2       0.45895058
#> esttypemu:Ztime3       0.63980681
#> esttypemu:Zthiotepa   -0.40340116
#> esttypesurv           -1.83730017
#> esttypesurv:Ztime2     0.37942009
#> esttypesurv:Ztime3     0.59405619
#> esttypesurv:Zthiotepa  0.04394278
#> 
#> $sigma
#>                          esttypemu esttypemu:Ztime2 esttypemu:Ztime3
#> esttypemu              0.032327488     -0.005114483    -0.0075626527
#> esttypemu:Ztime2      -0.005114483      0.005040221     0.0064163785
#> esttypemu:Ztime3      -0.007562653      0.006416378     0.0101801022
#> esttypemu:Zthiotepa   -0.030619331      0.002665131     0.0061004546
#> esttypesurv           -0.006346523      0.005666605     0.0006934612
#> esttypesurv:Ztime2    -0.003881582     -0.001020777     0.0005905984
#> esttypesurv:Ztime3    -0.006107123     -0.002192999     0.0019721862
#> esttypesurv:Zthiotepa  0.002784318     -0.001887154     0.0134495442
#>                       esttypemu:Zthiotepa  esttypesurv esttypesurv:Ztime2
#> esttypemu                   -0.0306193315 -0.006346523        0.005666605
#> esttypemu:Ztime2             0.0026651305 -0.003881582       -0.001020777
#> esttypemu:Ztime3             0.0061004546 -0.006107123       -0.002192999
#> esttypemu:Zthiotepa          0.0794773590  0.002784318       -0.001887154
#> esttypesurv                  0.0080748083  0.117768036       -0.016430737
#> esttypesurv:Ztime2          -0.0008069547 -0.016430737        0.034184232
#> esttypesurv:Ztime3           0.0013544191 -0.030116862        0.032687838
#> esttypesurv:Zthiotepa        0.0050146219 -0.089367723       -0.021779871
#>                       esttypesurv:Ztime3 esttypesurv:Zthiotepa
#> esttypemu                   0.0006934612          0.0080748083
#> esttypemu:Ztime2            0.0005905984         -0.0008069547
#> esttypemu:Ztime3            0.0019721862          0.0013544191
#> esttypemu:Zthiotepa         0.0134495442          0.0050146219
#> esttypesurv                -0.0301168618         -0.0893677225
#> esttypesurv:Ztime2          0.0326878377         -0.0217798708
#> esttypesurv:Ztime3          0.0530214585         -0.0161918304
#> esttypesurv:Zthiotepa      -0.0161918304          0.2289923447

# Treatment differences
xi_diff_2d <- as.matrix(c(fit_bladder_2d$xi[2] - fit_bladder_2d$xi[1],
                          fit_bladder_2d$xi[4] - fit_bladder_2d$xi[3]), ncol = 1)

mslabels <- c("treat, mu", "treat, surv")
rownames(xi_diff_2d) <- mslabels
colnames(xi_diff_2d) <- ""
xi_diff_2d
#>                       
#> treat, mu    0.4229679
#> treat, surv -1.0432080


# Variance matrix for differences
sigma_diff_2d <- matrix(c(fit_bladder_2d$sigma[1,1] + fit_bladder_2d$sigma[2,2],
                          fit_bladder_2d$sigma[1,3] + fit_bladder_2d$sigma[2,4],
                          fit_bladder_2d$sigma[1,3] + fit_bladder_2d$sigma[2,4],
                          fit_bladder_2d$sigma[3,3] + fit_bladder_2d$sigma[4,4]),
                          ncol = 2, nrow = 2,
                          byrow = T)

rownames(sigma_diff_2d) <- colnames(sigma_diff_2d) <- mslabels
sigma_diff_2d
#>                treat, mu  treat, surv
#> treat, mu    0.037367709 -0.004897522
#> treat, surv -0.004897522  0.089657461
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

``` r
###----------------------- Compare - should match for some elements ---------------------------###

xi_diff_1d
#>                    
#> treat, mu 0.4589529
xi_diff_2d
#>                       
#> treat, mu    0.4229679
#> treat, surv -1.0432080
xi_diff_3d
#>                      
#> treat, mu    0.422968
#> treat, cif1 -1.043208
#> treat, cif2  4.883285

sigma_diff_1d
#>            treat, mu
#> treat, mu 0.05946639
sigma_diff_2d
#>                treat, mu  treat, surv
#> treat, mu    0.037367709 -0.004897522
#> treat, surv -0.004897522  0.089657461
sigma_diff_3d
#>                treat, mu  treat, cif1  treat, cif2
#> treat, mu    0.037367709  0.004360506 -0.025505284
#> treat, cif1  0.004360506  0.089657474 -0.007533026
#> treat, cif2 -0.025505284 -0.007533026  0.909790069
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

fit1$xi
#>                        
#> Ztime1      -0.08441050
#> Ztime2       0.33194951
#> Ztime3       0.57310418
#> Z1_thiotepa -0.42090759
#> Z2_         -0.03389195
#> Z3_B         0.34541987
#> Z3_C         0.17941848
fit1$sigma
#>                  Ztime1      Ztime2      Ztime3  Z1_thiotepa          Z2_
#> Ztime1       0.08476609  0.08130155  0.08268365 -0.018687914 -0.011738765
#> Ztime2       0.08130155  0.08368418  0.08588052 -0.016981267 -0.011817225
#> Ztime3       0.08268365  0.08588052  0.09301181 -0.011901788 -0.014028496
#> Z1_thiotepa -0.01868791 -0.01698127 -0.01190179  0.081627362 -0.003135103
#> Z2_         -0.01173877 -0.01181722 -0.01402850 -0.003135103  0.003901765
#> Z3_B        -0.03834250 -0.03968841 -0.04046884 -0.009270712  0.004114268
#> Z3_C        -0.03683084 -0.04023433 -0.03718317  0.007391325  0.002047425
#>                     Z3_B         Z3_C
#> Ztime1      -0.038342503 -0.036830841
#> Ztime2      -0.039688406 -0.040234331
#> Ztime3      -0.040468841 -0.037183168
#> Z1_thiotepa -0.009270712  0.007391325
#> Z2_          0.004114268  0.002047425
#> Z3_B         0.051268216  0.032323356
#> Z3_C         0.032323356  0.066226527

##
```

# Citation

To cite the `recurrentpseudo` package please use the following
references,

> Julie K. Furberg, Per K. Andersen, Sofie Korn, Morten Overgaard,
> Henrik Ravn: Bivariate pseudo-observations for recurrent event
> analysis with terminal events (Lifetime Data Analysis, 2021)
