
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
![\\theta = \\mu(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Ctheta%20%3D%20%5Cmu%28t%29 "\theta = \mu(t)"),
which is estimated by

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

We assume that

![
\\log \\left( \\mu(t \\mid Z) \\right) = \\log(\\mu_0(t)) + \\beta^T Z
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%5Clog%20%5Cleft%28%20%5Cmu%28t%20%5Cmid%20Z%29%20%5Cright%29%20%3D%20%5Clog%28%5Cmu_0%28t%29%29%20%2B%20%5Cbeta%5ET%20Z%0A "
\log \left( \mu(t \mid Z) \right) = \log(\mu_0(t)) + \beta^T Z
")

## Two-dimensional pseudo-observations

The two-dimensional pseudo-observations model is based on the parameter
![\\theta = (\\mu(t), S(t))](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Ctheta%20%3D%20%28%5Cmu%28t%29%2C%20S%28t%29%29 "\theta = (\mu(t), S(t))"),
which is estimated by

![
\\hat{\\theta} = \\left( \\begin{matrix} \\hat{\\mu}(t) \\\\ \\hat{S}(t) \\end{matrix} \\right)
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%5Chat%7B%5Ctheta%7D%20%3D%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Chat%7B%5Cmu%7D%28t%29%20%5C%5C%20%5Chat%7BS%7D%28t%29%20%5Cend%7Bmatrix%7D%20%5Cright%29%0A "
\hat{\theta} = \left( \begin{matrix} \hat{\mu}(t) \\ \hat{S}(t) \end{matrix} \right)
")

We assume that

![
 \\left( \\begin{matrix} \\log \\left(\\mu (t \\mid Z) \\right) \\\\ \\text{cloglog} \\left( S( t \\mid Z) \\right) \\end{matrix} \\right) =  \\left( \\begin{matrix} \\log \\left(  \\mu_0(t) \\right)  + {\\beta}^T {Z} \\\\ \\log \\left(\\Lambda_0(t)\\right) + {\\gamma}^T {Z}  \\end{matrix} \\right)
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%5Cmu%20%28t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%28%20S%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5Cend%7Bmatrix%7D%20%5Cright%29%20%3D%20%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%20%20%5Cmu_0%28t%29%20%5Cright%29%20%20%2B%20%7B%5Cbeta%7D%5ET%20%7BZ%7D%20%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_0%28t%29%5Cright%29%20%2B%20%7B%5Cgamma%7D%5ET%20%7BZ%7D%20%20%5Cend%7Bmatrix%7D%20%5Cright%29%0A "
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left( S( t \mid Z) \right) \end{matrix} \right) =  \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + {\beta}^T {Z} \\ \log \left(\Lambda_0(t)\right) + {\gamma}^T {Z}  \end{matrix} \right)
")

## Three-dimensional pseudo-observations

The three-dimensional pseudo-observations model is based on the
parameter
![\\theta = (\\mu(t), C_1(t), C_2(t))](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Ctheta%20%3D%20%28%5Cmu%28t%29%2C%20C_1%28t%29%2C%20C_2%28t%29%29 "\theta = (\mu(t), C_1(t), C_2(t))"),
which is estimated by

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

We assume that

![
 \\left( \\begin{matrix} \\log \\left(\\mu (t \\mid Z) \\right) \\\\ \\text{cloglog} \\left( C_1( t \\mid Z) \\right) \\\\ \\text{cloglog} \\left( C_2( t \\mid Z) \\right) \\end{matrix} \\right) =  \\left( \\begin{matrix} \\log \\left(  \\mu_0(t) \\right)  + {\\beta}^T {Z} \\\\ \\log \\left(\\Lambda\_{01}(t)\\right) + {\\gamma_1}^T {Z} \\\\ \\log \\left(\\Lambda\_{02}(t)\\right) + {\\gamma_2}^T {Z}  \\end{matrix} \\right)
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%5Cmu%20%28t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%28%20C_1%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%28%20C_2%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5Cend%7Bmatrix%7D%20%5Cright%29%20%3D%20%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%20%20%5Cmu_0%28t%29%20%5Cright%29%20%20%2B%20%7B%5Cbeta%7D%5ET%20%7BZ%7D%20%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_%7B01%7D%28t%29%5Cright%29%20%2B%20%7B%5Cgamma_1%7D%5ET%20%7BZ%7D%20%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_%7B02%7D%28t%29%5Cright%29%20%2B%20%7B%5Cgamma_2%7D%5ET%20%7BZ%7D%20%20%5Cend%7Bmatrix%7D%20%5Cright%29%0A "
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left( C_1( t \mid Z) \right) \\ \text{cloglog} \left( C_2( t \mid Z) \right) \end{matrix} \right) =  \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + {\beta}^T {Z} \\ \log \left(\Lambda_{01}(t)\right) + {\gamma_1}^T {Z} \\ \log \left(\Lambda_{02}(t)\right) + {\gamma_2}^T {Z}  \end{matrix} \right)
")

# Install package from GitHub

``` r
require(devtools)

devtools::install_github("JulieKFurberg/recurrentpseudo", force = TRUE)
#> cli      (3.2.0 -> 3.3.0) [CRAN]
#> magrittr (2.0.2 -> 2.0.3) [CRAN]
#> Error in download.file(url, destfile, method, mode = "wb", ...) : 
#>   kan ikke åbne adresse 'https://cloud.r-project.org/bin/windows/contrib/4.1/cli_3.3.0.zip'
#> Error in download.file(url, destfile, method, mode = "wb", ...) : 
#>   kan ikke åbne adresse 'https://cloud.r-project.org/bin/windows/contrib/4.1/magrittr_2.0.3.zip'
#> * checking for file 'C:\Users\jukf\AppData\Local\Temp\RtmpauBnXA\remotes482c2e567a0e\JulieKFurberg-recurrentpseudo-2ac8609/DESCRIPTION' ... OK
#> * preparing 'recurrentpseudo':
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building 'recurrentpseudo_0.0.0.9000.tar.gz'
#> 

require(recurrentpseudo)
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
#> 1  1.421085e-14 1 30  1 placebo
#> 2  1.421085e-14 1 30  2 placebo
#> 3  1.208604e+00 1 30  3 placebo
#> 4  1.054189e+00 1 30  4 placebo
#> 5 -1.157172e-01 1 30  5 placebo
#> 6  9.222575e-01 1 30  6 placebo

# GEE fit
fit_bladder_1d <- pseudo.geefit(pseudodata = pseudo_bladder_1d,
                                covar_names = c("Z"))
fit_bladder_1d
#> $xi
#>                     
#> Zplacebo  0.51037550
#> Zthiotepa 0.04648551
#> 
#> $sigma
#>             Zplacebo  Zthiotepa
#> Zplacebo  0.02646365 0.00000000
#> Zthiotepa 0.00000000 0.04897824

# Treatment differences
xi_diff_1d <- as.matrix(c(fit_bladder_1d$xi[2] - fit_bladder_1d$xi[1]), ncol = 1)

mslabels <- c("treat, mu")
rownames(xi_diff_1d) <- mslabels
colnames(xi_diff_1d) <- ""
xi_diff_1d
#>                   
#> treat, mu -0.46389

# Variance matrix for differences
sigma_diff_1d <- matrix(c(fit_bladder_1d$sigma[1,1] + fit_bladder_1d$sigma[2,2]),
                          ncol = 1, nrow = 1,
                          byrow = T)

rownames(sigma_diff_1d) <- colnames(sigma_diff_1d) <- mslabels
sigma_diff_1d
#>            treat, mu
#> treat, mu 0.07544189
```

Two-dimensional pseudo-observations can be computed using the following
code

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
#> 1  1.421085e-14  1.421085e-14 1 30  1 placebo
#> 2  1.421085e-14  1.421085e-14 1 30  2 placebo
#> 3  1.208604e+00  8.170875e-01 1 30  3 placebo
#> 4  1.054189e+00  8.170875e-01 1 30  4 placebo
#> 5 -1.157172e-01 -5.305763e-02 1 30  5 placebo
#> 6  9.222575e-01 -5.305763e-02 1 30  6 placebo

# GEE fit
fit_bladder_2d <- pseudo.geefit(pseudodata = pseudo_bladder_2d,
                                covar_names = c("Z"))
fit_bladder_2d
#> $xi
#>                                  
#> esttypemu              0.51037550
#> esttypemu:Zthiotepa   -0.46388999
#> esttypesurv           -1.41652478
#> esttypesurv:Zthiotepa -0.04800778
#> 
#> $sigma
#>                          esttypemu esttypemu:Zthiotepa  esttypesurv
#> esttypemu              0.026463648        -0.026463648 -0.004086557
#> esttypemu:Zthiotepa   -0.026463648         0.075441889  0.004086557
#> esttypesurv           -0.004086557         0.004086557  0.123251791
#> esttypesurv:Zthiotepa  0.004086557        -0.001491879 -0.123251791
#>                       esttypesurv:Zthiotepa
#> esttypemu                       0.004086557
#> esttypemu:Zthiotepa            -0.001491879
#> esttypesurv                    -0.123251791
#> esttypesurv:Zthiotepa           0.260915569

# Treatment differences
xi_diff_2d <- as.matrix(c(fit_bladder_2d$xi[2],
                          fit_bladder_2d$xi[4]), ncol = 1)

mslabels <- c("treat, mu", "treat, surv")
rownames(xi_diff_2d) <- mslabels
colnames(xi_diff_2d) <- ""
xi_diff_2d
#>                        
#> treat, mu   -0.46388999
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
#>                treat, mu  treat, surv
#> treat, mu    0.075441889 -0.001491879
#> treat, surv -0.001491879  0.260915569
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
                                     tk = c(30), #c(20, 30, 40)
                                     data = bladdersub)
