#!/usr/bin/env Rscript
#-------------------------------------------------------------------------------
# Name:         Int3n
# Purpose:      Data visualisation demo using ggvis and data from the HMP
# Version:      1.0
# Licence:      MIT Licence
# Author:       Jack Simpson
# Email:        jack@jacksimpson.co
# Created:      2015-02-12
#-------------------------------------------------------------------------------

rm(list=ls())                                   # clear workspace variables
args = commandArgs(TRUE)

packages <- c("ggvis", "dplyr")                 # packages to load

for (i in 1:length(packages)) {
    if (packages[i] %in% installed.packages()[,"Package"]){
        print(paste(packages[i], "is installed", sep=" "))
    }
    else{
        print(paste("Installing package:", packages[i], sep=" "))
        install.packages(packages[i])
    }
}

lapply(packages, library, character.only = T)   # load all packages

data.file.name <- args[1]  # "data/lemurs.txt"
args[2]

if (args[2] == "tab"){
    data.file.sep <- "\t"
}else if (args[2] == "comma"){
    data.file.sep <- ","
}
csv.file <- read.table(data.file.name, sep = data.file.sep, head = T, skip = 0, stringsAsFactors = F)
csv.file.min.value <- as.numeric(args[3])
print(csv.file.min.value)
print(class(csv.file.min.value))
csv.file.factors <- c(args[4:length(args)]) #c("Life.stage", "Species", "Individual")

source("visualisation.R")

visualisation <- visualise.data(data = csv.file, all_factors = csv.file.factors, log_min_value = csv.file.min.value)
visualisation