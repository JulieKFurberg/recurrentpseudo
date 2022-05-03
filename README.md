
<!-- README.md is generated from README.Rmd. Please edit that file -->

# recurrentpseudo: An R package for analysing recurrent events in the presence of terminal events using pseudo-observations

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

For more detailed information, please see

1.  Andersen and Perme (*Pseudo-observations in survival
    analysis (2010)*) or

2.  Andersen, Klein and Rosthøj (*Generalised linear models for
    correlated pseudo-observations, with applications to multi-state
    models (2003)*)

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
 \\left( \\begin{matrix} \\log \\left(\\mu (t \\mid Z) \\right) \\\\ \\text{cloglog} \\left( C_1( t \\mid Z) \\right) \\\\ \\text{cloglog} \\left( C_2( t \\mid Z) \\right) \\end{matrix} \\right) =  \\left( \\begin{matrix} \\log \\left(  \\mu_0(t) \\right)  + {\\beta}^T {Z} \\\\ \\log \\left(\\Lambda\_{10}(t)\\right) + {\\gamma_1}^T {Z} \\\\ \\log \\left(\\Lambda\_{20}(t)\\right) + {\\gamma_2}^T {Z}  \\end{matrix} \\right)
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%5Cmu%20%28t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%28%20C_1%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%28%20C_2%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5Cend%7Bmatrix%7D%20%5Cright%29%20%3D%20%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%20%20%5Cmu_0%28t%29%20%5Cright%29%20%20%2B%20%7B%5Cbeta%7D%5ET%20%7BZ%7D%20%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_%7B10%7D%28t%29%5Cright%29%20%2B%20%7B%5Cgamma_1%7D%5ET%20%7BZ%7D%20%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_%7B20%7D%28t%29%5Cright%29%20%2B%20%7B%5Cgamma_2%7D%5ET%20%7BZ%7D%20%20%5Cend%7Bmatrix%7D%20%5Cright%29%0A "
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left( C_1( t \mid Z) \right) \\ \text{cloglog} \left( C_2( t \mid Z) \right) \end{matrix} \right) =  \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + {\beta}^T {Z} \\ \log \left(\Lambda_{10}(t)\right) + {\gamma_1}^T {Z} \\ \log \left(\Lambda_{20}(t)\right) + {\gamma_2}^T {Z}  \end{matrix} \right)
")

# Install package from GitHub

``` r
require(devtools)

devtools::install_github("JulieKFurberg/recurrentpseudo", force = TRUE)
#> cli      (3.2.0 -> 3.3.0) [CRAN]
#> magrittr (2.0.2 -> 2.0.3) [CRAN]
#> tibble   (3.1.6 -> 3.1.7) [CRAN]
#> 
#>   There is a binary version available but the source version is later:
#>        binary source needs_compilation
#> tibble  3.1.6  3.1.7              TRUE
#> 
#> Error in download.file(url, destfile, method, mode = "wb", ...) : 
#>   kan ikke åbne adresse 'https://cloud.r-project.org/bin/windows/contrib/4.1/cli_3.3.0.zip'
#> Error in download.file(url, destfile, method, mode = "wb", ...) : 
#>   kan ikke åbne adresse 'https://cloud.r-project.org/bin/windows/contrib/4.1/magrittr_2.0.3.zip'
#> * checking for file 'C:\Users\jukf\AppData\Local\Temp\RtmpsleVjz\remotes49c4155b71f4\JulieKFurberg-recurrentpseudo-b4b84bc/DESCRIPTION' ... OK
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

We model recurrent bladder cancer (status = 1), and adjust for death
(cause 1: bladder cancer disease death, cause 2: other causes).

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
treatment indicator as covariate, i.e. we model

![
\\log \\left( \\mu(t \\mid Z) \\right) = \\log(\\mu_0(t)) + \\beta Z
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%5Clog%20%5Cleft%28%20%5Cmu%28t%20%5Cmid%20Z%29%20%5Cright%29%20%3D%20%5Clog%28%5Cmu_0%28t%29%29%20%2B%20%5Cbeta%20Z%0A "
\log \left( \mu(t \mid Z) \right) = \log(\mu_0(t)) + \beta Z
")

We focus on a single time point
(![t=30](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;t%3D30 "t=30"))
in this computation.

One-dimensional pseudo-observations and GEE fit can be computed using
the following code

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
#> (Intercept)  0.5103755
#> Zthiotepa   -0.4638900
#> 
#> $sigma
#>             (Intercept)   Zthiotepa
#> (Intercept)  0.02646365 -0.02646365
#> Zthiotepa   -0.02646365  0.07544189

# Treatment differences
xi_diff_1d <- as.matrix(c(fit_bladder_1d$xi[2]), ncol = 1)

mslabels <- c("treat, mu")
rownames(xi_diff_1d) <- mslabels
colnames(xi_diff_1d) <- ""
xi_diff_1d
#>                   
#> treat, mu -0.46389

# Variance matrix for differences
sigma_diff_1d <- matrix(c(fit_bladder_1d$sigma[2,2]),
                          ncol = 1, nrow = 1,
                          byrow = T)

rownames(sigma_diff_1d) <- colnames(sigma_diff_1d) <- mslabels
sigma_diff_1d
#>            treat, mu
#> treat, mu 0.07544189
```