head(pseudo_bladder_3d$outdata_long)
#>   k ts id esttype            y       Z
#> 1 1 30  1      mu 1.421085e-14 placebo
#> 2 1 30  1    surv 1.421085e-14 placebo
#> 3 1 30  1    cif1 0.000000e+00 placebo
#> 4 1 30  1    cif2 1.364508e+01 placebo
#> 5 1 30  2      mu 1.421085e-14 placebo
#> 6 1 30  2    surv 1.421085e-14 placebo

# GEE fit
fit_bladder_3d <- pseudo.geefit(pseudodata = pseudo_bladder_3d,
                                covar_names = c("Z"))
fit_bladder_3d
#> $xi
#>                                    
#> esttypemu              5.103755e-01
#> esttypemu:Zthiotepa   -4.638900e-01
#> esttypecif1           -3.761832e+00
#> esttypecif1:Zthiotepa  2.930357e-01
#> esttypecif2            1.426296e+18
#> esttypecif2:Zthiotepa  8.670644e+14
#> 
#> $sigma
#>                           esttypemu esttypemu:Zthiotepa   esttypecif1
#> esttypemu              2.646365e-02       -2.646365e-02  1.557625e-02
#> esttypemu:Zthiotepa   -2.646365e-02        7.544189e-02 -1.557625e-02
#> esttypecif1            1.557625e-02       -1.557625e-02  1.078399e+00
#> esttypecif1:Zthiotepa -1.557625e-02        1.152467e-02 -1.078399e+00
#> esttypecif2            1.592892e+12       -1.592892e+12  1.102815e+14
#> esttypecif2:Zthiotepa -1.592892e+12        1.041862e+12 -1.102815e+14
#>                       esttypecif1:Zthiotepa   esttypecif2 esttypecif2:Zthiotepa
#> esttypemu                     -1.557625e-02  1.592892e+12         -1.592892e+12
#> esttypemu:Zthiotepa            1.152467e-02 -1.592892e+12          1.041862e+12
#> esttypecif1                   -1.078399e+00  1.102815e+14         -1.102815e+14
#> esttypecif1:Zthiotepa          2.013052e+00 -1.102815e+14          2.373978e+14
#> esttypecif2                   -1.102815e+14  6.782195e+31         -6.782195e+31
#> esttypecif2:Zthiotepa          2.373978e+14 -6.782195e+31          1.535990e+32

