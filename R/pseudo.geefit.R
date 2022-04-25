#' Function that computes makes GEE model fit
#'
#' This function fits a GEE model based bivariate pseudo-observations of the marginal mean function and 
#' the survival probability as returned by pseudo.twodim()
#' 
#' @param pseudodata Data set containing pseudo-observations. Expecting output from pseudo.twodim()
#' @param covar_names Vector with covariate names to be found in "pseudodata". E.g. covar_names = c("Z", "Z1")
#' @keywords bivarpseudo
#' @export
#' @import dplyr survival geepack
#' @examples
#' pseudo.geefit()


# Main function for making GEE model fit

# Main function for making GEE model fit
pseudo.geefit <- function(pseudodata, covar_names){
  
  # pull the selected k
  ksel <- pseudodata$k
  
  # It needs to be ordered by ID! Important 
  pseudo_l <- as.data.frame(pseudodata$outdata_long)
  pseudo_l_o <- pseudo_l[order(pseudo_l$id, pseudo_l$esttype, pseudo_l$ts),]
  
  
  # Due to geese parametrization of "cloglog" we need to fit 1 - surv instead
  # fixing this now
  pseudo_l_o2 <- pseudo_l_o
  pseudo_l_o2[pseudo_l_o2$esttype == "surv",]$y <- rep(1, 
                                                       length(pseudo_l_o2[pseudo_l_o2$esttype == "surv",]$y)) - 
    pseudo_l_o2[pseudo_l_o2$esttype == "surv",]$y
  
  # Fix covariate terms for analysis
  terms <- sapply(1:length(covar_names), function(i)  paste0(covar_names[i], ":esttype"))
  
  
  if (length(covar_names) > 1){
    terms2 <- paste(terms, collapse = " + ")
  }
  if (length(covar_names) == 1){
    terms2 <- terms
  }
  
  # Add response etc 
  a_terms <- formula(paste0("y ~ ", terms2, " - 1"))
  a_terms
  
  # Running the model fit
  fit_1 <- geese(formula = a_terms, 
                 data = pseudo_l_o2, 
                 id = id, 
                 mean.link = c(rep("log", ksel), rep("cloglog", ksel)),
                 variance = rep("gaussian", ksel * 2),
                 sca.link = rep("identity", ksel * 2),
                 scale.value = 1, 
                 scale.fix = 1, 
                 link.same = F,
                 gm = 1)
  summary(fit_1)
  
  
  
  # Save estimates and
  # Change to get the right parametrization
  
  ## For mu, in order of covariates
  xi_names <- names(fit_1$beta)
  
  mu_place <- str_detect(xi_names, "esttypemu")
  surv_place <- str_detect(xi_names, "esttypesurv")
  
  # Re-order, mu first, then surv
  xi <- c(fit_1$beta[mu_place],
          fit_1$beta[surv_place])
  
  
  sigma_mu <- fit_1$vbeta[which(mu_place), which(mu_place)]
  sigma_surv <- fit_1$vbeta[which(surv_place), which(surv_place)]
  sigma_musurv <- fit_1$vbeta[which(mu_place), which(surv_place)]
  
  sigma <- rbind(cbind(sigma_mu, sigma_musurv),
                 cbind(sigma_musurv, sigma_surv))
  
  
  #Re-name in new order
  names(xi) <- c(names(fit_1$beta)[mu_place],
                 names(fit_1$beta)[surv_place])
  
  colnames(sigma) <- rownames(sigma) <- names(xi)
  
  # Make xi a matrix
  xi <- as.matrix(xi)
  colnames(xi) <- ""
  

  # Output
  list(xi = xi, 
       sigma = sigma
  )
  
}