Alternatively, the bivariate pseudo-observation model using the binary
treatment indicator as covariate can be modelled, i.e. 

![
 \\left( \\begin{matrix} \\log \\left(\\mu (t \\mid Z) \\right) \\\\ \\text{cloglog} \\left( S( t \\mid Z) \\right) \\end{matrix} \\right) = \\left( \\begin{matrix} \\log \\left(  \\mu_0(t) \\right)  + {\\beta} {Z} \\\\ \\log \\left(\\Lambda_0(t)\\right) + {\\gamma} {Z}  \\end{matrix} \\right)
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%5Cmu%20%28t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%28%20S%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5Cend%7Bmatrix%7D%20%5Cright%29%20%3D%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%20%20%5Cmu_0%28t%29%20%5Cright%29%20%20%2B%20%7B%5Cbeta%7D%20%7BZ%7D%20%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_0%28t%29%5Cright%29%20%2B%20%7B%5Cgamma%7D%20%7BZ%7D%20%20%5Cend%7Bmatrix%7D%20%5Cright%29%0A "
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left( S( t \mid Z) \right) \end{matrix} \right) = \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + {\beta} {Z} \\ \log \left(\Lambda_0(t)\right) + {\gamma} {Z}  \end{matrix} \right)
")

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

We can compare the three model fits. Note, that the
![\\mu](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cmu "\mu")
components match each other.

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

### More covariates

Assume that we wish to add an extra continuous baseline covariate to the
model fit.

We have a binary covariate,
![Z_1](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Z_1 "Z_1"),
a continuous covariate,
![Z_2](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Z_2 "Z_2"),
and a categorical covariate,
![Z_3](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Z_3 "Z_3").

For the one-dimensional model for
![\\mu](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cmu "\mu")

![
\\log \\left( \\mu(t \\mid Z) \\right) = \\log(\\mu_0(t)) + \\beta_1 Z_1 + \\beta_2 Z_2 + \\beta_3 Z_3
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%5Clog%20%5Cleft%28%20%5Cmu%28t%20%5Cmid%20Z%29%20%5Cright%29%20%3D%20%5Clog%28%5Cmu_0%28t%29%29%20%2B%20%5Cbeta_1%20Z_1%20%2B%20%5Cbeta_2%20Z_2%20%2B%20%5Cbeta_3%20Z_3%0A "
\log \left( \mu(t \mid Z) \right) = \log(\mu_0(t)) + \beta_1 Z_1 + \beta_2 Z_2 + \beta_3 Z_3
")

``` r
require(dplyr)
#> Indlæser krævet pakke: dplyr
#> 
#> Vedhæfter pakke: 'dplyr'
#> De følgende objekter er maskerede fra 'package:stats':
#> 
#>     filter, lag
#> De følgende objekter er maskerede fra 'package:base':
#> 
#>     intersect, setdiff, setequal, union

## One-dim
# A binary variable, Z1_
# A continuous variable, Z2_
# A categorical variable, Z3_
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
#> (Intercept) -0.9936655
#> Ztime30      0.4976644
#> Ztime40      0.7040447
#> Z1_thiotepa -0.2409054
#> Z2_          0.2203842
#> Z3_B         0.2800207
#> Z3_C         0.2912614
fit1$sigma
#>             (Intercept)      Ztime30      Ztime40  Z1_thiotepa          Z2_
#> (Intercept)  0.53612709 -0.021945254 -0.044277323 -0.155376874 -0.103319306
#> Ztime30     -0.02194525  0.005483860  0.007320972  0.005208513  0.003750993
#> Ztime40     -0.04427732  0.007320972  0.012453586  0.012362118  0.008479332
#> Z1_thiotepa -0.15537687  0.005208513  0.012362118  0.108375003  0.028821624
#> Z2_         -0.10331931  0.003750993  0.008479332  0.028821624  0.024547405
#> Z3_B        -0.11792711  0.003130446  0.004628998  0.022205150  0.007538249
#> Z3_C        -0.09719636  0.005697424  0.011317208  0.003678264  0.002975783
#>                     Z3_B         Z3_C
#> (Intercept) -0.117927112 -0.097196361
#> Ztime30      0.003130446  0.005697424
#> Ztime40      0.004628998  0.011317208
#> Z1_thiotepa  0.022205150  0.003678264
#> Z2_          0.007538249  0.002975783
#> Z3_B         0.108905477  0.076844643
#> Z3_C         0.076844643  0.170226455

fit1$xi[4]
#> [1] -0.2409054
```

Or for two-dimensional pseudo-observations,

![
 \\left( \\begin{matrix} \\log \\left(\\mu (t \\mid Z) \\right) \\\\ \\text{cloglog} \\left( S( t \\mid Z) \\right) \\end{matrix} \\right) =  \\left( \\begin{matrix} \\log \\left(  \\mu_0(t) \\right)  + \\beta_1 {Z_1} + \\beta_2 {Z_2} + \\beta_3 {Z_3} \\\\ \\log \\left(\\Lambda_0(t)\\right) + {\\gamma_1} Z_1 + {\\gamma_2} Z_2 + {\\gamma_3} Z_3 \\end{matrix} \\right)
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%5Cmu%20%28t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%28%20S%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5Cend%7Bmatrix%7D%20%5Cright%29%20%3D%20%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%20%20%5Cmu_0%28t%29%20%5Cright%29%20%20%2B%20%5Cbeta_1%20%7BZ_1%7D%20%2B%20%5Cbeta_2%20%7BZ_2%7D%20%2B%20%5Cbeta_3%20%7BZ_3%7D%20%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_0%28t%29%5Cright%29%20%2B%20%7B%5Cgamma_1%7D%20Z_1%20%2B%20%7B%5Cgamma_2%7D%20Z_2%20%2B%20%7B%5Cgamma_3%7D%20Z_3%20%5Cend%7Bmatrix%7D%20%5Cright%29%0A "
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left( S( t \mid Z) \right) \end{matrix} \right) =  \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + \beta_1 {Z_1} + \beta_2 {Z_2} + \beta_3 {Z_3} \\ \log \left(\Lambda_0(t)\right) + {\gamma_1} Z_1 + {\gamma_2} Z_2 + {\gamma_3} Z_3 \end{matrix} \right)
")

