#' Help function parsed inside pseudo.threedim()
#'
#' @param tstart Start time - expecting counting process notation
#' @param tstop Stop time - expecting counting process notation
#' @param status Status variable (0 = censoring, 1 = recurrent event, 2 = death)
#' @param id ID variable for subject
#' @param inputdata Data set which contains variables of interest
#' @param deathtype Type of death (cause 1 or cause 2)
#' @keywords recurrentpseudo
#' @import survival geepack prodlim
#' @importFrom dplyr left_join
#' @noRd
#' @examples
#' # Example: Bladder cancer data from survival package
#' require(survival)
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
#' # Add deathtype variable to bladder data
#' # Deathtype = 1 (bladder disease death), deathtype = 2 (other death reason)
#' bladdersub$deathtype <- with(bladdersub, ifelse(status == 2, 1, ifelse(status == 3, 2, 0)))
#' table(bladdersub$deathtype, bladdersub$status)
#'
#' #' # Make a three level status variable
#' bladdersub$status <- ifelse(bladdersub$status %in% c(2, 3), 2, bladdersub$status)
#'
#'
#' bladdersub$tstart <- bladdersub$start
#' bladdersub$tstop <- bladdersub$stop
#'
#' # Estimate mu and cif1 and cif2 on data
#' pseudo.surv_cif_mu_est(inputdata = bladdersub,
#'                        tstart = bladdersub$start,
#'                        tstop = bladdersub$stop,
#'                        status = bladdersub$status,
#'                        deathtype = bladdersub$deathtype,
#'                        id = bladdersub$id)

# Function that computes S, CIF, mu
pseudo.surv_cif_mu_est <- function(inputdata,
                                   tstart,
                                   tstop,
                                   status,
                                   deathtype,
                                   id){

  # NAa_fit1 <- survfit(Surv(tstart, tstop, status == 1) ~ 1,
  #                    data = inputdata, id = id,
  #                    ctype = 1, timefix = FALSE)
  NAa_fit2 <- basehaz(coxph(Surv(tstart, tstop, status == 1) ~ 1,
                            data = inputdata, id = id,
                            timefix = FALSE))

  KM_fit <- survfit(Surv(tstart, tstop, status == 2) ~ 1,
                    data = inputdata, id = id, timefix = FALSE)

  # CIF - cause 1 & 2
  last <- inputdata[!duplicated(inputdata$id, fromLast = T),]

  tstop <- deathtype <- NULL
  causes <- prodlim(Hist(tstop, deathtype) ~ 1, data = last)
  #cause1 <- cif(Event(tstop, deathtype) ~ 1, data = last, cause = 1)
  #cause2 <- cif(Event(tstop, deathtype) ~ 1, data = last, cause = 2)

  # Adjust hat(mu)
  lS <- c(1, na.omit(stats::lag(KM_fit$surv))[-length(KM_fit$surv)])
  dA <- diff(c(0, NAa_fit2$hazard))
  mu_adj <- cumsum(lS * dA)

  surv <- KM_fit$surv

  # Save
  mudata <- data.frame(mu = mu_adj,
                       time = NAa_fit2$time)

  CIF1 <- data.frame(cif = causes$cuminc$`1`,
                     time = causes$time)

  CIF2 <- data.frame(cif = causes$cuminc$`2`,
                     time = causes$time)

  # Normal surv
  survdata <- data.frame(surv = KM_fit$surv,
                         time = KM_fit$time)

  list(mu = mudata,
       surv = survdata,
       cif1 = CIF1,
       cif2 = CIF2
  )


}
