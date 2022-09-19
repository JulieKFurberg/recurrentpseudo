#' Function that makes GEE model fit for recurrent pseudo-observations
#'
#' This function fits a GEE model based on pseudo-observations of the marginal mean function, and
#' the survival probability or cumulative incidences of two death causes
#' as returned by \code{pseudo.onedim()} (marginal mean function), or
#' \code{pseudo.twodim()} (marginal mean function and survival probability), or
#' \code{pseudo.threedim()} (marginal mean function and cumulative incidences of death causes 1 and 2)
#'
#' @param pseudodata Data set containing pseudo-observations. Expecting output from pseudo.twodim()
#' @param covar_names Vector with covariate names to be found in "pseudodata". E.g. covar_names = c("Z", "Z1")
#' @keywords recurrentpseudo
#' @references Furberg, J.K., Andersen, P.K., Korn, S. et al. Bivariate pseudo-observations for recurrent event analysis with terminal events. Lifetime Data Anal (2021). https://doi.org/10.1007/s10985-021-09533-5
#' @return An object of class \code{pseudo.geefit}.
#' \itemize{
#' \item{\code{xi}} {contains the estimated model parameters}
#' \item{\code{sigma}} {contains the estimated variance matrix corresponding to \code{xi}}
#' }
#' @import survival geepack stringr
#' @importFrom dplyr left_join
#' @importFrom dplyr ungroup
#' @importFrom dplyr mutate
#' @importFrom dplyr slice
#' @importFrom dplyr group_by
#' @importFrom magrittr %>%
#' @examples
#' # Bladder cancer data from survival package
#' require(survival)
#'
#' # Make a three level status variable
#' bladder1$status3 <- ifelse(bladder1$status %in% c(2, 3), 2, bladder1$status)
#'
#' # Add one extra day for the two patients with start=stop=0
#' # subset(bladder1, stop <= start)
#' bladder1[bladder1$id == 1, "stop"] <- 1
#' bladder1[bladder1$id == 49, "stop"] <- 1
#'
#' # Restrict the data to placebo and thiotepa
#' bladdersub <- subset(bladder1, treatment %in% c("placebo", "thiotepa"))
#'
#' # Make treatment variable two-level factor
#' bladdersub$Z <- as.factor(ifelse(bladdersub$treatment == "placebo", 0, 1))
#' levels(bladdersub$Z) <- c("placebo", "thiotepa")
#'
#' head(bladdersub)
#'
#' # Two-dimensional (bivariate pseudo-obs) model fit
#'
#' # Computation of pseudo-observations
#' pseudo_bladder_2d <- pseudo.twodim(tstart = bladdersub$start,
#'                                    tstop = bladdersub$stop,
#'                                    status = bladdersub$status3,
#'                                    id = bladdersub$id,
#'                                    covar_names = "Z",
#'                                    tk = c(30),
#'                                    data = bladdersub)
#'
#' # Data in wide format
#' head(pseudo_bladder_2d$outdata)
#'
#' # Data in long format
#' head(pseudo_bladder_2d$outdata_long)
#'
#' # GEE fit
#' fit_bladder_2d <- pseudo.geefit(pseudodata = pseudo_bladder_2d,
#'                                 covar_names = c("Z"))
#' fit_bladder_2d