Or for three-dimensional pseudo-observations,

![
 \\left( \\begin{matrix} \\log \\left(\\mu (t \\mid Z) \\right) \\\\ \\text{cloglog} \\left( C_1( t \\mid Z) \\right) \\\\ \\text{cloglog} \\left( C_2( t \\mid Z) \\right) \\end{matrix} \\right) =  \\left( \\begin{matrix} \\log \\left(  \\mu_0(t) \\right)  + {\\beta_1} {Z_1} + {\\beta_2} {Z_2} + {\\beta_3} Z_3\\\\ \\log \\left(\\Lambda\_{10}(t)\\right) + \\gamma\_{11} {Z_1} + \\gamma\_{12} {Z_2} + \\gamma\_{13} {Z_3} \\\\ \\log \\left(\\Lambda\_{20}(t)\\right) + \\gamma\_{21} {Z_1} + \\gamma\_{22} {Z_2}  + \\gamma\_{23} {Z_3} \\end{matrix} \\right)
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%5Cmu%20%28t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%28%20C_1%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%28%20C_2%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5Cend%7Bmatrix%7D%20%5Cright%29%20%3D%20%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%20%20%5Cmu_0%28t%29%20%5Cright%29%20%20%2B%20%7B%5Cbeta_1%7D%20%7BZ_1%7D%20%2B%20%7B%5Cbeta_2%7D%20%7BZ_2%7D%20%2B%20%7B%5Cbeta_3%7D%20Z_3%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_%7B10%7D%28t%29%5Cright%29%20%2B%20%5Cgamma_%7B11%7D%20%7BZ_1%7D%20%2B%20%5Cgamma_%7B12%7D%20%7BZ_2%7D%20%2B%20%5Cgamma_%7B13%7D%20%7BZ_3%7D%20%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_%7B20%7D%28t%29%5Cright%29%20%2B%20%5Cgamma_%7B21%7D%20%7BZ_1%7D%20%2B%20%5Cgamma_%7B22%7D%20%7BZ_2%7D%20%20%2B%20%5Cgamma_%7B23%7D%20%7BZ_3%7D%20%5Cend%7Bmatrix%7D%20%5Cright%29%0A "
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left( C_1( t \mid Z) \right) \\ \text{cloglog} \left( C_2( t \mid Z) \right) \end{matrix} \right) =  \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + {\beta_1} {Z_1} + {\beta_2} {Z_2} + {\beta_3} Z_3\\ \log \left(\Lambda_{10}(t)\right) + \gamma_{11} {Z_1} + \gamma_{12} {Z_2} + \gamma_{13} {Z_3} \\ \log \left(\Lambda_{20}(t)\right) + \gamma_{21} {Z_1} + \gamma_{22} {Z_2}  + \gamma_{23} {Z_3} \end{matrix} \right)
")

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