# Treatment differences
xi_diff_3d <- as.matrix(c(fit_bladder_3d$xi[2],
                          fit_bladder_3d$xi[4],
                          fit_bladder_3d$xi[6]), ncol = 1)

mslabels <- c("treat, mu", "treat, cif1", "treat, cif2")
rownames(xi_diff_3d) <- mslabels
colnames(xi_diff_3d) <- ""
xi_diff_3d
#>                          
#> treat, mu   -4.638900e-01
#> treat, cif1  2.930357e-01
#> treat, cif2  8.670644e+14


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
#>                treat, mu  treat, cif1  treat, cif2
#> treat, mu   7.544189e-02 1.152467e-02 1.041862e+12
#> treat, cif1 1.152467e-02 2.013052e+00 2.373978e+14
#> treat, cif2 1.041862e+12 2.373978e+14 1.535990e+32
```

``` r
# //----------------------- Compare - should match for mu elements ---------------------------//
xi_diff_1d
#>                   
#> treat, mu -0.46389
xi_diff_2d
#>                        
#> treat, mu   -0.46388999
#> treat, surv -0.04800778
xi_diff_3d
#>                          
#> treat, mu   -4.638900e-01
#> treat, cif1  2.930357e-01
#> treat, cif2  8.670644e+14

sigma_diff_1d
#>            treat, mu
#> treat, mu 0.07544189
sigma_diff_2d
#>                treat, mu  treat, surv
#> treat, mu    0.075441889 -0.001491879
#> treat, surv -0.001491879  0.260915569
sigma_diff_3d
#>                treat, mu  treat, cif1  treat, cif2
#> treat, mu   7.544189e-02 1.152467e-02 1.041862e+12
#> treat, cif1 1.152467e-02 2.013052e+00 2.373978e+14
#> treat, cif2 1.041862e+12 2.373978e+14 1.535990e+32
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
                      covar_names = c("Z1_", "Z2_"))

