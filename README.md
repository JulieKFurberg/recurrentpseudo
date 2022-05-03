
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

    #> Indlæser krævet pakke: devtools
    #> Indlæser krævet pakke: usethis
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
    #> * checking for file 'C:\Users\jukf\AppData\Local\Temp\Rtmp6TEeqY\remotes53b82e9f4537\JulieKFurberg-recurrentpseudo-7b7e30f/DESCRIPTION' ... OK
    #> * preparing 'recurrentpseudo':
    #> * checking DESCRIPTION meta-information ... OK
    #> * checking for LF line-endings in source and make files and shell scripts
    #> * checking for empty or unneeded directories
    #> * building 'recurrentpseudo_0.0.0.9000.tar.gz'
    #> 
    #> Indlæser krævet pakke: recurrentpseudo
    #> Warning: replacing previous import 'dplyr::filter' by 'stats::filter' when
    #> loading 'recurrentpseudo'
    #> Warning: replacing previous import 'dplyr::lag' by 'stats::lag' when loading
    #> 'recurrentpseudo'

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
xi_diff_1d <- as.matrix(c(fit_bladder_1d$xi[4]), ncol = 1)

mslabels <- c("treat, mu")
rownames(xi_diff_1d) <- mslabels
colnames(xi_diff_1d) <- ""
xi_diff_1d
#>                    
#> treat, mu -0.403403

# Variance matrix for differences
sigma_diff_1d <- matrix(c(fit_bladder_1d$sigma[4,4]),
                          ncol = 1, nrow = 1,
                          byrow = T)

rownames(sigma_diff_1d) <- colnames(sigma_diff_1d) <- mslabels
sigma_diff_1d
#>           treat, mu
#> treat, mu 0.0794775
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
xi_diff_2d <- as.matrix(c(fit_bladder_2d$xi[4] - fit_bladder_2d$xi[1],
                          fit_bladder_2d$xi[8] - fit_bladder_2d$xi[6]), ncol = 1)

mslabels <- c("treat, mu", "treat, surv")
rownames(xi_diff_2d) <- mslabels
colnames(xi_diff_2d) <- ""
xi_diff_2d
#>                       
#> treat, mu   -0.4393838
#> treat, surv -0.3354773


# Variance matrix for differences
sigma_diff_2d <- matrix(c(fit_bladder_2d$sigma[4,4] + fit_bladder_2d$sigma[1,1],
                          fit_bladder_2d$sigma[1,4] + fit_bladder_2d$sigma[1,5],
                          fit_bladder_2d$sigma[5,8] + fit_bladder_2d$sigma[5,4],
                          fit_bladder_2d$sigma[8,8] + fit_bladder_2d$sigma[5,5]),
                          ncol = 2, nrow = 2,
                          byrow = T)

rownames(sigma_diff_2d) <- colnames(sigma_diff_2d) <- mslabels
sigma_diff_2d
#>               treat, mu treat, surv
#> treat, mu    0.11180485 -0.03696585
#> treat, surv -0.08129291  0.34676038
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
xi_diff_3d <- as.matrix(c(fit_bladder_3d$xi[4] - fit_bladder_3d$xi[1],
                          fit_bladder_3d$xi[8] - fit_bladder_3d$xi[5],
                          fit_bladder_3d$xi[12] - fit_bladder_3d$xi[9]), ncol = 1)

mslabels <- c("treat, mu", "treat, cif1", "treat, cif2")
rownames(xi_diff_3d) <- mslabels
colnames(xi_diff_3d) <- ""
xi_diff_3d
#>                          
#> treat, mu   -4.393840e-01
#> treat, cif1  4.986566e+00
#> treat, cif2 -7.065077e+17


# Variance matrix for differences
sigma_diff_3d <- matrix(c(fit_bladder_3d$sigma[1,1] + fit_bladder_3d$sigma[4,4],
                          fit_bladder_3d$sigma[1,9] + fit_bladder_3d$sigma[1,5],
                          fit_bladder_3d$sigma[1,8] + fit_bladder_3d$sigma[1,12],

                          fit_bladder_3d$sigma[1,9] + fit_bladder_3d$sigma[1,5],
                          fit_bladder_3d$sigma[5,5] + fit_bladder_3d$sigma[8,8],
                          fit_bladder_3d$sigma[9,5] + fit_bladder_3d$sigma[8,12],

                          fit_bladder_3d$sigma[1,8] + fit_bladder_3d$sigma[1,12],
                          fit_bladder_3d$sigma[9,5] + fit_bladder_3d$sigma[8,12],
                          fit_bladder_3d$sigma[9,9] + fit_bladder_3d$sigma[12,12]

                          ),
                        ncol = 3, nrow = 3,
                        byrow = T)