fit2$xi
#>                                    
#> esttypemu               -0.99366545
#> esttypemu:Ztime30        0.49766436
#> esttypemu:Ztime40        0.70404472
#> esttypemu:Z1_thiotepa   -0.24090537
#> esttypemu:Z2_            0.22038421
#> esttypemu:Z3_B           0.28002074
#> esttypemu:Z3_C           0.29126135
#> esttypesurv             -1.72215420
#> esttypesurv:Ztime30      0.34006050
#> esttypesurv:Ztime40      0.55398920
#> esttypesurv:Z1_thiotepa  0.07897286
#> esttypesurv:Z2_          0.02808048
#> esttypesurv:Z3_B        -0.31086002
#> esttypesurv:Z3_C        -0.18010053
fit2$sigma
#>                            esttypemu esttypemu:Ztime30 esttypemu:Ztime40
#> esttypemu                0.536127092     -0.0219452541      -0.044277323
#> esttypemu:Ztime30       -0.021945254      0.0054838605       0.007320972
#> esttypemu:Ztime40       -0.044277323      0.0073209722       0.012453586
#> esttypemu:Z1_thiotepa   -0.155376874      0.0052085128       0.012362118
#> esttypemu:Z2_           -0.103319306      0.0037509932       0.008479332
#> esttypemu:Z3_B          -0.117927112      0.0031304456       0.004628998
#> esttypemu:Z3_C          -0.097196361      0.0056974245       0.011317208
#> esttypesurv              0.013980391      0.0132615731      -0.027863731
#> esttypesurv:Ztime30      0.002708536     -0.0009100568       0.001184408
#> esttypesurv:Ztime40     -0.007211463     -0.0018307915       0.004502373
#> esttypesurv:Z1_thiotepa -0.035676196     -0.0025216089       0.017521704
#> esttypesurv:Z2_         -0.019506606     -0.0022767034       0.007206432
#> esttypesurv:Z3_B         0.086633041      0.0002553172      -0.003924591
#> esttypesurv:Z3_C         0.019633432     -0.0004301494       0.011334873
#>                         esttypemu:Z1_thiotepa esttypemu:Z2_ esttypemu:Z3_B
#> esttypemu                        -0.155376874  -0.103319306   -0.117927112
#> esttypemu:Ztime30                 0.005208513   0.003750993    0.003130446
#> esttypemu:Ztime40                 0.012362118   0.008479332    0.004628998
#> esttypemu:Z1_thiotepa             0.108375003   0.028821624    0.022205150
#> esttypemu:Z2_                     0.028821624   0.024547405    0.007538249
#> esttypemu:Z3_B                    0.022205150   0.007538249    0.108905477
#> esttypemu:Z3_C                    0.003678264   0.002975783    0.076844643
#> esttypesurv                       0.002549391  -0.019248209    0.092011554
#> esttypesurv:Ztime30              -0.001038502  -0.001249028   -0.005365993
#> esttypesurv:Ztime40               0.002195576   0.001199638   -0.008327603
#> esttypesurv:Z1_thiotepa           0.002060071   0.014098835   -0.021783887
#> esttypesurv:Z2_                   0.008662745   0.005472022   -0.012325318
#> esttypesurv:Z3_B                 -0.036832032  -0.010501808   -0.042454952
#> esttypesurv:Z3_C                 -0.005311031   0.003188154   -0.028743098
#>                         esttypemu:Z3_C  esttypesurv esttypesurv:Ztime30
#> esttypemu                 -0.097196361  0.013980391        0.0132615731
#> esttypemu:Ztime30          0.005697424  0.002708536       -0.0009100568
#> esttypemu:Ztime40          0.011317208 -0.007211463       -0.0018307915
#> esttypemu:Z1_thiotepa      0.003678264 -0.035676196       -0.0025216089
#> esttypemu:Z2_              0.002975783 -0.019506606       -0.0022767034
#> esttypemu:Z3_B             0.076844643  0.086633041        0.0002553172
#> esttypemu:Z3_C             0.170226455  0.019633432       -0.0004301494
#> esttypesurv                0.010426246  0.689725406       -0.0051627012
#> esttypesurv:Ztime30       -0.004141911 -0.005162701        0.0276100167
#> esttypesurv:Ztime40       -0.002166849 -0.061373049        0.0266322988
#> esttypesurv:Z1_thiotepa    0.027794461 -0.062395879       -0.0158546123
#> esttypesurv:Z2_            0.003807936 -0.153715921       -0.0090172588
#> esttypesurv:Z3_B          -0.024270521 -0.123960436        0.0339328448
#> esttypesurv:Z3_C          -0.013289741 -0.182508305        0.0190633491
#>                         esttypesurv:Ztime40 esttypesurv:Z1_thiotepa
#> esttypemu                      -0.027863731             0.002549391
#> esttypemu:Ztime30               0.001184408            -0.001038502
#> esttypemu:Ztime40               0.004502373             0.002195576
#> esttypemu:Z1_thiotepa           0.017521704             0.002060071
#> esttypemu:Z2_                   0.007206432             0.008662745
#> esttypemu:Z3_B                 -0.003924591            -0.036832032
#> esttypemu:Z3_C                  0.011334873            -0.005311031
#> esttypesurv                    -0.061373049            -0.062395879
#> esttypesurv:Ztime30             0.026632299            -0.015854612
#> esttypesurv:Ztime40             0.047598924            -0.007421615
#> esttypesurv:Z1_thiotepa        -0.007421615             0.207928072
#> esttypesurv:Z2_                 0.002779094            -0.005946642
#> esttypesurv:Z3_B                0.038516856            -0.031710996
#> esttypesurv:Z3_C                0.030553569             0.014608501
#>                         esttypesurv:Z2_ esttypesurv:Z3_B esttypesurv:Z3_C
#> esttypemu                  -0.019248209      0.092011554      0.010426246
#> esttypemu:Ztime30          -0.001249028     -0.005365993     -0.004141911
#> esttypemu:Ztime40           0.001199638     -0.008327603     -0.002166849
#> esttypemu:Z1_thiotepa       0.014098835     -0.021783887      0.027794461
#> esttypemu:Z2_               0.005472022     -0.012325318      0.003807936
#> esttypemu:Z3_B             -0.010501808     -0.042454952     -0.024270521
#> esttypemu:Z3_C              0.003188154     -0.028743098     -0.013289741
#> esttypesurv                -0.153715921     -0.123960436     -0.182508305
#> esttypesurv:Ztime30        -0.009017259      0.033932845      0.019063349
#> esttypesurv:Ztime40         0.002779094      0.038516856      0.030553569
#> esttypesurv:Z1_thiotepa    -0.005946642     -0.031710996      0.014608501
#> esttypesurv:Z2_             0.053615202     -0.017005574     -0.003586176
#> esttypesurv:Z3_B           -0.017005574      0.285396817      0.172301186
#> esttypesurv:Z3_C           -0.003586176      0.172301186      0.407687071


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