fit1$xi
#>                        
#> Z1_placebo   0.36748600
#> Z1_thiotepa -0.13781223
#> Z2_          0.05211872
fit1$sigma
#>              Z1_placebo Z1_thiotepa         Z2_
#> Z1_placebo   0.17176970  0.17517720 -0.04898908
#> Z1_thiotepa  0.17517720  0.25901697 -0.05882843
#> Z2_         -0.04898908 -0.05882843  0.01642509

fit1$xi[1] - fit1$xi[2]
#> [1] 0.5052982
```

``` r
## Two-dim
# Treatment, binary variable:
pseudo_bladder_2d$outdata_long$Z1_ <- pseudo_bladder_1d$outdata_long$Z1_ 

# A continuous variable
pseudo_bladder_2d$outdata_long$Z2_ <- pseudo_bladder_1d$outdata_long$Z2_ 

# A categorical variable
pseudo_bladder_2d$outdata_long$Z3_ <- pseudo_bladder_1d$outdata_long$Z3_

fit2 <- pseudo.geefit(pseudodata = pseudo_bladder_2d, 
                      covar_names = c("Z1_", "Z2_"))

fit2$xi
#>                                    
#> esttypemu                0.28067527
#> esttypemu:Z1_thiotepa   -0.10717117
#> esttypemu:Z2_            0.03129312
#> esttypesurv             -0.46083104
#> esttypesurv:Z1_thiotepa -3.81123344
#> esttypesurv:Z2_         -0.10792767
fit2$sigma
#>                            esttypemu esttypemu:Z1_thiotepa esttypemu:Z2_
#> esttypemu                0.121042088          -0.019306352  -0.032501707
#> esttypemu:Z1_thiotepa   -0.019306352           0.078064636  -0.001485717
#> esttypemu:Z2_           -0.032501707          -0.001485717   0.010875870
#> esttypesurv             -0.020252511           0.071254599   0.003117402
#> esttypesurv:Z1_thiotepa -0.003781821           0.372625258   0.004599672
#> esttypesurv:Z2_          0.007360883          -0.020782498  -0.002385990
#>                          esttypesurv esttypesurv:Z1_thiotepa esttypesurv:Z2_
#> esttypemu               -0.020252511              0.07125460     0.003117402
#> esttypemu:Z1_thiotepa   -0.003781821              0.37262526     0.004599672
#> esttypemu:Z2_            0.007360883             -0.02078250    -0.002385990
#> esttypesurv              0.400610260              0.03742851    -0.125061983
#> esttypesurv:Z1_thiotepa  0.037428509             22.65568350    -0.036032594
#> esttypesurv:Z2_         -0.125061983             -0.03603259     0.045621705

fit2$xi[1] + fit2$xi[2]
#> [1] 0.1735041

## Three-dim
# Treatment, binary variable:
pseudo_bladder_3d$outdata_long$Z1_ <- pseudo_bladder_1d$outdata_long$Z1_ 

