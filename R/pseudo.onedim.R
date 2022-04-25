#' Function that computes univariate pseudo-observations
#'
#' This function computes univariate pseudo-observations of the marginal mean function (in the presence of terminal events)
#' @param tstart Start time - expecting counting process notation
#' @param tstop Stop time - expecting counting process notation
#' @param status Status variable (0 = censoring, 1 = recurrent event, 2 = death)
#' @param covar_names Vector containing names of covariates intended for further analysis
#' @param id ID variable for subject
#' @param Z Covariate(s), Z
#' @param tk Vector of time points to calculate pseudo-observations at
#' @param data Data set which contains variables of interest
#' @keywords recurrentpseudo
#' @export
#' @import dplyr survival geepack
#' @examples
#' pseudo.onedim()

# Main driving function
pseudo.onedim <- function(tstart, tstop, status, covar_names, id, tk, data){

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
  est <- pseudo.surv_mu_est(inputdata = indata,
                            tstart = indata$tstart,
                            tstop = indata$tstop,
                            id = indata$id)
  muest <- est$mu
  survest <- est$surv

  mu_ts  <- sapply(ts,  function(x) muest[which.max(muest$time[muest$time <= x]), "mu"])
  surv_ts  <- sapply(ts,  function(x) survest[which.max(survest$time[survest$time <= x]), "surv"])


  # Compute the leave-one out estimates
  res_i <- list()
  n <- length(unique(indata$id))
  for(i in 1:n){
    unisub <- unique(indata$id)
    idi <- unisub[i]
    dat_i <- subset(indata, id != idi)

    esti <- pseudo.surv_mu_est(inputdata = dat_i,
                               tstart = dat_i$tstart,
                               tstop = dat_i$tstop,
                               id = dat_i$id)
    muesti <- esti$mu
    survesti <- esti$surv

    mu_minus_i_ts  <- sapply(ts,  function(x) muesti[which.max(muesti$time[muesti$time <= x]), "mu"])
    #surv_minus_i_ts  <- sapply(ts,  function(x) survesti[which.max(survesti$time[survesti$time <= x]), "surv"])

    res_i[[i]] <- list("mu_hat_ps"  = n * mu_ts - (n - 1) * mu_minus_i_ts,
                       #"surv_hat_ps"  = n * surv_ts - (n - 1) * surv_minus_i_ts,
                       id = idi,
                       ts = ts)
  }
  tmp <- data.frame(do.call("rbind", res_i))

  outdata <- data.frame(mu = unlist(tmp$mu_hat_ps),
                        #surv = unlist(tmp$surv_hat_ps),
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
                          varying = c("mu"),
                          #varying = c("mu", "surv"),
                          v.name = "y",
                          timevar = "esttype",
                          times = c("mu"),
                          #times = c("mu", "surv"),
                          idvar = c("id", "ts"),
                          new.row.names = 1:(2*k*n),
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
       dim = "onedim")
}