fit3$xi
#>                                      
#> esttypemu               -9.937783e-01
#> esttypemu:Ztime30        4.976720e-01
#> esttypemu:Ztime40        7.040568e-01
#> esttypemu:Z1_thiotepa   -2.408795e-01
#> esttypemu:Z2_            2.204060e-01
#> esttypemu:Z3_B           2.800510e-01
#> esttypemu:Z3_C           2.912701e-01
#> esttypecif1             -4.967486e+00
#> esttypecif1:Ztime30      2.799743e-02
#> esttypecif1:Ztime40      2.799743e-02
#> esttypecif1:Z1_thiotepa  2.743860e+00
#> esttypecif1:Z2_         -2.583311e-02
#> esttypecif1:Z3_B        -3.157439e+00
#> esttypecif1:Z3_C        -2.487309e+14
#> esttypecif2              7.105946e+17
#> esttypecif2:Ztime30      7.176957e+17
#> esttypecif2:Ztime40      1.138932e+18
#> esttypecif2:Z1_thiotepa  1.779463e+15
#> esttypecif2:Z2_          2.560103e+14
#> esttypecif2:Z3_B        -3.494126e+15
#> esttypecif2:Z3_C        -6.192736e+15
fit3$sigma
#>                             esttypemu esttypemu:Ztime30 esttypemu:Ztime40
#> esttypemu                5.361404e-01     -2.194531e-02     -4.427811e-02
#> esttypemu:Ztime30       -2.194531e-02      5.483942e-03      7.321090e-03
#> esttypemu:Ztime40       -4.427811e-02      7.321090e-03      1.245382e-02
#> esttypemu:Z1_thiotepa   -1.553804e-01      5.208681e-03      1.236247e-02
#> esttypemu:Z2_           -1.033208e-01      3.750934e-03      8.479372e-03
#> esttypemu:Z3_B          -1.179292e-01      3.130382e-03      4.629002e-03
#> esttypemu:Z3_C          -9.719725e-02      5.697368e-03      1.131743e-02
#> esttypecif1             -9.351028e-02      2.210358e-04      2.210358e-04
#> esttypecif1:Ztime30      3.712869e-03      7.991802e-05      7.991802e-05
#> esttypecif1:Ztime40      2.031105e-03      8.607662e-05      8.607662e-05
#> esttypecif1:Z1_thiotepa -4.265002e-02      4.702773e-04      4.702773e-04
#> esttypecif1:Z2_         -6.231417e-03      1.079923e-04      1.079923e-04
#> esttypecif1:Z3_B         1.289316e-01     -7.242141e-04     -7.242141e-04
#> esttypecif1:Z3_C         1.319550e-01     -8.867748e-04     -8.867748e-04
#> esttypecif2              5.592338e+15      1.283007e+12      1.282725e+12
#> esttypecif2:Ztime30     -3.823910e+14     -1.907371e+11     -1.907180e+11
#> esttypecif2:Ztime40     -6.354051e+14     -5.156294e+11     -5.155994e+11
#> esttypecif2:Z1_thiotepa -1.394314e+15     -6.219553e+11     -6.218908e+11
#> esttypecif2:Z2_         -1.026097e+15     -2.220345e+11     -2.219802e+11
#> esttypecif2:Z3_B        -1.705481e+15      9.878238e+11      9.878993e+11
#> esttypecif2:Z3_C        -4.965155e+14      1.251516e+11      1.251733e+11
#>                         esttypemu:Z1_thiotepa esttypemu:Z2_ esttypemu:Z3_B
#> esttypemu                       -1.553804e-01 -1.033208e-01  -1.179292e-01
#> esttypemu:Ztime30                5.208681e-03  3.750934e-03   3.130382e-03
#> esttypemu:Ztime40                1.236247e-02  8.479372e-03   4.629002e-03
#> esttypemu:Z1_thiotepa            1.083754e-01  2.882213e-02   2.220528e-02
#> esttypemu:Z2_                    2.882213e-02  2.454753e-02   7.537926e-03
#> esttypemu:Z3_B                   2.220528e-02  7.537926e-03   1.089076e-01
#> esttypemu:Z3_C                   3.677519e-03  2.975254e-03   7.684737e-02
#> esttypecif1                      4.666981e-02  1.366379e-02   6.789761e-02
#> esttypecif1:Ztime30             -2.975257e-03 -1.178421e-03  -4.580498e-03
#> esttypecif1:Ztime40             -3.375995e-03 -7.612182e-04  -8.492085e-03
#> esttypecif1:Z1_thiotepa         -2.212466e-03  1.707647e-02  -6.759216e-03
#> esttypecif1:Z2_                 -7.091281e-04  3.959594e-03  -1.622046e-02
#> esttypecif1:Z3_B                -4.790072e-02 -3.040758e-02   1.068007e-02
#> esttypecif1:Z3_C                -4.034517e-02 -3.452163e-02   5.659156e-05
#> esttypecif2                     -1.576635e+15 -1.373098e+15  -1.563879e+15
#> esttypecif2:Ztime30              1.408110e+14  1.097214e+14   2.706723e+13
#> esttypecif2:Ztime40              2.464389e+14  1.720574e+14   3.171606e+13
#> esttypecif2:Z1_thiotepa          1.751344e+14  3.797451e+14   2.375294e+14
#> esttypecif2:Z2_                  3.137007e+14  2.220602e+14   4.437622e+14
#> esttypecif2:Z3_B                 2.935663e+14  5.452758e+14  -9.911847e+13
#> esttypecif2:Z3_C                 2.612049e+14  1.576609e+14  -1.544098e+14
#>                         esttypemu:Z3_C   esttypecif1 esttypecif1:Ztime30
#> esttypemu                -9.719725e-02 -9.351028e-02        2.210358e-04
#> esttypemu:Ztime30         5.697368e-03  3.712869e-03        7.991802e-05
#> esttypemu:Ztime40         1.131743e-02  2.031105e-03        8.607662e-05
#> esttypemu:Z1_thiotepa     3.677519e-03 -4.265002e-02        4.702773e-04
#> esttypemu:Z2_             2.975254e-03 -6.231417e-03        1.079923e-04
#> esttypemu:Z3_B            7.684737e-02  1.289316e-01       -7.242141e-04
#> esttypemu:Z3_C            1.702313e-01  1.319550e-01       -8.867748e-04
#> esttypecif1              -1.039397e+11  1.430928e+00        2.878094e-03
#> esttypecif1:Ztime30       1.345437e+10  2.878094e-03        1.197111e-03
#> esttypecif1:Ztime40      -4.416911e+09  2.878094e-03        1.197111e-03
#> esttypecif1:Z1_thiotepa  -2.525323e+10 -3.583063e-01       -2.810538e-02
#> esttypecif1:Z2_           3.399872e+10 -3.391694e-01       -6.316457e-04
#> esttypecif1:Z3_B         -1.419869e+10  6.358539e-02        2.849773e-02
#> esttypecif1:Z3_C         -1.601068e+10 -1.411813e-01        1.316211e-02
#> esttypecif2               1.487449e+14 -8.128593e+15        1.353073e+13
#> esttypecif2:Ztime30      -1.123933e+14 -3.969138e+13        1.670795e+11
#> esttypecif2:Ztime40      -5.499172e+13 -3.969138e+13        1.670795e+11
#> esttypecif2:Z1_thiotepa   1.879239e+14  2.177598e+15       -2.330409e+13
#> esttypecif2:Z2_          -4.513140e+12  2.158269e+15        3.313816e+12
#> esttypecif2:Z3_B         -1.610639e+14  6.951907e+14        4.542381e+13
#> esttypecif2:Z3_C         -1.058432e+14  3.710560e+27       -4.601668e+27
#>                         esttypecif1:Ztime40 esttypecif1:Z1_thiotepa
#> esttypemu                      2.210358e-04            4.666981e-02
#> esttypemu:Ztime30              7.991802e-05           -2.975257e-03
#> esttypemu:Ztime40              8.607662e-05           -3.375995e-03
#> esttypemu:Z1_thiotepa          4.702773e-04           -2.212466e-03
#> esttypemu:Z2_                  1.079923e-04           -7.091281e-04
#> esttypemu:Z3_B                -7.242141e-04           -4.790072e-02
#> esttypemu:Z3_C                -8.867748e-04           -4.034517e-02
#> esttypecif1                    2.878094e-03           -3.583063e-01
#> esttypecif1:Ztime30            1.197111e-03           -2.810538e-02
#> esttypecif1:Ztime40            1.197111e-03           -2.810538e-02
#> esttypecif1:Z1_thiotepa       -2.810538e-02            1.370195e+00
#> esttypecif1:Z2_               -6.316457e-04           -2.205831e-02
#> esttypecif1:Z3_B               2.849773e-02           -1.230879e+00
#> esttypecif1:Z3_C               1.316211e-02           -2.690845e-01
#> esttypecif2                    6.794853e+12            8.414992e+14
#> esttypecif2:Ztime30            1.392384e+11           -1.085861e+13
#> esttypecif2:Ztime40            1.392384e+11           -1.085861e+13
#> esttypecif2:Z1_thiotepa       -2.201361e+13           -1.120018e+14
#> esttypecif2:Z2_                5.244775e+12           -2.134577e+14
#> esttypecif2:Z3_B               4.582244e+13           -1.900719e+15
#> esttypecif2:Z3_C              -7.309021e+27            2.131679e+26
#>                         esttypecif1:Z2_ esttypecif1:Z3_B esttypecif1:Z3_C
#> esttypemu                  1.366379e-02     6.789761e-02    -1.039397e+11
#> esttypemu:Ztime30         -1.178421e-03    -4.580498e-03     1.345437e+10
#> esttypemu:Ztime40         -7.612182e-04    -8.492085e-03    -4.416911e+09
#> esttypemu:Z1_thiotepa      1.707647e-02    -6.759216e-03    -2.525323e+10
#> esttypemu:Z2_              3.959594e-03    -1.622046e-02     3.399872e+10
#> esttypemu:Z3_B            -3.040758e-02     1.068007e-02    -1.419869e+10
#> esttypemu:Z3_C            -3.452163e-02     5.659156e-05    -1.601068e+10
#> esttypecif1               -3.391694e-01     6.358539e-02    -1.411813e-01
#> esttypecif1:Ztime30       -6.316457e-04     2.849773e-02     1.316211e-02
#> esttypecif1:Ztime40       -6.316457e-04     2.849773e-02     1.316211e-02
#> esttypecif1:Z1_thiotepa   -2.205831e-02    -1.230879e+00    -2.690845e-01
#> esttypecif1:Z2_            1.164114e-01     7.272011e-02    -2.771646e-02
#> esttypecif1:Z3_B           7.272011e-02     1.817308e+00     3.254944e-01
#> esttypecif1:Z3_C          -2.771646e-02     3.254944e-01     9.139175e+24
#> esttypecif2                2.342125e+15     1.251586e+15     5.859729e+13
#> esttypecif2:Ztime30        1.055785e+13     1.681588e+13     1.091664e+13
#> esttypecif2:Ztime40        1.055785e+13     1.681588e+13     1.091664e+13
#> esttypecif2:Z1_thiotepa   -3.604208e+14    -1.565225e+15    -9.308364e+14
#> esttypecif2:Z2_           -7.015398e+14     4.099011e+13     2.338475e+14
#> esttypecif2:Z3_B           1.273318e+13    -7.238929e+12     2.285683e+14
#> esttypecif2:Z3_C           5.258203e+25     2.267169e+25    -3.489917e+28
#>                           esttypecif2 esttypecif2:Ztime30 esttypecif2:Ztime40
#> esttypemu                5.592338e+15        1.283007e+12        1.282725e+12
#> esttypemu:Ztime30       -3.823910e+14       -1.907371e+11       -1.907180e+11
#> esttypemu:Ztime40       -6.354051e+14       -5.156294e+11       -5.155994e+11
#> esttypemu:Z1_thiotepa   -1.394314e+15       -6.219553e+11       -6.218908e+11
#> esttypemu:Z2_           -1.026097e+15       -2.220345e+11       -2.219802e+11
#> esttypemu:Z3_B          -1.705481e+15        9.878238e+11        9.878993e+11
#> esttypemu:Z3_C          -4.965155e+14        1.251516e+11        1.251733e+11
#> esttypecif1             -8.128593e+15        1.353073e+13        6.794853e+12
#> esttypecif1:Ztime30     -3.969138e+13        1.670795e+11        1.392384e+11
#> esttypecif1:Ztime40     -3.969138e+13        1.670795e+11        1.392384e+11
#> esttypecif1:Z1_thiotepa  2.177598e+15       -2.330409e+13       -2.201361e+13
#> esttypecif1:Z2_          2.158269e+15        3.313816e+12        5.244775e+12
#> esttypecif1:Z3_B         6.951907e+14        4.542381e+13        4.582244e+13
#> esttypecif1:Z3_C         3.710560e+27       -4.601668e+27       -7.309021e+27
#> esttypecif2              4.533008e+32        9.464115e+30        1.503302e+31
#> esttypecif2:Ztime30      9.464115e+30        9.586566e+30        1.521112e+31
#> esttypecif2:Ztime40      1.503302e+31        1.521112e+31        2.413689e+31
#> esttypecif2:Z1_thiotepa -9.968117e+31       -3.073120e+28       -1.678561e+28
#> esttypecif2:Z2_         -1.061794e+32        9.624115e+27        1.163046e+28
#> esttypecif2:Z3_B        -1.191861e+32        2.091861e+28       -6.464725e+27
#> esttypecif2:Z3_C        -7.892088e+31       -9.506019e+28       -1.435924e+29
#>                         esttypecif2:Z1_thiotepa esttypecif2:Z2_
#> esttypemu                         -1.576635e+15   -1.373098e+15
#> esttypemu:Ztime30                  1.408110e+14    1.097214e+14
#> esttypemu:Ztime40                  2.464389e+14    1.720574e+14
#> esttypemu:Z1_thiotepa              1.751344e+14    3.797451e+14
#> esttypemu:Z2_                      3.137007e+14    2.220602e+14
#> esttypemu:Z3_B                     2.935663e+14    5.452758e+14
#> esttypemu:Z3_C                     2.612049e+14    1.576609e+14
#> esttypecif1                        8.414992e+14    2.342125e+15
#> esttypecif1:Ztime30               -1.085861e+13    1.055785e+13
#> esttypecif1:Ztime40               -1.085861e+13    1.055785e+13
#> esttypecif1:Z1_thiotepa           -1.120018e+14   -3.604208e+14
#> esttypecif1:Z2_                   -2.134577e+14   -7.015398e+14
#> esttypecif1:Z3_B                  -1.900719e+15    1.273318e+13
#> esttypecif1:Z3_C                   2.131679e+26    5.258203e+25
#> esttypecif2                       -9.968117e+31   -1.061794e+32
#> esttypecif2:Ztime30               -3.073120e+28    9.624115e+27
#> esttypecif2:Ztime40               -1.678561e+28    1.163046e+28
#> esttypecif2:Z1_thiotepa            1.391146e+32    1.054869e+31
#> esttypecif2:Z2_                    1.054869e+31    3.466543e+31
#> esttypecif2:Z3_B                   1.676150e+31   -2.504312e+30
#> esttypecif2:Z3_C                  -7.502762e+30   -1.217157e+31
#>                         esttypecif2:Z3_B esttypecif2:Z3_C
#> esttypemu                  -1.563879e+15     1.487449e+14
#> esttypemu:Ztime30           2.706723e+13    -1.123933e+14
#> esttypemu:Ztime40           3.171606e+13    -5.499172e+13
#> esttypemu:Z1_thiotepa       2.375294e+14     1.879239e+14
#> esttypemu:Z2_               4.437622e+14    -4.513140e+12
#> esttypemu:Z3_B             -9.911847e+13    -1.610639e+14
#> esttypemu:Z3_C             -1.544098e+14    -1.058432e+14
#> esttypecif1                 1.251586e+15     5.859729e+13
#> esttypecif1:Ztime30         1.681588e+13     1.091664e+13
#> esttypecif1:Ztime40         1.681588e+13     1.091664e+13
#> esttypecif1:Z1_thiotepa    -1.565225e+15    -9.308364e+14
#> esttypecif1:Z2_             4.099011e+13     2.338475e+14
#> esttypecif1:Z3_B           -7.238929e+12     2.285683e+14
#> esttypecif1:Z3_C            2.267169e+25    -3.489917e+28
#> esttypecif2                -1.191861e+32    -7.892088e+31
#> esttypecif2:Ztime30         2.091861e+28    -9.506019e+28
#> esttypecif2:Ztime40        -6.464725e+27    -1.435924e+29
#> esttypecif2:Z1_thiotepa     1.676150e+31    -7.502762e+30
#> esttypecif2:Z2_            -2.504312e+30    -1.217157e+31
#> esttypecif2:Z3_B            1.893696e+32     1.185518e+32
#> esttypecif2:Z3_C            1.185518e+32     2.563133e+32

## Compare for mu
fit1$xi[4]
#> [1] -0.2409054
fit2$xi[4]
#> [1] -0.2409054
fit3$xi[4]
#> [1] -0.2408795
```

## Plots

# Citation

To cite the `recurrentpseudo` package please use the following
references,

> Julie K. Furberg, Per K. Andersen, Sofie Korn, Morten Overgaard,
> Henrik Ravn: Bivariate pseudo-observations for recurrent event
> analysis with terminal events (Lifetime Data Analysis, 2021)