rownames(sigma_diff_3d) <- colnames(sigma_diff_3d) <- mslabels
sigma_diff_3d
#>                 treat, mu   treat, cif1   treat, cif2
#> treat, mu    1.118049e-01  4.073032e+13 -9.177911e+13
#> treat, cif1  4.073032e+13  2.664917e+00 -1.101396e+14
#> treat, cif2 -9.177911e+13 -1.101396e+14  1.683123e+32
```

``` r
###----------------------- Compare - should match for mu elements ---------------------------###
xi_diff_1d
#>                    
#> treat, mu -0.403403
xi_diff_2d
#>                       
#> treat, mu   -0.4393838
#> treat, surv -0.3354773
xi_diff_3d
#>                          
#> treat, mu   -4.393840e-01
#> treat, cif1  4.986566e+00
#> treat, cif2 -7.065077e+17

sigma_diff_1d
#>           treat, mu
#> treat, mu 0.0794775
sigma_diff_2d
#>               treat, mu treat, surv
#> treat, mu    0.11180485 -0.03696585
#> treat, surv -0.08129291  0.34676038
sigma_diff_3d
#>                 treat, mu   treat, cif1   treat, cif2
#> treat, mu    1.118049e-01  4.073032e+13 -9.177911e+13
#> treat, cif1  4.073032e+13  2.664917e+00 -1.101396e+14
#> treat, cif2 -9.177911e+13 -1.101396e+14  1.683123e+32
```

``` r
# if more than a binary treat

## One-dim
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
#> Ztime1       0.09275828
#> Ztime2       0.55142207
#> Ztime3       0.72662986
#> Z1_thiotepa -0.40710686
#> Z2_          0.02630684
#> Z3_B        -0.22585328
#> Z3_C        -0.02844750
fit1$sigma
#>                  Ztime1      Ztime2      Ztime3   Z1_thiotepa           Z2_
#> Ztime1       0.11749038  0.11263636  0.10437049 -0.0354861101 -0.0168131307
#> Ztime2       0.11263636  0.11381970  0.10598420 -0.0319142043 -0.0166992760
#> Ztime3       0.10437049  0.10598420  0.10173475 -0.0284372835 -0.0161431538
#> Z1_thiotepa -0.03548611 -0.03191420 -0.02843728  0.0759590623  0.0007843528
#> Z2_         -0.01681313 -0.01669928 -0.01614315  0.0007843528  0.0048468887
#> Z3_B        -0.03854587 -0.04086747 -0.03451887  0.0005540265  0.0008798475
#> Z3_C        -0.04202068 -0.04458990 -0.03974018  0.0090510884  0.0007701969
#>                      Z3_B          Z3_C
#> Ztime1      -0.0385458745 -0.0420206754
#> Ztime2      -0.0408674657 -0.0445899035
#> Ztime3      -0.0345188666 -0.0397401824
#> Z1_thiotepa  0.0005540265  0.0090510884
#> Z2_          0.0008798475  0.0007701969
#> Z3_B         0.0539888372  0.0431577356
#> Z3_C         0.0431577356  0.0723291539

## Two-dim
# Treatment, binary variable:
pseudo_bladder_2d$outdata_long$Z1_ <- as.factor(pseudo_bladder_2d$outdata_long$Z)

# A continuous variable
pseudo_bladder_2d$outdata_long$Z2_ <- rnorm(nrow(pseudo_bladder_2d$outdata_long), mean = 3, sd = 1)

# A categorical variable
pseudo_bladder_2d$outdata_long$Z3_ <- sample(x = c("A", "B", "C"), 
                                 size = nrow(pseudo_bladder_2d$outdata_long), 
                                 replace = TRUE, 
                                 prob = c(1/4, 1/2, 1/4))

fit2 <- pseudo.geefit(pseudodata = pseudo_bladder_2d, 
                      covar_names = c("Z1_", "Z2_", "Z3_"))

