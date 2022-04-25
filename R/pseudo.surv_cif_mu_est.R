#' Help function parsed inside pseudo.threedim()
#'
#' @param tstart Start time - expecting counting process notation
#' @param tstop Stop time - expecting counting process notation
#' @param status Status variable (0 = censoring, 1 = recurrent event, 2 = death)
#' @param id ID variable for subject
#' @param inputdata Data set which contains variables of interest
#' @param deathtype Type of death (cause 1 or cause 2)
#' @keywords recurrentpseudo
#' @import dplyr survival geepack cmprsk mets
#' @examples
#' pseudo.surv_cif_mu_est()


# Function that computes S, CIF, mu
#' @export
pseudo.surv_cif_mu_est <- function(inputdata,
                               tstart,
                               tstop,
                               status,
                               deathtype,
                               id){

  NAa_fit <- survfit(Surv(tstart, tstop, status == 1) ~ 1,
                     data = inputdata, id = id,
                     ctype = 1, timefix = FALSE)

  KM_fit <- survfit(Surv(tstart, tstop, status == 2) ~ 1,
                    data = inputdata, id = id, timefix = FALSE)

  # CIF - cause 1 & 2
  last <- inputdata[!duplicated(inputdata$id, fromLast = T),]
  cause1 <- cif(Event(stoptime, deathtype) ~ 1, data = last, cause = 1)
  cause2 <- cif(Event(stoptime, deathtype) ~ 1, data = last, cause = 2)

  # CIF - cause 1
  cause1 <- cif(Event(stoptime, deathtype) ~ 1, data = last, cause = 1)

  # Adjust hat(mu)
  mu_adj <- cumsum(KM_fit$surv * c(0, diff(NAa_fit$cumhaz)))
  surv <- KM_fit$surv


  # Save
  mudata <- data.frame(mu = mu_adj,
                       time = NAa_fit$time)

  CIF1 <- data.frame(cif = cause1$cumhaz[,2],
                     time = cause1$cumhaz[,1])

  CIF2 <- data.frame(cif = cause2$cumhaz[,2],
                     time = cause2$cumhaz[,1])

  # Normal surv
  survdata <- data.frame(surv = KM_fit$surv,
                         time = KM_fit$time)

  list(mu = mudata,
       surv = survdata,
       cif1 = CIF1,
       cif2 = CIF2
  )


}