# Main function for making GEE model fit
#' @export
pseudo.geefit <- function(pseudodata, covar_names){

  # Binding variables locally
  id <- esttype <- ts <- NULL

  # pull the selected k
  ksel <- pseudodata$k

  # It needs to be ordered by ID! Important
  pseudo_l <- as.data.frame(pseudodata$outdata_long)
  pseudo_l_o <- pseudo_l[order(pseudo_l$id, pseudo_l$esttype, pseudo_l$ts),]

  # Make time point variable
  pseudo_l_o$Ztime <- as.factor(pseudo_l_o$ts)

  if (inherits(pseudodata, "pseudo.onedim")){
    size <- 1
    pseudo_l_o2 <- pseudo_l_o

    # Fix covariate terms for analysis
    terms <- sapply(1:length(covar_names), function(i)  paste0(covar_names[i], ""))

    # Link function
    link <- rep("log", ksel)
  }

  if (inherits(pseudodata, "pseudo.twodim")){
    size <- 2
    # Due to geese parametrization of "cloglog" we need to fit 1 - surv instead
    # fixing this now
    pseudo_l_o2 <- pseudo_l_o
    pseudo_l_o2[pseudo_l_o2$esttype == "surv",]$y <- rep(1,
                                                         length(pseudo_l_o2[pseudo_l_o2$esttype == "surv",]$y)) -
      pseudo_l_o2[pseudo_l_o2$esttype == "surv",]$y

    # Fix covariate terms for analysis
    terms <- sapply(1:length(covar_names), function(i)  paste0(covar_names[i], ":esttype"))

    # Link function
    link <- c(rep("log", ksel), rep("cloglog", ksel))
  }


  if (inherits(pseudodata, "pseudo.threedim")){
    size <- 3
    # Subset - remove "surv"
    pseudo_l <- subset(pseudo_l_o, esttype != "surv")
    pseudo_l_o2 <- pseudo_l[order(pseudo_l$id, pseudo_l$esttype, pseudo_l$ts),]

    # Fix covariate terms for analysis
    terms <- sapply(1:length(covar_names), function(i)  paste0(covar_names[i], ":esttype"))

    # Link function
    link <- c(rep("cloglog", ksel), rep("cloglog", ksel), rep("log", ksel))
  }


    # Fit model
    if (length(covar_names) > 1){
      terms2 <- paste(terms, collapse = " + ")
    }
    if (length(covar_names) == 1){
      terms2 <- terms
    }

    # Add response etc
    if (inherits(pseudodata, c("pseudo.twodim", "pseudo.threedim"))){
      if (ksel > 1){
        a_terms <- formula(paste0("y ~ esttype + Ztime:esttype + ", terms2, "- 1"))
      }
      if (ksel == 1){
        a_terms <- formula(paste0("y ~ esttype + ", terms2, "- 1"))
      }
    }
    if (inherits(pseudodata, "pseudo.onedim")){
      if (ksel > 1){
        a_terms <- formula(paste0("y ~ Ztime +", terms2, ""))
      }
      if (ksel == 1){
        a_terms <- formula(paste0("y ~ ", terms2, ""))
      }

    }
    # Running the model fit
    fit <- geese(formula = a_terms,
                   data = pseudo_l_o2,
                   id = id,
                   mean.link = link,
                   variance = rep("gaussian", ksel * size),
                   sca.link = rep("identity", ksel * size),
                   scale.value = 1,
                   scale.fix = 1,
                   link.same = F,
                   gm = 1)
    summary(fit)

    # Save model estimates
    if (inherits(pseudodata, "pseudo.onedim")){
      # Save estimates
      xi <- fit$beta
      sigma <- fit$vbeta

      #Re-name in new order
      colnames(sigma) <- rownames(sigma) <- names(xi)

      # Make xi a matrix
      xi <- as.matrix(xi)
      colnames(xi) <- ""
    }


    if (inherits(pseudodata, "pseudo.twodim")){
      # Save estimates and
      # Change to get the right parametrization

      ## For mu, in order of covariates
      xi_names <- names(fit$beta)

      mu_place <- str_detect(xi_names, "esttypemu")
      surv_place <- str_detect(xi_names, "esttypesurv")

      # Re-order, mu first, then surv
      xi <- c(fit$beta[mu_place],
              fit$beta[surv_place])


      sigma_mu <- fit$vbeta[which(mu_place), which(mu_place)]
      sigma_surv <- fit$vbeta[which(surv_place), which(surv_place)]
      sigma_musurv <- fit$vbeta[which(mu_place), which(surv_place)]

      sigma <- rbind(cbind(sigma_mu, sigma_musurv),
                     cbind(sigma_musurv, sigma_surv))


      #Re-name in new order
      names(xi) <- c(names(fit$beta)[mu_place],
                     names(fit$beta)[surv_place])

      colnames(sigma) <- rownames(sigma) <- names(xi)

      # Make xi a matrix
      xi <- as.matrix(xi)
      colnames(xi) <- ""
  }

  if (inherits(pseudodata, "pseudo.threedim")){
      # Save estimates and
      # Change to get the right parametrization
      ## For mu, in order of covariates
      xi_names <- names(fit$beta)

      mu_place <- str_detect(xi_names, "esttypemu")
      cif1_place <- str_detect(xi_names, "esttypecif1")
      cif2_place <- str_detect(xi_names, "esttypecif2")

      # Re-order, mu first, then cif1, then cif2
      xi <- c(fit$beta[mu_place],
              fit$beta[cif1_place],
              fit$beta[cif2_place])


      sigma_mu <- fit$vbeta[which(mu_place), which(mu_place)]
      sigma_cif1 <- fit$vbeta[which(cif1_place), which(cif1_place)]
      sigma_cif2 <- fit$vbeta[which(cif2_place), which(cif2_place)]

      sigma_mucif1 <- fit$vbeta[which(mu_place), which(cif1_place)]
      sigma_mucif2 <- fit$vbeta[which(mu_place), which(cif2_place)]
      sigma_cif1cif2 <- fit$vbeta[which(cif1_place), which(cif2_place)]

      sigma <- rbind(cbind(sigma_mu, sigma_mucif1, sigma_mucif2),
                     cbind(sigma_mucif1, sigma_cif1, sigma_cif1cif2),
                     cbind(sigma_mucif2, sigma_cif1cif2, sigma_cif2)
                     )


      #Re-name in new order
      names(xi) <- c(names(fit$beta)[mu_place],
                     names(fit$beta)[cif1_place],
                     names(fit$beta)[cif2_place])

      colnames(sigma) <- rownames(sigma) <- names(xi)

      # Make xi a matrix
      xi <- as.matrix(xi)
      colnames(xi) <- ""
    }



# Output
obj <- list(xi = xi,
     sigma = sigma
     )
class(obj) <- "pseudo.geefit"
return(obj)

}
