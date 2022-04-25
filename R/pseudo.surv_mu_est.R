#' Help function parsed inside pseudo.twodim()
#'
#' @param tstart Start time - expecting counting process notation
#' @param tstop Stop time - expecting counting process notation
#' @param status Status variable (0 = censoring, 1 = recurrent event, 2 = death)
#' @param id ID variable for subject
#' @param inputdata Data set which contains variables of interest 
#' @keywords bivarpseudo
#' @export
#' @import dplyr survival geepack
#' @examples
#' pseudo.surv_mu_est()


# Function that computes S and mu hat
pseudo.surv_mu_est <- function(inputdata, 
                               tstart, 
                               tstop, 
                               status, 
                               id){
  
  NAa_fit <- survfit(Surv(tstart, tstop, status == 1) ~ 1,
                     data = inputdata, id = id,
                     ctype = 1, timefix = FALSE)
  
  KM_fit <- survfit(Surv(tstart, tstop, status == 2) ~ 1,
                    data = inputdata, id = id, timefix = FALSE)
  
  # Adjust hat(mu)
  mu_adj <- cumsum(KM_fit$surv * c(0, diff(NAa_fit$cumhaz)))
  surv <- KM_fit$surv
  
  
  mudata <- data.frame(mu = mu_adj, 
                       time = NAa_fit$time)
  survdata <- data.frame(surv = surv, 
                         time = KM_fit$time)
  
  list(mu = mudata, 
       surv = survdata)
  
}