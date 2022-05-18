
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
![S(t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;S%28t%29 "S(t)"),
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

-   Andersen and Perme (*Pseudo-observations in survival
    analysis (2010)*) or

-   Andersen, Klein and Rosthøj (*Generalised linear models for
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
denotes some function. An example would be
![\\theta = E(I(D^\*\>t)) = P(D^\*\>t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Ctheta%20%3D%20E%28I%28D%5E%2A%3Et%29%29%20%3D%20P%28D%5E%2A%3Et%29 "\theta = E(I(D^*>t)) = P(D^*>t)").

Assume that a sufficiently nice estimator
![\\hat{\\theta}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7B%5Ctheta%7D "\hat{\theta}")
of
![\\theta](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Ctheta "\theta")
exists. For a fixed time,
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

Since the survival times are subject to right-censoring, standard
inference on survival data is adjusted to accommodate this, e.g. in
likelihood estimation.

However, since all subjects has a valid pseudo-observation,
![\\hat{\\theta}\_i (t)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7B%5Ctheta%7D_i%20%28t%29 "\hat{\theta}_i (t)"),
at one or more times, these can be used as an outcome variable in a
generalised linear model. Note, that this is regardless of the whether a
subject is alive, censored or died at time t.

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
are estimated using generalised estimating equations (GEE), see Liang
and Zeger (*Longitudinal data analysis using generalized linear models
(1986)*).

The GEE procedure accommodates the fact that each individual can have
several (pseudo-)observations.

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
\\log \\left( \\mu(t \\mid Z) \\right) = \\log(\\mu_0(t)) + \\beta^T Z.
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%5Clog%20%5Cleft%28%20%5Cmu%28t%20%5Cmid%20Z%29%20%5Cright%29%20%3D%20%5Clog%28%5Cmu_0%28t%29%29%20%2B%20%5Cbeta%5ET%20Z.%0A "
\log \left( \mu(t \mid Z) \right) = \log(\mu_0(t)) + \beta^T Z.
")

## Two-dimensional pseudo-observations

The two-dimensional pseudo-observations model is based on the parameter
![\\theta = (\\mu(t), S(t))](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Ctheta%20%3D%20%28%5Cmu%28t%29%2C%20S%28t%29%29 "\theta = (\mu(t), S(t))"),
which is estimated by

![
\\hat{\\theta} = \\left( \\begin{matrix} \\hat{\\mu}(t) \\\\ \\hat{S}(t) \\end{matrix} \\right).
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%5Chat%7B%5Ctheta%7D%20%3D%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Chat%7B%5Cmu%7D%28t%29%20%5C%5C%20%5Chat%7BS%7D%28t%29%20%5Cend%7Bmatrix%7D%20%5Cright%29.%0A "
\hat{\theta} = \left( \begin{matrix} \hat{\mu}(t) \\ \hat{S}(t) \end{matrix} \right).
")

We assume that

![
 \\left( \\begin{matrix} \\log \\left(\\mu (t \\mid Z) \\right) \\\\ \\text{cloglog} \\left( S( t \\mid Z) \\right) \\end{matrix} \\right) =  \\left( \\begin{matrix} \\log \\left(  \\mu_0(t) \\right)  + {\\beta}^T {Z} \\\\ \\log \\left(\\Lambda_0(t)\\right) + {\\gamma}^T {Z}  \\end{matrix} \\right).
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%5Cmu%20%28t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%28%20S%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5Cend%7Bmatrix%7D%20%5Cright%29%20%3D%20%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%20%20%5Cmu_0%28t%29%20%5Cright%29%20%20%2B%20%7B%5Cbeta%7D%5ET%20%7BZ%7D%20%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_0%28t%29%5Cright%29%20%2B%20%7B%5Cgamma%7D%5ET%20%7BZ%7D%20%20%5Cend%7Bmatrix%7D%20%5Cright%29.%0A "
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left( S( t \mid Z) \right) \end{matrix} \right) =  \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + {\beta}^T {Z} \\ \log \left(\Lambda_0(t)\right) + {\gamma}^T {Z}  \end{matrix} \right).
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
 \\left( \\begin{matrix} \\log \\left(\\mu (t \\mid Z) \\right) \\\\ \\text{cloglog} \\left(1- C_1( t \\mid Z) \\right) \\\\ \\text{cloglog} \\left(1- C_2( t \\mid Z) \\right) \\end{matrix} \\right) =  \\left( \\begin{matrix} \\log \\left(  \\mu_0(t) \\right)  + {\\beta}^T {Z} \\\\ \\log \\left(\\Lambda\_{10}(t)\\right) + {\\gamma_1}^T {Z} \\\\ \\log \\left(\\Lambda\_{20}(t)\\right) + {\\gamma_2}^T {Z}  \\end{matrix} \\right)
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%5Cmu%20%28t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%281-%20C_1%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%281-%20C_2%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5Cend%7Bmatrix%7D%20%5Cright%29%20%3D%20%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%20%20%5Cmu_0%28t%29%20%5Cright%29%20%20%2B%20%7B%5Cbeta%7D%5ET%20%7BZ%7D%20%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_%7B10%7D%28t%29%5Cright%29%20%2B%20%7B%5Cgamma_1%7D%5ET%20%7BZ%7D%20%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_%7B20%7D%28t%29%5Cright%29%20%2B%20%7B%5Cgamma_2%7D%5ET%20%7BZ%7D%20%20%5Cend%7Bmatrix%7D%20%5Cright%29%0A "
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left(1- C_1( t \mid Z) \right) \\ \text{cloglog} \left(1- C_2( t \mid Z) \right) \end{matrix} \right) =  \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + {\beta}^T {Z} \\ \log \left(\Lambda_{10}(t)\right) + {\gamma_1}^T {Z} \\ \log \left(\Lambda_{20}(t)\right) + {\gamma_2}^T {Z}  \end{matrix} \right)
")

# Install package from GitHub

``` r
require(devtools)

devtools::install_github("JulieKFurberg/recurrentpseudo", force = TRUE)
#> cli      (3.2.0 -> 3.3.0) [CRAN]
#> magrittr (2.0.2 -> 2.0.3) [CRAN]
#> package 'cli' successfully unpacked and MD5 sums checked
#> package 'magrittr' successfully unpacked and MD5 sums checked
#> 
#> The downloaded binary packages are in
#>  C:\Users\jukf\AppData\Local\Temp\RtmpiYYUNk\downloaded_packages
#> * checking for file 'C:\Users\jukf\AppData\Local\Temp\RtmpiYYUNk\remotes46c2b5728d8\JulieKFurberg-recurrentpseudo-638e3df/DESCRIPTION' ... OK
#> * preparing 'recurrentpseudo':
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building 'recurrentpseudo_1.0.0.tar.gz'
#> 

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

We focus on the comparison between placebo and thiotepa
(![n=86](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;n%3D86 "n=86")
in total). We model recurrent bladder tumours, and adjust for death
(cause 1: bladder cancer disease death, cause 2: other causes).

One-, two- and three-dimensional pseudo-observations are computed based
on a single time point,
![t=30](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;t%3D30 "t=30")
months.

For the comparison between placebo and thiotepa on recurrent bladder
tumours, the effect measure of interest is the mean ratio
![\\exp(\\beta)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cexp%28%5Cbeta%29 "\exp(\beta)").

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

Thus, the estimated mean ratio is
![\\exp(\\hat{\\beta})=](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cexp%28%5Chat%7B%5Cbeta%7D%29%3D "\exp(\hat{\beta})=")
0.6288327 (standard error and confidence intervals can be found using
the Delta method).

Alternatively, the bivariate pseudo-observation model using the binary
treatment indicator as covariate can be fitted, i.e. 

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
                                     tk = c(30), 
                                     data = bladdersub)
head(pseudo_bladder_3d$outdata_long)
#>   k ts id esttype            y       Z
#> 1 1 30  1      mu 1.421085e-14 placebo
#> 2 1 30  1    surv 1.421085e-14 placebo
#> 3 1 30  1    cif1 0.000000e+00 placebo
#> 4 1 30  1    cif2 1.000000e+00 placebo
#> 5 1 30  2      mu 1.421085e-14 placebo
#> 6 1 30  2    surv 1.421085e-14 placebo

# GEE fit
fit_bladder_3d <- pseudo.geefit(pseudodata = pseudo_bladder_3d,
                                covar_names = c("Z"))
fit_bladder_3d
#> $xi
#>                                 
#> esttypemu              0.5103755
#> esttypemu:Zthiotepa   -0.4638900
#> esttypecif1           -3.7618319
#> esttypecif1:Zthiotepa  0.2930357
#> esttypecif2           -1.5431978
#> esttypecif2:Zthiotepa -0.1005109
#> 
#> $sigma
#>                          esttypemu esttypemu:Zthiotepa esttypecif1
#> esttypemu              0.026463648        -0.026463648  0.01557625
#> esttypemu:Zthiotepa   -0.026463648         0.075441889 -0.01557625
#> esttypecif1            0.015576248        -0.015576248  1.07839851
#> esttypecif1:Zthiotepa -0.015576248         0.011524666 -1.07839851
#> esttypecif2           -0.006555927         0.006555927 -0.02642283
#> esttypecif2:Zthiotepa  0.006555927        -0.002799526  0.02642283
#>                       esttypecif1:Zthiotepa  esttypecif2 esttypecif2:Zthiotepa
#> esttypemu                       -0.01557625 -0.006555927           0.006555927
#> esttypemu:Zthiotepa              0.01152467  0.006555927          -0.002799526
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
#> treat, mu   -0.4638900
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
#>                treat, mu treat, cif1  treat, cif2
#> treat, mu    0.075441889  0.01152467 -0.002799526
#> treat, cif1  0.011524666  2.01305239 -0.057715255
#> treat, cif2 -0.002799526 -0.05771525  0.299045959
```

We can compare the three model fits. Note, that the
![\\mu](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cmu "\mu")
components match each other.

``` r
# Compare - should match for mu elements 
xi_diff_1d
#>                   
#> treat, mu -0.46389
xi_diff_2d
#>                        
#> treat, mu   -0.46388999
#> treat, surv -0.04800778
xi_diff_3d
#>                       
#> treat, mu   -0.4638900
#> treat, cif1  0.2930357
#> treat, cif2 -0.1005109

sigma_diff_1d
#>            treat, mu
#> treat, mu 0.07544189
sigma_diff_2d
#>                treat, mu  treat, surv
#> treat, mu    0.075441889 -0.001491879
#> treat, surv -0.001491879  0.260915569
sigma_diff_3d
#>                treat, mu treat, cif1  treat, cif2
#> treat, mu    0.075441889  0.01152467 -0.002799526
#> treat, cif1  0.011524666  2.01305239 -0.057715255
#> treat, cif2 -0.002799526 -0.05771525  0.299045959
```

### More covariates

Assume that we wish to add extra baseline covariates to the model fit.
For the sake of illustration, we have simulated a continuous covariate,
![Z_2](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Z_2 "Z_2"),
and a categorical covariate,
![Z_3](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Z_3 "Z_3").
The covariate
![Z_1](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Z_1 "Z_1")
corresponds to the binary treatment covariate
(![Z=1](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Z%3D1 "Z=1")
is thiotepa and
![Z=0](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;Z%3D0 "Z=0")
is placebo). In order to make estimation for these models possible, the
pseudo-observations are calculated at three time points, namely
![t=20, 30, 40](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;t%3D20%2C%2030%2C%2040 "t=20, 30, 40")
months.

For the one-dimensional model for
![\\mu](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cmu "\mu")
it holds that,

![
\\log \\left( \\mu(t \\mid Z) \\right) = \\log(\\mu_0(t)) + \\beta_1 Z_1 + \\beta_2 Z_2 + \\beta_3 Z_3.
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%5Clog%20%5Cleft%28%20%5Cmu%28t%20%5Cmid%20Z%29%20%5Cright%29%20%3D%20%5Clog%28%5Cmu_0%28t%29%29%20%2B%20%5Cbeta_1%20Z_1%20%2B%20%5Cbeta_2%20Z_2%20%2B%20%5Cbeta_3%20Z_3.%0A "
\log \left( \mu(t \mid Z) \right) = \log(\mu_0(t)) + \beta_1 Z_1 + \beta_2 Z_2 + \beta_3 Z_3.
")

This can be fitted using the below code,

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
set.seed(0308)

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
#> (Intercept)  0.345951102
#> Ztime30      0.431056408
#> Ztime40      0.611688331
#> Z1_thiotepa -0.321582092
#> Z2_         -0.081130521
#> Z3_B         0.005175893
#> Z3_C        -0.402507383
fit1$sigma
#>              (Intercept)       Ztime30       Ztime40  Z1_thiotepa           Z2_
#> (Intercept)  0.132980221 -0.0065866217 -0.0112534066 -0.032242723 -0.0249814696
#> Ztime30     -0.006586622  0.0045161549  0.0059299656  0.002036616  0.0002445982
#> Ztime40     -0.011253407  0.0059299656  0.0099140233  0.007026482 -0.0005924362
#> Z1_thiotepa -0.032242723  0.0020366159  0.0070264822  0.085690126 -0.0084327530
#> Z2_         -0.024981470  0.0002445982 -0.0005924362 -0.008432753  0.0112807578
#> Z3_B        -0.052194282  0.0011008023  0.0060232719  0.033814454 -0.0035167291
#> Z3_C        -0.038765856  0.0075345473  0.0144721351  0.022353061 -0.0086161477
#>                     Z3_B         Z3_C
#> (Intercept) -0.052194282 -0.038765856
#> Ztime30      0.001100802  0.007534547
#> Ztime40      0.006023272  0.014472135
#> Z1_thiotepa  0.033814454  0.022353061
#> Z2_         -0.003516729 -0.008616148
#> Z3_B         0.082912873  0.048768378
#> Z3_C         0.048768378  0.199350200

fit1$xi[4]
#> [1] -0.3215821
```

Or for two-dimensional pseudo-observations, it holds that

![
 \\left( \\begin{matrix} \\log \\left(\\mu (t \\mid Z) \\right) \\\\ \\text{cloglog} \\left( S( t \\mid Z) \\right) \\end{matrix} \\right) =  \\left( \\begin{matrix} \\log \\left(  \\mu_0(t) \\right)  + \\beta_1 {Z_1} + \\beta_2 {Z_2} + \\beta_3 {Z_3} \\\\ \\log \\left(\\Lambda_0(t)\\right) + {\\gamma_1} Z_1 + {\\gamma_2} Z_2 + {\\gamma_3} Z_3 \\end{matrix} \\right).
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%5Cmu%20%28t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%28%20S%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5Cend%7Bmatrix%7D%20%5Cright%29%20%3D%20%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%20%20%5Cmu_0%28t%29%20%5Cright%29%20%20%2B%20%5Cbeta_1%20%7BZ_1%7D%20%2B%20%5Cbeta_2%20%7BZ_2%7D%20%2B%20%5Cbeta_3%20%7BZ_3%7D%20%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_0%28t%29%5Cright%29%20%2B%20%7B%5Cgamma_1%7D%20Z_1%20%2B%20%7B%5Cgamma_2%7D%20Z_2%20%2B%20%7B%5Cgamma_3%7D%20Z_3%20%5Cend%7Bmatrix%7D%20%5Cright%29.%0A "
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left( S( t \mid Z) \right) \end{matrix} \right) =  \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + \beta_1 {Z_1} + \beta_2 {Z_2} + \beta_3 {Z_3} \\ \log \left(\Lambda_0(t)\right) + {\gamma_1} Z_1 + {\gamma_2} Z_2 + {\gamma_3} Z_3 \end{matrix} \right).
")

Or for three-dimensional pseudo-observations, it holds that

![
 \\left( \\begin{matrix} \\log \\left(\\mu (t \\mid Z) \\right) \\\\ \\text{cloglog} \\left( 1-C_1( t \\mid Z) \\right) \\\\ \\text{cloglog} \\left( 1-C_2( t \\mid Z) \\right) \\end{matrix} \\right) =  \\left( \\begin{matrix} \\log \\left(  \\mu_0(t) \\right)  + {\\beta_1} {Z_1} + {\\beta_2} {Z_2} + {\\beta_3} Z_3\\\\ \\log \\left(\\Lambda\_{10}(t)\\right) + \\gamma\_{11} {Z_1} + \\gamma\_{12} {Z_2} + \\gamma\_{13} {Z_3} \\\\ \\log \\left(\\Lambda\_{20}(t)\\right) + \\gamma\_{21} {Z_1} + \\gamma\_{22} {Z_2}  + \\gamma\_{23} {Z_3} \\end{matrix} \\right).
](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%0A%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%5Cmu%20%28t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%28%201-C_1%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5C%5C%20%5Ctext%7Bcloglog%7D%20%5Cleft%28%201-C_2%28%20t%20%5Cmid%20Z%29%20%5Cright%29%20%5Cend%7Bmatrix%7D%20%5Cright%29%20%3D%20%20%5Cleft%28%20%5Cbegin%7Bmatrix%7D%20%5Clog%20%5Cleft%28%20%20%5Cmu_0%28t%29%20%5Cright%29%20%20%2B%20%7B%5Cbeta_1%7D%20%7BZ_1%7D%20%2B%20%7B%5Cbeta_2%7D%20%7BZ_2%7D%20%2B%20%7B%5Cbeta_3%7D%20Z_3%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_%7B10%7D%28t%29%5Cright%29%20%2B%20%5Cgamma_%7B11%7D%20%7BZ_1%7D%20%2B%20%5Cgamma_%7B12%7D%20%7BZ_2%7D%20%2B%20%5Cgamma_%7B13%7D%20%7BZ_3%7D%20%5C%5C%20%5Clog%20%5Cleft%28%5CLambda_%7B20%7D%28t%29%5Cright%29%20%2B%20%5Cgamma_%7B21%7D%20%7BZ_1%7D%20%2B%20%5Cgamma_%7B22%7D%20%7BZ_2%7D%20%20%2B%20%5Cgamma_%7B23%7D%20%7BZ_3%7D%20%5Cend%7Bmatrix%7D%20%5Cright%29.%0A "
 \left( \begin{matrix} \log \left(\mu (t \mid Z) \right) \\ \text{cloglog} \left( 1-C_1( t \mid Z) \right) \\ \text{cloglog} \left( 1-C_2( t \mid Z) \right) \end{matrix} \right) =  \left( \begin{matrix} \log \left(  \mu_0(t) \right)  + {\beta_1} {Z_1} + {\beta_2} {Z_2} + {\beta_3} Z_3\\ \log \left(\Lambda_{10}(t)\right) + \gamma_{11} {Z_1} + \gamma_{12} {Z_2} + \gamma_{13} {Z_3} \\ \log \left(\Lambda_{20}(t)\right) + \gamma_{21} {Z_1} + \gamma_{22} {Z_2}  + \gamma_{23} {Z_3} \end{matrix} \right).
")

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
#> [1] -0.3215821
fit2$xi[4]
#> [1] -0.3215725
fit3$xi[4]
#> [1] -0.3215754
```

<!-- ## Plots  -->
<!-- The following plot shows non-parametric estimates of $\mu$ and $S$ based on the bladder cancer data.  -->
<!-- This is computed using the built-in function `pseudo.surv_mu_est`. -->
<!-- ```{r} -->
<!-- require(ggplot2) -->
<!-- require(gridExtra) -->
<!-- # Re-level  -->
<!-- bladdersub$status <- bladdersub$status3 -->
<!-- # Subset and estimate per group -->
<!-- Z1dat <- subset(bladdersub, Z == 'thiotepa') -->
<!-- Z0dat <- subset(bladdersub, Z == 'placebo') -->
<!-- estimates_treated <- pseudo.surv_mu_est(inputdata = Z1dat, -->
<!--                                         tstart = Z1dat$start,  -->
<!--                                         tstop = Z1dat$stop, -->
<!--                                         status = Z1dat$status, -->
<!--                                         id = Z1dat$id) -->
<!-- estimates_nontreated <- pseudo.surv_mu_est(inputdata = Z0dat, -->
<!--                                            tstart = Z0dat$start,  -->
<!--                                            tstop = Z0dat$stop, -->
<!--                                            status = Z0dat$status, -->
<!--                                            id = Z0dat$id) -->
<!-- pdata <- data.frame(mu = c(estimates_treated$mu$mu, estimates_nontreated$mu$mu),  -->
<!--                     time = c(estimates_treated$mu$time, estimates_nontreated$mu$time),  -->
<!--                     surv = c(estimates_treated$surv$surv, estimates_nontreated$surv$surv),  -->
<!--                     treat = c(rep("Placebo", length(estimates_treated$mu$mu)), -->
<!--                               rep("Thiotepa", length(estimates_nontreated$mu$mu)))) -->
<!-- # Mu  -->
<!-- bladmu <- ggplot(aes(x = time, y = mu, linetype = treat), data = pdata) +  -->
<!--   geom_step(size = 1) +  -->
<!--   scale_linetype_discrete("Treatment") +  -->
<!--   xlab("Time since randomisation (months)") +  -->
<!--   ylab(expression(hat(mu)(t))) +  -->
<!--   theme_bw() + -->
<!--   theme(legend.position="bottom",  -->
<!--         text = element_text(size=10)) + -->
<!--     guides(color=guide_legend(nrow=2,byrow=TRUE)) -->
<!-- # bladmu -->
<!-- # Surv -->
<!-- bladsurv <- ggplot(aes(x = time, y = surv, linetype = treat), data = pdata) +  -->
<!--   geom_step(size = 1) +  -->
<!--   scale_linetype_discrete("Treatment") +  -->
<!--   xlab("Time since randomisation (months)") +  -->
<!--   ylab(expression(hat(S)(t))) +  -->
<!--   theme_bw() + -->
<!--     theme(legend.position="bottom",  -->
<!--         text = element_text(size=10)) + -->
<!--     guides(color=guide_legend(nrow=2,byrow=TRUE)) -->
<!-- # bladsurv -->
<!-- blad_both <- grid.arrange(bladmu, bladsurv, ncol = 2) -->
<!-- blad_both -->
<!-- ``` -->
<!-- Let's make a plot displaying the pseudo-observations of $\mu$ for a given individual over time, -->
<!-- ```{r} -->
<!-- pseudo_allt <- pseudo.twodim(tstart = bladdersub$start, -->
<!--                              tstop = bladdersub$stop, -->
<!--                              status = bladdersub$status3, -->
<!--                              id = bladdersub$id, -->
<!--                              covar_names = "Z", -->
<!--                              tk = c(1:max(bladdersub$stop)), -->
<!--                              data = bladdersub) -->
<!-- # pseudo_allt -->
<!-- # Four types of subjects -->
<!-- #subset(bladdersub, id == 29) -->
<!-- #subset(bladdersub, id == 10) -->
<!-- #subset(bladdersub, id == 11) -->
<!-- #subset(bladdersub, id == 12) -->
<!-- # Restricting attention to these subjects -->
<!-- id29 <- subset(pseudo_allt$outdata, id == 29) -->
<!-- id10 <- subset(pseudo_allt$outdata, id == 10) -->
<!-- id11 <- subset(pseudo_allt$outdata, id == 11) -->
<!-- id12 <- subset(pseudo_allt$outdata, id == 12) -->
<!-- # Plot  -->
<!-- pseudo_id29 <- ggplot(aes(x = ts, y = mu), data = id29) +  -->
<!--               geom_step(size = 1) +  -->
<!--               xlab("Time since randomisation (months)") +  -->
<!--               ylab(expression(hat(mu)[i](t))) + theme_bw() +  -->
<!--               ggtitle("Subject ID: 29") + ylim(c(-1.1,3.6)) -->
<!-- # pseudo_id29 -->
<!-- pseudo_id10 <- ggplot(aes(x = ts, y = mu), data = id10) +  -->
<!--               geom_step(size = 1) +  -->
<!--               xlab("Time since randomisation (months)") +  -->
<!--               ylab(expression(hat(mu)[i](t))) + theme_bw() +  -->
<!--               ggtitle("Subject ID: 10") + ylim(c(-1.1,3.6)) -->
<!-- # pseudo_id10 -->
<!-- pseudo_id11 <- ggplot(aes(x = ts, y = mu), data = id11) +  -->
<!--               geom_step(size = 1) +  -->
<!--               xlab("Time since randomisation (months)") +  -->
<!--               ylab(expression(hat(mu)[i](t))) + theme_bw() +  -->
<!--               ggtitle("Subject ID: 11") + ylim(c(-1.1,3.6)) -->
<!-- # pseudo_id11 -->
<!-- pseudo_id12 <- ggplot(aes(x = ts, y = mu), data = id12) +  -->
<!--               geom_step(size = 1) +  -->
<!--               xlab("Time since randomisation (months)") +  -->
<!--               ylab(expression(hat(mu)[i](t))) +  -->
<!--               theme_bw() +  -->
<!--               ggtitle("Subject ID: 12") + ylim(c(-1.1,3.6)) -->
<!-- # pseudo_id12 -->
<!-- # Display all four together -->
<!-- allp <- grid.arrange(pseudo_id10, pseudo_id12,  -->
<!--                      pseudo_id11, pseudo_id29,  -->
<!--                      ncol = 2) -->
<!-- allp -->
<!-- ``` -->
<!-- ## Upcoming -->
<!-- To be added -->
<!-- - Plot of all pseudo-observations for a given individual -->
<!-- .. -->

# Citation

To cite the `recurrentpseudo` package please use the following
references,

> Julie K. Furberg, Per K. Andersen, Sofie Korn, Morten Overgaard,
> Henrik Ravn: Bivariate pseudo-observations for recurrent event
> analysis with terminal events (Lifetime Data Analysis, 2021)