fit2$xi
#>                                    
#> esttypemu                0.15360980
#> esttypemu:Ztime2         0.51949570
#> esttypemu:Ztime3         0.73208507
#> esttypemu:Z1_thiotepa   -0.33075453
#> esttypemu:Z2_           -0.11260889
#> esttypemu:Z3_B           0.24117278
#> esttypemu:Z3_C          -0.08352569
#> esttypesurv             -2.52853184
#> esttypesurv:Ztime2       0.35854004
#> esttypesurv:Ztime3       0.65991876
#> esttypesurv:Z1_thiotepa  0.07776168
#> esttypesurv:Z2_          0.16273002
#> esttypesurv:Z3_B         0.25275490
#> esttypesurv:Z3_C         0.08724624
fit2$sigma
#>                             esttypemu esttypemu:Ztime2 esttypemu:Ztime3
#> esttypemu                0.0873756325    -4.097913e-03    -1.145899e-02
#> esttypemu:Ztime2        -0.0040979133     6.767276e-03     6.800786e-03
#> esttypemu:Ztime3        -0.0114589907     6.800786e-03     1.105988e-02
#> esttypemu:Z1_thiotepa   -0.0197027741     4.826740e-03     6.287105e-03
#> esttypemu:Z2_           -0.0155369811    -1.677928e-03     3.761912e-05
#> esttypemu:Z3_B          -0.0280132284     1.633483e-03     3.935455e-03
#> esttypemu:Z3_C          -0.0300203172    -1.662670e-03    -2.552044e-03
#> esttypesurv             -0.0234326965     5.694566e-05    -1.511837e-03
#> esttypesurv:Ztime2      -0.0040883673     6.209351e-04     2.042973e-03
#> esttypesurv:Ztime3      -0.0031989909    -1.038288e-03     1.277269e-03
#> esttypesurv:Z1_thiotepa  0.0073556048    -1.428732e-03     1.074580e-02
#> esttypesurv:Z2_         -0.0001059521    -1.382550e-03     1.166261e-03
#> esttypesurv:Z3_B         0.0138237913     8.881218e-03    -2.182361e-03
#> esttypesurv:Z3_C        -0.0073179672     2.479895e-02     1.335146e-02
#>                         esttypemu:Z1_thiotepa esttypemu:Z2_ esttypemu:Z3_B
#> esttypemu                       -0.0197027741 -1.553698e-02  -0.0280132284
#> esttypemu:Ztime2                 0.0048267398 -1.677928e-03   0.0016334825
#> esttypemu:Ztime3                 0.0062871046  3.761912e-05   0.0039354552
#> esttypemu:Z1_thiotepa            0.0701710910 -1.537067e-03  -0.0061457668
#> esttypemu:Z2_                   -0.0015370669  7.861276e-03  -0.0038659348
#> esttypemu:Z3_B                  -0.0061457668 -3.865935e-03   0.0504013342
#> esttypemu:Z3_C                  -0.0179183289  7.832748e-04   0.0404991191
#> esttypesurv                      0.0072186559  8.019342e-03  -0.0028089282
#> esttypesurv:Ztime2              -0.0034872293 -5.349143e-04   0.0044269741
#> esttypesurv:Ztime3              -0.0005430804 -1.474705e-03   0.0052858472
#> esttypesurv:Z1_thiotepa          0.0051697726  5.585169e-04  -0.0061959969
#> esttypesurv:Z2_                  0.0060639486 -1.313812e-03   0.0028008195
#> esttypesurv:Z3_B                -0.0178520152 -4.020433e-03  -0.0001044836
#> esttypesurv:Z3_C                -0.0282922914 -1.436075e-03   0.0056408361
#>                         esttypemu:Z3_C   esttypesurv esttypesurv:Ztime2
#> esttypemu                -0.0300203172 -0.0234326965       5.694566e-05
#> esttypemu:Ztime2         -0.0016626703 -0.0040883673       6.209351e-04
#> esttypemu:Ztime3         -0.0025520440 -0.0031989909      -1.038288e-03
#> esttypemu:Z1_thiotepa    -0.0179183289  0.0073556048      -1.428732e-03
#> esttypemu:Z2_             0.0007832748 -0.0001059521      -1.382550e-03
#> esttypemu:Z3_B            0.0404991191  0.0138237913       8.881218e-03
#> esttypemu:Z3_C            0.0948566978 -0.0073179672       2.479895e-02
#> esttypesurv              -0.0036559621  0.4212753675      -4.362838e-02
#> esttypesurv:Ztime2        0.0018574092 -0.0436283795       4.635154e-02
#> esttypesurv:Ztime3        0.0006755231 -0.0638528023       3.929298e-02
#> esttypesurv:Z1_thiotepa  -0.0098923184 -0.0789748613      -1.636594e-02
#> esttypesurv:Z2_          -0.0018251493 -0.0493988951      -4.717622e-03
#> esttypesurv:Z3_B          0.0123767030 -0.1801879644       4.600128e-02
#> esttypesurv:Z3_C          0.0230527728 -0.1143601507       3.961127e-02
#>                         esttypesurv:Ztime3 esttypesurv:Z1_thiotepa
#> esttypemu                     -0.001511837            0.0072186559
#> esttypemu:Ztime2               0.002042973           -0.0034872293
#> esttypemu:Ztime3               0.001277269           -0.0005430804
#> esttypemu:Z1_thiotepa          0.010745797            0.0051697726
#> esttypemu:Z2_                  0.001166261            0.0060639486
#> esttypemu:Z3_B                -0.002182361           -0.0178520152
#> esttypemu:Z3_C                 0.013351458           -0.0282922914
#> esttypesurv                   -0.063852802           -0.0789748613
#> esttypesurv:Ztime2             0.039292981           -0.0163659431
#> esttypesurv:Ztime3             0.063889400           -0.0096251028
#> esttypesurv:Z1_thiotepa       -0.009625103            0.2165398062
#> esttypesurv:Z2_                0.001095591           -0.0084518698
#> esttypesurv:Z3_B               0.034818810            0.0341522410
#> esttypesurv:Z3_C               0.005255703           -0.0259348789
#>                         esttypesurv:Z2_ esttypesurv:Z3_B esttypesurv:Z3_C
#> esttypemu                  0.0080193422    -0.0028089282    -0.0036559621
#> esttypemu:Ztime2          -0.0005349143     0.0044269741     0.0018574092
#> esttypemu:Ztime3          -0.0014747050     0.0052858472     0.0006755231
#> esttypemu:Z1_thiotepa      0.0005585169    -0.0061959969    -0.0098923184
#> esttypemu:Z2_             -0.0013138118     0.0028008195    -0.0018251493
#> esttypemu:Z3_B            -0.0040204334    -0.0001044836     0.0123767030
#> esttypemu:Z3_C            -0.0014360753     0.0056408361     0.0230527728
#> esttypesurv               -0.0493988951    -0.1801879644    -0.1143601507
#> esttypesurv:Ztime2        -0.0047176216     0.0460012780     0.0396112658
#> esttypesurv:Ztime3         0.0010955911     0.0348188100     0.0052557029
#> esttypesurv:Z1_thiotepa   -0.0084518698     0.0341522410    -0.0259348789
#> esttypesurv:Z2_            0.0164489953     0.0033340598     0.0005736616
#> esttypesurv:Z3_B           0.0033340598     0.1699882495     0.1191955689
#> esttypesurv:Z3_C           0.0005736616     0.1191955689     0.2075113314

