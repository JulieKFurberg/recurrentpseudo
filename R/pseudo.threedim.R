#' Function that computes 3-dim pseudo-observations
#'
#' This function computes 3-dimensional pseudo-observations of the marginal mean function
#' (in the presence of terminal events) and cumulative incidences
#' of death causes 1 and 2
#' @param tstart Start time - expecting counting process notation
#' @param tstop Stop time - expecting counting process notation
#' @param status Status variable (0 = censoring, 1 = recurrent event, 2 = death)
#' @param covar_names Vector containing names of covariates intended for further analysis
#' @param id ID variable for subject
#' @param tk Vector of time points to calculate pseudo-observations at
#' @param data Data set which contains variables of interest
#' @param deathtype Type of death (cause 1 or cause 2)
#' @keywords recurrentpseudo
#' @import survival geepack
#' @importFrom dplyr left_join
#' @references Furberg, J.K., Andersen, P.K., Korn, S. et al. Bivariate pseudo-observations for recurrent event analysis with terminal events. Lifetime Data Anal (2021). https://doi.org/10.1007/s10985-021-09533-5
#' @return
#' An object of class \code{pseudo.threedim}.
#' \itemize{
#' \item{\code{outdata}} {contains the semi-wide version of the computed pseudo-observations (one row per time, tk, per id).}
#' \item{\code{outdata_long}} {contains the long version of the computed pseudo-observations (one row per observation, several per id).}
#' \item{\code{indata}} {contains the input data which the pseudo-observations are based on.}
#' \item{\code{ts}} {vector with time points used for computation of pseudo-observations.}
#' \item{\code{k}} {number of time points used for computation of pseudo-observations (length(ts)).}
#' }
#' @examples
#' # Example: Bladder cancer data from survival package
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
#' head(bladdersub)
#'
#' # Add deathtype variable to bladder data
#' # Deathtype = 1 (bladder disease death), deathtype = 2 (other death reason)
#' bladdersub$deathtype <- with(bladdersub, ifelse(status == 2, 1, ifelse(status == 3, 2, 0)))
#' table(bladdersub$deathtype, bladdersub$status)
#'
#' # Pseudo-observations
#' pseudo_bladder_3d <- pseudo.threedim(tstart = bladdersub$start,
#'                                      tstop = bladdersub$stop,
#'                                      status = bladdersub$status3,
#'                                      id = bladdersub$id,
#'                                      deathtype = bladdersub$deathtype,
#'                                      covar_names = "Z",
#'                                      tk = c(30),
#'                                      data = bladdersub)
#' pseudo_bladder_3d
#'
#' # GEE fit
#' fit_bladder_3d <- pseudo.geefit(pseudodata = pseudo_bladder_3d,
#'                                 covar_names = c("Z"))
#' fit_bladder_3d

