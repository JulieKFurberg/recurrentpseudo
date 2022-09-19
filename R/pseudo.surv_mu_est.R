#' Help function parsed inside pseudo.onedim() and pseudo.twodim()
#'
#' @param tstart Start time - expecting counting process notation
#' @param tstop Stop time - expecting counting process notation
#' @param status Status variable (0 = censoring, 1 = recurrent event, 2 = death)
#' @param id ID variable for subject
#' @param inputdata Data set which contains variables of interest
#' @keywords recurrentpseudo
#' @import survival geepack stats
#' @importFrom dplyr left_join
#' @noRd
#' @examples
#' # Example: Bladder cancer data from survival package
#' require(survival)
#'
#' # Make a three level status variable
#' bladder1$status3 <- ifelse(bladder1$status %in% c(2, 3), 2, bladder1$status)
#' bladder1$status <- bladder1$status3
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
#' head(bladdersub)
#'
#'
#' # Estimate mu and surv on data
#' pseudo.surv_mu_est(inputdata = bladdersub,
#'                    tstart = bladdersub$start,
#'                    tstop = bladdersub$stop,
#'                    status = bladdersub$status,
#'                    id = bladdersub$id)



# Function that computes S and mu hat
pseudo.surv_mu_est <- function(inputdata,
                               tstart,
                               tstop,
                               status,
                               id){


  # Binding variables locally
  status <- NULL

  # NAa_fit1 <- survfit(Surv(tstart, tstop, status == 1) ~ 1,
  #                    data = inputdata, id = id,
  #                    ctype = 1, timefix = FALSE)
  NAa_fit2 <- basehaz(coxph(Surv(tstart, tstop, status == 1) ~ 1,
                           data = inputdata, id = id,
                           timefix = FALSE))

  KM_fit <- survfit(Surv(tstart, tstop, status == 2) ~ 1,
                    data = inputdata, id = id, timefix = FALSE)

  # Adjust hat(mu)
  lS <- c(1, na.omit(stats::lag(KM_fit$surv))[-length(KM_fit$surv)])
  dA <- diff(c(0, NAa_fit2$hazard))
  mu_adj <- cumsum(lS * dA)

  surv <- KM_fit$surv


  mudata <- data.frame(mu = mu_adj,
                       time = NAa_fit2$time)
  survdata <- data.frame(surv = surv,
                         time = KM_fit$time)

  list(mu = mudata,
       surv = survdata)

}
