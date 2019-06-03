#Project Convince
#4/15/2019
#Author: Samantha Gunnerson
#Contributers: Mack, Abbie

#loads all needed libraries for analysis
library("tidyverse")
library(lme4) # this is a package to conduct latent variable analysis. See http://lavaan.ugent.be/index.html
library(psych)
library(dplyr)
library(ggpubr)
library(ggsci)
library(tictoc) #easier timing faculty NOTE: needs dev tools package to be obtained
library(effects) #helps graphing
library(car) # this is a package to help test the assumptions
library(pscl) # this package is useful for evaluating model fit
library(sjstats) # this package is useful for evaluating model fit
library(interplot) #allows for graphical representation of interaction effects
library(optimx) #different fit methods to aid in convergence
library(MuMIn) #nice model tables
library(sjPlot) #possbile plotter for glmer (helps a bit)
library(stargazer)
library(jtools)

#Builds the condensed data set from the master data set
ori_convince <- read_csv("MASTER-convince-5-16-19.csv")
condense_convince <-subset(ori_convince, select = c(2:12,20:24,332,334,336:339,344,374,398,413:416,431:432,439,441))
#check documentation for specifics of what is included in the condensed set

#clean the data for appropriate NA cases
condense_convince$ind.response[condense_convince$ind.response=="#N/A"] <- NA
condense_convince$ind.response[condense_convince$ind.response=="0"] <- NA
condense_convince$ind.response[condense_convince$ind.response=="*"] <- NA

#general cleaning
condense_convince$group.id <- sub("_", "", condense_convince$group.id) #fixes group ids

#convert various data to factors
condense_convince$sex.id <-factor(condense_convince$sex.id)
condense_convince$urm.id <-factor(condense_convince$urm.id)
condense_convince$eop.id <-factor(condense_convince$eop.id)
condense_convince$fgn.id <-factor(condense_convince$fgn.id)

#correct referencing on above factors
condense_convince$sex.id <- relevel(condense_convince$sex.id, ref = "Male")
condense_convince$eop.id <- relevel(condense_convince$eop.id, ref = "non-EOP")
condense_convince$fgn.id <- relevel(condense_convince$fgn.id, ref = "non-FGN")

#save condensed as new data set
write.csv(condense_convince,file="condense-con.csv")