# Main driving function
#' @export
pseudo.threedim <- function(tstart, tstop, status, covar_names, id, tk, data, deathtype){

  k <- length(tk)
  input_ts <- tk
  indata <- data
  n <- length(unique(id))

  indata$tstart <- tstart
  indata$tstop <- tstop
  indata$status <- status
  indata$id <- id
  indata$deathtype <- deathtype


  # Selected time points - both for recurrent events + death
  ts <- input_ts

  # Creating the estimate on the entire data set
  est <- pseudo.surv_cif_mu_est(inputdata = indata,
                                tstart = indata$tstart,
                                tstop = indata$tstop,
                                id = indata$id,
                                status = indata$status,
                                deathtype = indata$deathtype)
  muest <- est$mu
  survest <- est$surv
  cif1 <- rbind(c(0,0), est$cif1)
  cif2 <- rbind(c(0,0), est$cif2)

  mu_ts  <- sapply(ts,  function(x) muest[which.max(muest$time[muest$time <= x]), "mu"])
  surv_ts  <- sapply(ts,  function(x) survest[which.max(survest$time[survest$time <= x]), "surv"])

  cif1_ts <- sapply(ts,  function(x) cif1[which.max(cif1$time[cif1$time <= x]), "cif"])
  cif2_ts  <- sapply(ts,  function(x) cif2[which.max(cif2$time[cif2$time <= x]), "cif"])


  # Compute the leave-one out estimates
  res_i <- list()
  n <- length(unique(indata$id))
  for(i in 1:n){
    unisub <- unique(indata$id)
    idi <- unisub[i]
    dat_i <- subset(indata, id != idi)

    esti <- pseudo.surv_cif_mu_est(inputdata = dat_i,
                                   tstart = dat_i$tstart,
                                   tstop = dat_i$tstop,
                                   id = dat_i$id,
                                   status = dat_i$status,
                                   deathtype = dat_i$deathtype)

    muesti <- esti$mu
    survesti <- esti$surv

    cif1_esti <- rbind(c(0,0), esti$cif1)
    cif2_esti <- rbind(c(0,0), esti$cif2)


    Zi <- indata[indata$id == idi,]$Z[1]

    mu_minus_i_ts  <- sapply(ts,  function(x) muesti[which.max(muesti$time[muesti$time <= x]), "mu"])
    surv_minus_i_ts  <- sapply(ts,  function(x) survesti[which.max(survesti$time[survesti$time <= x]), "surv"])

    cif1_minus_i_ts  <- sapply(ts,  function(x) cif1_esti[which.max(cif1_esti$time[cif1_esti$time <= x]), "cif"])
    cif2_minus_i_ts  <- sapply(ts,  function(x) cif2_esti[which.max(cif2_esti$time[cif2_esti$time <= x]), "cif"])

    res_i[[i]] <- list("mu_hat_ps"  = n * mu_ts - (n - 1) * mu_minus_i_ts,
                       "surv_hat_ps"  = n * surv_ts - (n - 1) * surv_minus_i_ts,
                       "cif1_hat_ps"  = n * cif1_ts - (n - 1) * cif1_minus_i_ts,
                       "cif2_hat_ps"  = n * cif2_ts - (n - 1) * cif2_minus_i_ts,
                       id = idi,
                       ts = ts)
  }
  tmp <- data.frame(do.call("rbind", res_i))

  outdata <- data.frame(mu = unlist(tmp$mu_hat_ps),
                        surv = unlist(tmp$surv_hat_ps),
                        cif1 = unlist(tmp$cif1_hat_ps),
                        cif2 = unlist(tmp$cif2_hat_ps),
                        k = rep(k),
                        ts = unlist(tmp$ts),
                        id = rep(unlist(tmp$id), each = k)
  )

  # Order by id, time
  outdata <- outdata[order(outdata$id, outdata$ts), ]

  # Add covariates etc - need to make a smaller dataset with first observations
  # (baseline covariates - should be unchanged)
  first <- as.data.frame(indata %>% group_by(id) %>% slice(1) %>% ungroup())


  outdata_xZ <- dplyr::left_join(x = outdata,
                          y = first[,c("id", covar_names)],
                          by = c("id"  = "id"))



  # Make it into long format
  outdata_long <- reshape(outdata,
                          varying = c("mu", "surv", "cif1", "cif2"),
                          v.names = "y",
                          timevar = "esttype",
                          times = c("mu", "surv", "cif1", "cif2"),
                          idvar = c("id", "ts"),
                          new.row.names = 1:(4*k*n),
                          direction = "long")

  # It needs to be ordered by ID! Important
  outdata_long_ord <- outdata_long[order(outdata_long$id, outdata_long$ts),]

  # Add covariates etc
  outdata_long_ord_xZ <- dplyr::left_join(x = outdata_long_ord,
                                   y = first[,c("id", covar_names)],
                                   by = c("id"  = "id"))

  # Return
  obj <- list(outdata_long = outdata_long_ord_xZ,
              outdata = outdata_xZ,
              k = k,
              ts = ts,
              indata = indata)

  # Set class
  class(obj) <- "pseudo.threedim"
  return(obj)
}