## Three-dim
# Treatment, binary variable:
pseudo_bladder_3d$outdata_long$Z1_ <- as.factor(pseudo_bladder_3d$outdata_long$Z)

# A continuous variable
pseudo_bladder_3d$outdata_long$Z2_ <- rnorm(nrow(pseudo_bladder_3d$outdata_long), mean = 3, sd = 1)

# A categorical variable
pseudo_bladder_3d$outdata_long$Z3_ <- sample(x = c("A", "B", "C"), 
                                 size = nrow(pseudo_bladder_3d$outdata_long), 
                                 replace = TRUE, 
                                 prob = c(1/4, 1/2, 1/4))

fit3 <- pseudo.geefit(pseudodata = pseudo_bladder_3d, 
                      covar_names = c("Z1_", "Z2_", "Z3_"))

fit3$xi
#>                                      
#> esttypemu                1.616224e-01
#> esttypemu:Ztime2         4.601547e-01
#> esttypemu:Ztime3         6.269935e-01
#> esttypemu:Z1_thiotepa   -3.893090e-01
#> esttypemu:Z2_           -8.458905e-02
#> esttypemu:Z3_B           2.059225e-01
#> esttypemu:Z3_C           9.169688e-02
#> esttypecif1             -8.622534e+00
#> esttypecif1:Ztime2       4.128854e-01
#> esttypecif1:Ztime3       2.350243e+00
#> esttypecif1:Z1_thiotepa  1.894680e+00
#> esttypecif1:Z2_          8.992164e-02
#> esttypecif1:Z3_B         1.136376e-01
#> esttypecif1:Z3_C         2.226589e+00
#> esttypecif2              6.994085e+17
#> esttypecif2:Ztime2       7.181823e+17
#> esttypecif2:Ztime3       1.139299e+18
#> esttypecif2:Z1_thiotepa  2.170417e+15
#> esttypecif2:Z2_          1.882221e+15
#> esttypecif2:Z3_B         3.241383e+15
#> esttypecif2:Z3_C         4.724683e+15
fit3$sigma
#>                             esttypemu esttypemu:Ztime2 esttypemu:Ztime3
#> esttypemu                1.395621e-01    -1.905509e-03     1.316978e-03
#> esttypemu:Ztime2        -1.905509e-03     5.571554e-03     6.207043e-03
#> esttypemu:Ztime3         1.316978e-03     6.207043e-03     1.088515e-02
#> esttypemu:Z1_thiotepa   -3.749646e-02     3.021630e-03     6.431688e-03
#> esttypemu:Z2_           -2.683579e-02    -6.900199e-04    -2.081318e-03
#> esttypemu:Z3_B          -3.323955e-02    -1.457790e-03    -1.870850e-03
#> esttypemu:Z3_C          -3.684995e-02     2.483832e-03     6.085296e-04
#> esttypecif1             -1.136451e-02     2.456295e-02     1.222007e-02
#> esttypecif1:Ztime2      -8.593113e-04    -3.706157e-05    -2.318514e-03
#> esttypecif1:Ztime3      -9.610749e-03     3.916399e-03     3.562339e-03
#> esttypecif1:Z1_thiotepa -9.832102e-02    -1.112354e-03     2.164362e-02
#> esttypecif1:Z2_          1.300499e-02    -7.963401e-03    -5.754039e-03
#> esttypecif1:Z3_B        -1.340860e-02    -1.843854e-03     4.927305e-03
#> esttypecif1:Z3_C         4.846277e-05    -5.301887e-03     2.188602e-03
#> esttypecif2              8.948022e+14    -6.631206e+13    -4.833929e+13
#> esttypecif2:Ztime2       8.964362e+12    -6.467753e+12    -4.711605e+12
#> esttypecif2:Ztime3      -1.434208e+14     8.532344e+12     8.027534e+12
#> esttypecif2:Z1_thiotepa  1.169071e+14    -3.606189e+13    -3.482142e+13
#> esttypecif2:Z2_         -2.845186e+14     2.221747e+13     1.672654e+13
#> esttypecif2:Z3_B        -1.537079e+14     2.595247e+13     2.183799e+13
#> esttypecif2:Z3_C         1.692109e+14    -2.002645e+13    -1.651401e+13
#>                         esttypemu:Z1_thiotepa esttypemu:Z2_ esttypemu:Z3_B
#> esttypemu                       -3.749646e-02 -2.683579e-02  -3.323955e-02
#> esttypemu:Ztime2                 3.021630e-03 -6.900199e-04  -1.457790e-03
#> esttypemu:Ztime3                 6.431688e-03 -2.081318e-03  -1.870850e-03
#> esttypemu:Z1_thiotepa            8.282341e-02 -1.602076e-03   1.618451e-02
#> esttypemu:Z2_                   -1.602076e-03  9.465502e-03  -2.721769e-03
#> esttypemu:Z3_B                   1.618451e-02 -2.721769e-03   5.395250e-02
#> esttypemu:Z3_C                   8.807139e-03 -1.339137e-03   3.894948e-02
#> esttypecif1                      2.339123e-02 -7.789282e-03   6.408404e-03
#> esttypecif1:Ztime2              -3.297778e-03  9.498716e-04   2.254518e-03
#> esttypecif1:Ztime3              -7.637118e-04 -6.274746e-05   2.417299e-03
#> esttypecif1:Z1_thiotepa          2.865047e-02  8.347469e-03   3.124535e-02
#> esttypecif1:Z2_                 -6.320600e-03  1.151068e-03  -6.123371e-03
#> esttypecif1:Z3_B                -2.571065e-02  6.668261e-03   2.468811e-02
#> esttypecif1:Z3_C                -1.776469e-02  3.833420e-03   5.771070e-03
#> esttypecif2                     -3.885809e+14 -2.266293e+14   2.386178e+14
#> esttypecif2:Ztime2               6.775220e+13 -1.859230e+13   6.144940e+13
#> esttypecif2:Ztime3               1.312398e+14 -3.236601e+12   1.460587e+14
#> esttypecif2:Z1_thiotepa         -3.287492e+13  5.519523e+13  -3.841683e+14
#> esttypecif2:Z2_                  5.253464e+13  6.962715e+13  -5.765688e+12
#> esttypecif2:Z3_B                 2.570689e+14  1.146119e+13  -9.058238e+13
#> esttypecif2:Z3_C                 9.136090e+13 -3.401165e+13  -1.151388e+14
#>                         esttypemu:Z3_C   esttypecif1 esttypecif1:Ztime2
#> esttypemu                -3.684995e-02 -1.136451e-02       2.456295e-02
#> esttypemu:Ztime2          2.483832e-03 -8.593113e-04      -3.706157e-05
#> esttypemu:Ztime3          6.085296e-04 -9.610749e-03       3.916399e-03
#> esttypemu:Z1_thiotepa     8.807139e-03 -9.832102e-02      -1.112354e-03
#> esttypemu:Z2_            -1.339137e-03  1.300499e-02      -7.963401e-03
#> esttypemu:Z3_B            3.894948e-02 -1.340860e-02      -1.843854e-03
#> esttypemu:Z3_C            6.744755e-02  4.846277e-05      -5.301887e-03
#> esttypecif1               2.289196e-02  3.419850e+00       2.362124e-01
#> esttypecif1:Ztime2       -2.709481e-03  2.362124e-01       3.838640e-01
#> esttypecif1:Ztime3        3.550010e-03 -6.932968e-02       2.300688e-01
#> esttypecif1:Z1_thiotepa   3.462944e-02 -1.521723e+00      -3.362002e-01
#> esttypecif1:Z2_          -1.116020e-02 -5.893573e-01      -1.077410e-01
#> esttypecif1:Z3_B          1.241832e-02  2.457764e-01       1.089058e-01
#> esttypecif1:Z3_C          2.474505e-03 -2.668574e-02       5.696371e-02
#> esttypecif2              -4.062448e+14 -6.097255e+14      -1.669373e+14
#> esttypecif2:Ztime2       -2.450361e+13  6.081850e+14      -1.072173e+14
#> esttypecif2:Ztime3        9.826765e+13  8.473057e+14       1.775056e+12
#> esttypecif2:Z1_thiotepa  -3.056478e+14 -1.759793e+15       2.422822e+14
#> esttypecif2:Z2_           1.572572e+14 -6.215270e+14       3.061528e+13
#> esttypecif2:Z3_B          1.191259e+14  2.477648e+15      -1.312119e+14
#> esttypecif2:Z3_C         -1.714943e+14  9.189270e+14       1.107845e+14
#>                         esttypecif1:Ztime3 esttypecif1:Z1_thiotepa
#> esttypemu                     1.222007e-02            2.339123e-02
#> esttypemu:Ztime2             -2.318514e-03           -3.297778e-03
#> esttypemu:Ztime3              3.562339e-03           -7.637118e-04
#> esttypemu:Z1_thiotepa         2.164362e-02            2.865047e-02
#> esttypemu:Z2_                -5.754039e-03           -6.320600e-03
#> esttypemu:Z3_B                4.927305e-03           -2.571065e-02
#> esttypemu:Z3_C                2.188602e-03           -1.776469e-02
#> esttypecif1                  -6.932968e-02           -1.521723e+00
#> esttypecif1:Ztime2            2.300688e-01           -3.362002e-01
#> esttypecif1:Ztime3            3.000138e-01            1.787134e-02
#> esttypecif1:Z1_thiotepa       1.787134e-02            2.339211e+00
#> esttypecif1:Z2_              -1.107262e-01           -2.453038e-03
#> esttypecif1:Z3_B              1.088409e-02           -1.035692e+00
#> esttypecif1:Z3_C              2.200748e-01            2.464818e-01
#> esttypecif2                  -1.881514e+14            2.717407e+14
#> esttypecif2:Ztime2           -7.330289e+13           -2.569508e+14
#> esttypecif2:Ztime3            3.517847e+13            4.113241e+13
#> esttypecif2:Z1_thiotepa       2.072825e+14            8.889470e+13
#> esttypecif2:Z2_               2.043264e+13           -3.493960e+12
#> esttypecif2:Z3_B             -1.070059e+14           -1.734517e+15
#> esttypecif2:Z3_C              1.120505e+14           -5.125167e+13
#>                         esttypecif1:Z2_ esttypecif1:Z3_B esttypecif1:Z3_C
#> esttypemu                 -7.789282e-03     6.408404e-03     2.289196e-02
#> esttypemu:Ztime2           9.498716e-04     2.254518e-03    -2.709481e-03
#> esttypemu:Ztime3          -6.274746e-05     2.417299e-03     3.550010e-03
#> esttypemu:Z1_thiotepa      8.347469e-03     3.124535e-02     3.462944e-02
#> esttypemu:Z2_              1.151068e-03    -6.123371e-03    -1.116020e-02
#> esttypemu:Z3_B             6.668261e-03     2.468811e-02     1.241832e-02
#> esttypemu:Z3_C             3.833420e-03     5.771070e-03     2.474505e-03
#> esttypecif1               -5.893573e-01     2.457764e-01    -2.668574e-02
#> esttypecif1:Ztime2        -1.077410e-01     1.089058e-01     5.696371e-02
#> esttypecif1:Ztime3        -1.107262e-01     1.088409e-02     2.200748e-01
#> esttypecif1:Z1_thiotepa   -2.453038e-03    -1.035692e+00     2.464818e-01
#> esttypecif1:Z2_            2.352698e-01     7.903611e-02    -1.424605e-01
#> esttypecif1:Z3_B           7.903611e-02     7.332691e-01    -3.344595e-03
#> esttypecif1:Z3_C          -1.424605e-01    -3.344595e-03     3.604689e-01
#> esttypecif2               -3.869708e+13     1.572450e+15    -3.249355e+14
#> esttypecif2:Ztime2        -1.466987e+14     4.505604e+14    -6.696759e+14
#> esttypecif2:Ztime3        -2.247159e+14    -1.064696e+14    -3.406440e+14
#> esttypecif2:Z1_thiotepa    5.077477e+14    -6.405420e+14     1.563341e+15
#> esttypecif2:Z2_            1.820512e+14    -1.593148e+13     2.467884e+14
#> esttypecif2:Z3_B          -4.594939e+14    -3.956532e+13    -1.048564e+15
#> esttypecif2:Z3_C          -2.857186e+14    -3.610978e+14     3.284515e+14
#>                           esttypecif2 esttypecif2:Ztime2 esttypecif2:Ztime3
#> esttypemu                8.948022e+14      -6.631206e+13      -4.833929e+13
#> esttypemu:Ztime2         8.964362e+12      -6.467753e+12      -4.711605e+12
#> esttypemu:Ztime3        -1.434208e+14       8.532344e+12       8.027534e+12
#> esttypemu:Z1_thiotepa    1.169071e+14      -3.606189e+13      -3.482142e+13
#> esttypemu:Z2_           -2.845186e+14       2.221747e+13       1.672654e+13
#> esttypemu:Z3_B          -1.537079e+14       2.595247e+13       2.183799e+13
#> esttypemu:Z3_C           1.692109e+14      -2.002645e+13      -1.651401e+13
#> esttypecif1             -6.097255e+14      -1.669373e+14      -1.881514e+14
#> esttypecif1:Ztime2       6.081850e+14      -1.072173e+14      -7.330289e+13
#> esttypecif1:Ztime3       8.473057e+14       1.775056e+12       3.517847e+13
#> esttypecif1:Z1_thiotepa -1.759793e+15       2.422822e+14       2.072825e+14
#> esttypecif1:Z2_         -6.215270e+14       3.061528e+13       2.043264e+13
#> esttypecif1:Z3_B         2.477648e+15      -1.312119e+14      -1.070059e+14
#> esttypecif1:Z3_C         9.189270e+14       1.107845e+14       1.120505e+14
#> esttypecif2              2.060311e+32       4.572720e+30       1.193382e+31
#> esttypecif2:Ztime2       4.572720e+30       1.183436e+31       1.719694e+31
#> esttypecif2:Ztime3       1.193382e+31       1.719694e+31       2.590665e+31
#> esttypecif2:Z1_thiotepa -7.381207e+31       1.001670e+30       7.893783e+29
#> esttypecif2:Z2_         -4.034894e+31      -5.926754e+29      -9.425671e+29
#> esttypecif2:Z3_B        -5.320961e+31       3.205921e+30       3.056467e+30
#> esttypecif2:Z3_C        -6.341426e+31       1.367861e+31       1.197085e+31
#>                         esttypecif2:Z1_thiotepa esttypecif2:Z2_
#> esttypemu                         -3.885809e+14   -2.266293e+14
#> esttypemu:Ztime2                   6.775220e+13   -1.859230e+13
#> esttypemu:Ztime3                   1.312398e+14   -3.236601e+12
#> esttypemu:Z1_thiotepa             -3.287492e+13    5.519523e+13
#> esttypemu:Z2_                      5.253464e+13    6.962715e+13
#> esttypemu:Z3_B                     2.570689e+14    1.146119e+13
#> esttypemu:Z3_C                     9.136090e+13   -3.401165e+13
#> esttypecif1                        2.717407e+14   -3.869708e+13
#> esttypecif1:Ztime2                -2.569508e+14   -1.466987e+14
#> esttypecif1:Ztime3                 4.113241e+13   -2.247159e+14
#> esttypecif1:Z1_thiotepa            8.889470e+13    5.077477e+14
#> esttypecif1:Z2_                   -3.493960e+12    1.820512e+14
#> esttypecif1:Z3_B                  -1.734517e+15   -4.594939e+14
#> esttypecif1:Z3_C                  -5.125167e+13   -2.857186e+14
#> esttypecif2                       -7.381207e+31   -4.034894e+31
#> esttypecif2:Ztime2                 1.001670e+30   -5.926754e+29
#> esttypecif2:Ztime3                 7.893783e+29   -9.425671e+29
#> esttypecif2:Z1_thiotepa            1.341243e+32    3.108212e+30
#> esttypecif2:Z2_                    3.108212e+30    1.259654e+31
#> esttypecif2:Z3_B                   5.294100e+30    1.553378e+30
#> esttypecif2:Z3_C                   9.115613e+30    2.712243e+30
#>                         esttypecif2:Z3_B esttypecif2:Z3_C
#> esttypemu                   2.386178e+14    -4.062448e+14
#> esttypemu:Ztime2            6.144940e+13    -2.450361e+13
#> esttypemu:Ztime3            1.460587e+14     9.826765e+13
#> esttypemu:Z1_thiotepa      -3.841683e+14    -3.056478e+14
#> esttypemu:Z2_              -5.765688e+12     1.572572e+14
#> esttypemu:Z3_B             -9.058238e+13     1.191259e+14
#> esttypemu:Z3_C             -1.151388e+14    -1.714943e+14
#> esttypecif1                 1.572450e+15    -3.249355e+14
#> esttypecif1:Ztime2          4.505604e+14    -6.696759e+14
#> esttypecif1:Ztime3         -1.064696e+14    -3.406440e+14
#> esttypecif1:Z1_thiotepa    -6.405420e+14     1.563341e+15
#> esttypecif1:Z2_            -1.593148e+13     2.467884e+14
#> esttypecif1:Z3_B           -3.956532e+13    -1.048564e+15
#> esttypecif1:Z3_C           -3.610978e+14     3.284515e+14
#> esttypecif2                -5.320961e+31    -6.341426e+31
#> esttypecif2:Ztime2          3.205921e+30     1.367861e+31
#> esttypecif2:Ztime3          3.056467e+30     1.197085e+31
#> esttypecif2:Z1_thiotepa     5.294100e+30     9.115613e+30
#> esttypecif2:Z2_             1.553378e+30     2.712243e+30
#> esttypecif2:Z3_B            7.532893e+31     4.348839e+31
#> esttypecif2:Z3_C            4.348839e+31     9.381073e+31
```

# Citation

To cite the `recurrentpseudo` package please use the following
references,

> Julie K. Furberg, Per K. Andersen, Sofie Korn, Morten Overgaard,
> Henrik Ravn: Bivariate pseudo-observations for recurrent event
> analysis with terminal events (Lifetime Data Analysis, 2021)
