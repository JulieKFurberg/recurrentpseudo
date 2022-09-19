#' Function that computes bivariate pseudo-observations
#'
#' This function computes bivariate pseudo-observations of the marginal mean function
#' (in the presence of terminal events) and the survival probability
#' @param tstart Start time - expecting counting process notation
#' @param tstop Stop time - expecting counting process notation
#' @param status Status variable (0 = censoring, 1 = recurrent event, 2 = death)
#' @param covar_names Vector containing names of covariates intended for further analysis
#' @param id ID variable for subject
#' @param tk Vector of time points to calculate pseudo-observations at
#' @param data Data set which contains variables of interest
#' @keywords recurrentpseudo
#' @import survival geepack
#' @importFrom dplyr left_join
#' @return
#' An object of class \code{pseudo.twodim}.
#' \itemize{
#' \item{\code{outdata}} {contains the semi-wide version of the computed pseudo-observations (one row per time, tk, per id).}
#' \item{\code{outdata_long}} {contains the long version of the computed pseudo-observations (one row per observation, several per id).}
#' \item{\code{indata}} {contains the input data which the pseudo-observations are based on.}
#' \item{\code{ts}} {vector with time points used for computation of pseudo-observations.}
#' \item{\code{k}} {number of time points used for computation of pseudo-observations (length(ts)).}
#' }
#' @references Furberg, J.K., Andersen, P.K., Korn, S. et al. Bivariate pseudo-observations for recurrent event analysis with terminal events. Lifetime Data Anal (2021). https://doi.org/10.1007/s10985-021-09533-5
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
#' # Pseudo observations
#' pseudo_bladder_2d <- pseudo.twodim(tstart = bladdersub$start,
#'                                    tstop = bladdersub$stop,
#'                                    status = bladdersub$status3,
#'                                    id = bladdersub$id,
#'                                    covar_names = "Z",
#'                                    tk = c(30),
#'                                    data = bladdersub)
#' head(pseudo_bladder_2d$outdata)
#'
#' # GEE fit
#' fit_bladder_2d <- pseudo.geefit(pseudodata = pseudo_bladder_2d,
#'                                 covar_names = c("Z"))
#' fit_bladder_2d


# Main driving function
#' @export
pseudo.twodim <- function(tstart, tstop, status, covar_names, id, tk, data){

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
                            id = indata$id,
                            status = indata$status)
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
                               id = dat_i$id,
                               status = dat_i$status)
    muesti <- esti$mu
    survesti <- esti$surv

    mu_minus_i_ts  <- sapply(ts,  function(x) muesti[which.max(muesti$time[muesti$time <= x]), "mu"])
    surv_minus_i_ts  <- sapply(ts,  function(x) survesti[which.max(survesti$time[survesti$time <= x]), "surv"])

    res_i[[i]] <- list("mu_hat_ps"  = n * mu_ts - (n - 1) * mu_minus_i_ts,
                       "surv_hat_ps"  = n * surv_ts - (n - 1) * surv_minus_i_ts,
                       id = idi,
                       ts = ts)
  }
  tmp <- data.frame(do.call("rbind", res_i))

  outdata <- data.frame(mu = unlist(tmp$mu_hat_ps),
                        surv = unlist(tmp$surv_hat_ps),
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
                          varying = c("mu", "surv"),
                          v.names = "y",
                          timevar = "esttype",
                          times = c("mu", "surv"),
                          idvar = c("id", "ts"),
                          new.row.names = 1:(2*k*n),
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
  class(obj) <- "pseudo.twodim"

  return(obj)
}