# A continuous variable
pseudo_bladder_3d$outdata_long$Z2_ <- pseudo_bladder_1d$outdata_long$Z2_ 

# A categorical variable
pseudo_bladder_3d$outdata_long$Z3_ <- pseudo_bladder_1d$outdata_long$Z3_

fit3 <- pseudo.geefit(pseudodata = pseudo_bladder_3d, 
                      covar_names = c("Z1_", "Z2_"))

fit3$xi
#>                                      
#> esttypemu                5.279682e-01
#> esttypemu:Z1_thiotepa   -3.210510e-01
#> esttypemu:Z2_           -2.193935e-02
#> esttypecif1             -7.493487e+00
#> esttypecif1:Z1_thiotepa  2.891015e+00
#> esttypecif1:Z2_          5.018907e-01
#> esttypecif2              1.430318e+18
#> esttypecif2:Z1_thiotepa  7.124714e+15
#> esttypecif2:Z2_         -2.331685e+15
fit3$sigma
#>                             esttypemu esttypemu:Z1_thiotepa esttypemu:Z2_
#> esttypemu                1.510203e-01         -4.105274e-03 -4.473755e-02
#> esttypemu:Z1_thiotepa   -4.105274e-03          8.159973e-02 -7.874587e-03
#> esttypemu:Z2_           -4.473755e-02         -7.874587e-03  1.601995e-02
#> esttypecif1             -4.293921e-02          1.234112e-02  4.678279e-03
#> esttypecif1:Z1_thiotepa -2.401249e-02          1.202641e-02  6.858577e-03
#> esttypecif1:Z2_          9.882415e-03         -2.417334e-03 -9.065527e-04
#> esttypecif2              8.733383e+13          3.394446e+14 -8.198234e+13
#> esttypecif2:Z1_thiotepa  3.446456e+14         -1.900042e+14 -8.890682e+13
#> esttypecif2:Z2_          8.514285e+13         -2.416817e+13 -2.543097e+13
#>                           esttypecif1 esttypecif1:Z1_thiotepa esttypecif1:Z2_
#> esttypemu               -4.293921e-02            1.234112e-02    4.678279e-03
#> esttypemu:Z1_thiotepa   -2.401249e-02            1.202641e-02    6.858577e-03
#> esttypemu:Z2_            9.882415e-03           -2.417334e-03   -9.065527e-04
#> esttypecif1              6.829797e+00           -5.185923e-01   -1.627431e+00
#> esttypecif1:Z1_thiotepa -5.185923e-01            9.469589e-01    3.309061e-02
#> esttypecif1:Z2_         -1.627431e+00            3.309061e-02    4.111175e-01
#> esttypecif2             -1.382285e+15           -2.282674e+14    5.109791e+14
#> esttypecif2:Z1_thiotepa  2.626469e+15            5.787112e+14   -9.701247e+14
#> esttypecif2:Z2_          1.634798e+14            2.553335e+13   -6.019635e+13
#>                           esttypecif2 esttypecif2:Z1_thiotepa esttypecif2:Z2_
#> esttypemu                8.733383e+13            3.394446e+14   -8.198234e+13
#> esttypemu:Z1_thiotepa    3.446456e+14           -1.900042e+14   -8.890682e+13
#> esttypemu:Z2_            8.514285e+13           -2.416817e+13   -2.543097e+13
#> esttypecif1             -1.382285e+15           -2.282674e+14    5.109791e+14
#> esttypecif1:Z1_thiotepa  2.626469e+15            5.787112e+14   -9.701247e+14
#> esttypecif1:Z2_          1.634798e+14            2.553335e+13   -6.019635e+13
#> esttypecif2              3.601137e+32           -1.818269e+31   -1.078705e+32
#> esttypecif2:Z1_thiotepa -1.818269e+31            1.620793e+32   -1.822026e+31
#> esttypecif2:Z2_         -1.078705e+32           -1.822026e+31    3.977844e+31


fit3$xi[1] + fit3$xi[2]
#> [1] 0.2069172
```

# Citation

To cite the `recurrentpseudo` package please use the following
references,

> Julie K. Furberg, Per K. Andersen, Sofie Korn, Morten Overgaard,
> Henrik Ravn: Bivariate pseudo-observations for recurrent event
> analysis with terminal events (Lifetime Data Analysis, 2021)
