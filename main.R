#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#
#------------ recurrentpseudo R package  ---------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

#=================================================================================================#
# Required packages                                                                               #
#=================================================================================================#

library("devtools")
library("roxygen2")


setwd("C:/Users/jukf/OneDrive - Novo Nordisk/Private/ErhvervsPhd/Article 3 - R package/R package")
#create("recurrentpseudo")

setwd("./recurrentpseudo")
document()

setwd("..")
install("recurrentpseudo")


?pseudo.twodim
?pseudo.onedim
?pseudo.threedim

?pseudo.geefit

#devtools::load_all()

# https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
# https://kbroman.org/github_tutorial/pages/routine.html
# https://support.rstudio.com/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN

#=================================================================================================#
# Install from GitHub                                                                             #
#=================================================================================================#
#library("devtools")
#install_github("JulieKFurberg/recurrentpseudo")

#library(recurrentpseudo)

#=================================================================================================#
# Checking examples                                                                               #
#=================================================================================================#

#=================================================================================================#
# Bladder cancer data                                                                             #
#=================================================================================================#

# Bare essentials!
require(survival)
require(dplyr)

# Make a three level status variable
bladder1$status3 <- ifelse(bladder1$status %in% c(2, 3), 2, bladder1$status)

# Add one extra day for the two patients with start=stop=0
bladder1[bladder1$stop <= bladder1$start, ]$stop <- bladder1[bladder1$stop <= bladder1$start, ]$start + 1

# Restrict the data to placebo and thiotepa
bladdersub <- subset(bladder1, treatment %in% c("placebo", "thiotepa"))

# Make treatment variable two-level factor
bladdersub$Z <- as.factor(ifelse(bladdersub$treatment == "placebo", 0, 1))
levels(bladdersub$Z) <- c("placebo", "thiotepa")


head(bladdersub)



###----------------------- One-dim bladder ---------------------------###
# Pseudo observations
pseudo_bladder_1d <- pseudo.onedim(tstart = bladdersub$start,
                                   tstop = bladdersub$stop,
                                   status = bladdersub$status3,
                                   id = bladdersub$id,
                                   covar_names = "Z",
                                   tk = c(20, 30, 40),
                                   data = bladdersub)
head(pseudo_bladder_1d$outdata)

# GEE fit
fit_bladder_1d <- pseudo.geefit(pseudodata = pseudo_bladder_1d,
                             covar_names = c("Z"))
fit_bladder_1d


# Treatment differences
xi_diff_1d <- as.matrix(c(fit_bladder_1d$xi[2] - fit_bladder_1d$xi[1]), ncol = 1)

mslabels <- c("treat, mu")
rownames(xi_diff_1d) <- mslabels
colnames(xi_diff_1d) <- ""
xi_diff_1d

# Variance matrix for differences
sigma_diff_1d <- matrix(c(fit_bladder_1d$sigma[1,1] + fit_bladder_1d$sigma[2,2]),
                     ncol = 1, nrow = 1,
                     byrow = T)

rownames(sigma_diff_1d) <- colnames(sigma_diff_1d) <- mslabels
sigma_diff_1d

###----------------------- Two-dim bladder ---------------------------###

# Computation of pseudo-observations
pseudo_bladder_2d <- pseudo.twodim(tstart = bladdersub$start,
                                   tstop = bladdersub$stop,
                                   status = bladdersub$status3,
                                   id = bladdersub$id,
                                   covar_names = "Z",
                                   tk = c(20, 30, 40),
                                   data = bladdersub)

# Data in wide format
head(pseudo_bladder_2d$outdata)

# Data in long format
head(pseudo_bladder_2d$outdata_long)


# GEE fit
fit_bladder_2d <- pseudo.geefit(pseudodata = pseudo_bladder_2d,
                             covar_names = c("Z"))
fit_bladder_2d


# Treatment differences
xi_diff_2d <- as.matrix(c(fit_bladder_2d$xi[2] - fit_bladder_2d$xi[1],
                          fit_bladder_2d$xi[4] - fit_bladder_2d$xi[3]), ncol = 1)

mslabels <- c("treat, mu", "treat, surv")
rownames(xi_diff_2d) <- mslabels
colnames(xi_diff_2d) <- ""
xi_diff_2d


# Variance matrix for differences
sigma_diff_2d <- matrix(c(fit_bladder_2d$sigma[1,1] + fit_bladder_2d$sigma[2,2],
                          fit_bladder_2d$sigma[1,3] + fit_bladder_2d$sigma[2,4],
                          fit_bladder_2d$sigma[1,3] + fit_bladder_2d$sigma[2,4],
                          fit_bladder_2d$sigma[3,3] + fit_bladder_2d$sigma[4,4]),
                          ncol = 2, nrow = 2,
                          byrow = T)

rownames(sigma_diff_2d) <- colnames(sigma_diff_2d) <- mslabels
sigma_diff_2d


###----------------------- Three-dim bladder ---------------------------###

# Add deathtype variable to bladder data
# Deathtype = 1 (bladder disease death), deathtype = 2 (other death reason)
bladdersub$deathtype <- with(bladdersub, ifelse(status == 2, 1, ifelse(status == 3, 2, 0)))
table(bladdersub$deathtype, bladdersub$status)


# Pseudo-observations
pseudo_bladder_3d <- pseudo.threedim(tstart = bladdersub$start,
                                     tstop = bladdersub$stop,
                                     status = bladdersub$status3,
                                     id = bladdersub$id,
                                     deathtype = bladdersub$deathtype,
                                     covar_names = "Z",
                                     tk = c(20, 30, 40),
                                     data = bladdersub)

# GEE fit
fit_bladder_3d <- pseudo.geefit(pseudodata = pseudo_bladder_3d,
                                covar_names = c("Z"))
fit_bladder_3d




# Treatment differences
xi_diff_3d <- as.matrix(c(fit_bladder_3d$xi[2] - fit_bladder_3d$xi[1],
                          fit_bladder_3d$xi[4] - fit_bladder_3d$xi[3],
                          fit_bladder_3d$xi[6] - fit_bladder_3d$xi[5]), ncol = 1)

mslabels <- c("treat, mu", "treat, cif1", "treat, cif2")
rownames(xi_diff_3d) <- mslabels
colnames(xi_diff_3d) <- ""
xi_diff_3d


# Variance matrix for differences
sigma_diff_3d <- matrix(c(fit_bladder_3d$sigma[1,1] + fit_bladder_3d$sigma[2,2],
                          fit_bladder_3d$sigma[1,3] + fit_bladder_3d$sigma[1,5],
                          fit_bladder_3d$sigma[1,4] + fit_bladder_3d$sigma[1,6],

                          fit_bladder_3d$sigma[1,3] + fit_bladder_3d$sigma[1,5],
                          fit_bladder_3d$sigma[3,3] + fit_bladder_3d$sigma[4,4],
                          fit_bladder_3d$sigma[3,5] + fit_bladder_3d$sigma[4,6],

                          fit_bladder_3d$sigma[1,4] + fit_bladder_3d$sigma[1,6],
                          fit_bladder_3d$sigma[3,5] + fit_bladder_3d$sigma[4,6],
                          fit_bladder_3d$sigma[5,5] + fit_bladder_3d$sigma[6,6]

                          ),
                        ncol = 3, nrow = 3,
                        byrow = T)

rownames(sigma_diff_3d) <- colnames(sigma_diff_3d) <- mslabels
sigma_diff_3d



###----------------------- Compare - should match for some elements ---------------------------###

xi_diff_1d
xi_diff_2d
xi_diff_3d

sigma_diff_1d
sigma_diff_2d
sigma_diff_3d
