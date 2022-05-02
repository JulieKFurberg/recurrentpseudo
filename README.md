
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
devtools::install_github("JulieKFurberg/recurrentpseudo")
```

# Citation

To cite the `recurrentpseudo` package please use the following
references,

> Julie K. Furberg, Per K. Andersen, Sofie Korn, Morten Overgaard,
> Henrik Ravn: Bivariate pseudo-observations for recurrent event
> analysis with terminal events (Lifetime Data Analysis, 2021)
