#' Function that computes 3-dim pseudo-observations
#'
#' This function computes 3-dimensional pseudo-observations of the marginal mean function and cumulative incidences of death causes 1 and 2
#' @param tstart Start time - expecting counting process notation
#' @param tstop Stop time - expecting counting process notation
#' @param status Status variable (0 = censoring, 1 = recurrent event, 2 = death)
#' @param covar_names Vector containing names of covariates intended for further analysis
#' @param id ID variable for subject
#' @param Z Covariate(s), Z
#' @param tk Vector of time points to calculate pseudo-observations at
#' @param data Data set which contains variables of interest
#' @param deathtype Type of death (cause 1 or cause 2)
#' @keywords recurrentpseudo
#' @import dplyr survival geepack
#' @examples
#' pseudo.threedim()

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


  # Selected time points - both for recurrent events + death
  ts <- input_ts

  # Creating the estimate on the entire data set
  est <- pseudo.surv_cif_mu_est(inputdata = indata)
  muest <- est$mu
  survest <- est$surv
  cif1 <- rbind(c(0,1), est$cif1)
  cif2 <- rbind(c(0,1), est$cif2)

  #head(cif_cv_est)

  mu_ts  <- sapply(ts,  function(x) muest[which.max(muest$time[muest$time <= x]), "mu"])
  surv_ts  <- sapply(ts,  function(x) survest[which.max(survest$time[survest$time <= x]), "surv"])

  cif1_ts <- sapply(ts,  function(x) cif1[which.max(cif1$time[cif1$time <= x]), "cif"])
  cif2_ts  <- sapply(ts,  function(x) cif2[which.max(cif2$time[cif2$time <= x]), "cif"])


  # Compute the leave-one out estimates
  res_i <- list()
  n <- length(unique(indata$id))
  for(i in 1:n){
    dat_i <- subset(indata, id != idi)

    esti <- pseudo.surv_cif_mu_est(inputdata = subset(indata, id != idi))
    muesti <- esti$mu
    survesti <- esti$surv

    cif1_esti <- rbind(c(0,1), esti$cif1)
    cif2_esti <- rbind(c(0,1), esti$cif1)


    Zi <- indata[indata$id == idi,]$Z[1]

    mu_minus_i_ts  <- sapply(ts_e,  function(x) muesti[which.max(muesti$time[muesti$time <= x]), "mu"])
    surv_minus_i_ts  <- sapply(ts_d,  function(x) survesti[which.max(survesti$time[survesti$time <= x]), "surv"])

    cif1_minus_i_ts  <- sapply(ts_d,  function(x) cif1_esti[which.max(cif1_esti$time[cif1_esti$time <= x]), "cif"])
    cif2_minus_i_ts  <- sapply(ts_d,  function(x) cif2_esti[which.max(cif2_esti$time[cif2_esti$time <= x]), "cif"])

    res_i[[i]] <- list("mu_hat_ps"  = n * mu_ts - (n - 1) * mu_minus_i_ts,
                       "surv_hat_ps"  = n * surv_ts - (n - 1) * surv_minus_i_ts,
                       "cif1_hat_ps"  = n * cif1_ts - (n - 1) * cif1_minus_i_ts,
                       "cif2_hat_ps"  = n * cif2_ts - (n - 1) * cif2_minus_i_ts,
                       id = idi,
                       ts = ts)
  }
  tmp <- data.frame(do.call("rbind", res_i))

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
  first <- as.data.frame(indata %>% group_by(id) %>% filter(row_number(id) == 1))


  outdata_xZ <- left_join(x = outdata,
                          y = first[,c("id", covar_names)],
                          by = c("id"  = "id"))



  # Make it into long format
  outdata_long <- reshape(outdata,
                          varying = c("mu", "surv", "cif1", "cif2"),
                          v.name = "y",
                          timevar = "esttype",
                          times = c("mu", "surv", "cif1", "cif2"),
                          idvar = c("id", "ts"),
                          new.row.names = 1:(4*k*n),
                          direction = "long")
  head(outdata_long)


  # It needs to be ordered by ID! Important
  outdata_long_ord <- outdata_long[order(outdata_long$id, outdata_long$ts),]

  head(outdata_long_ord)

  # Add covariates etc
  outdata_long_ord_xZ <- left_join(x = outdata_long_ord,
                                   y = first[,c("id", covar_names)],
                                   by = c("id"  = "id"))



  list(outdata_long = outdata_long_ord_xZ,
       outdata = outdata_xZ,
       k = k,
       ts = ts,
       indata = indata,
       dim = "threedim")
}
