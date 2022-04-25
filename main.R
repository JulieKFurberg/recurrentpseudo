#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#
#------------ recurrentpseudo R package  -------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------------#

#=================================================================================================#
# Required packages                                                                               #
#=================================================================================================#

library("devtools")
library("roxygen2")


setwd("C:/Users/jukf/OneDrive - Novo Nordisk/Private/ErhvervsPhd/Article 3 - R package/r_git")
#create("recurrentpseudo")

setwd("./recurrentpseudo")
document()

setwd("..")
install("recurrentpseudo")


?pseudo.twodim
?pseudo.onedim
?pseudo.geefit



# https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
# https://kbroman.org/github_tutorial/pages/routine.html
# https://support.rstudio.com/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN



#=================================================================================================#
# Checking examples                                                                               #
#=================================================================================================#



# Bare essentials!
require(survival)
require(dplyr)

# Make a three level status variable
bladder1$status3 <- ifelse(bladder1$status %in% c(2, 3), 2, bladder1$status)

# Add one extra day for the two patients with start=stop=0
bladder1[bladder1$stop <= bladder1$start, ]$stop <- bladder1[bladder1$stop <= bladder1$start, ]$start + 1

## Restrict the data to placebo and thiotepa 
bladdersub <- subset(bladder1, treatment %in% c("placebo", "thiotepa"))

# Make treatment variable two-level factor
bladdersub$Z <- as.factor(ifelse(bladdersub$treatment == "placebo", 0, 1))
levels(bladdersub$Z) <- c("placebo", "thiotepa")


head(bladdersub)



#### ----------------------------- #### 

# Computation of pseudo-observations 
pseudo_bladder <- pseudo.twodim(tstart = bladdersub$start,
                                tstop = bladdersub$stop, 
                                status = bladdersub$status3, 
                                id = bladdersub$id, 
                                tk = c(20, 30, 40), 
                                data = bladdersub)

# Data in wide format
head(pseudo_bladder$outdata)

# Data in long format
head(pseudo_bladder$outdata_long)


#### ----------------------------- #### 

fit_bladder <- pseudo.geefit(pseudodata = pseudo_bladder, 
                             covar_names = c("Z"))
fit_bladder



# Treatment differences 
xi_diff <- as.matrix(c(fit_bladder$xi[2] - fit_bladder$xi[1], 
                       fit_bladder$xi[4] - fit_bladder$xi[3]), ncol = 1)

mslabels <- c("treat, mu", "treat, surv")
rownames(xi_diff) <- mslabels
colnames(xi_diff) <- ""

xi_diff


# Variance matrix for differences
sigma_diff <- matrix(c(fit_bladder$sigma[1,1] + fit_bladder$sigma[2,2], 
                       fit_bladder$sigma[1,3] + fit_bladder$sigma[2,4], 
                       fit_bladder$sigma[1,3] + fit_bladder$sigma[2,4],
                       fit_bladder$sigma[3,3] + fit_bladder$sigma[4,4]), 
                     ncol = 2, nrow = 2, 
                     byrow = T) 

rownames(sigma_diff) <- colnames(sigma_diff) <- mslabels

sigma_diff





