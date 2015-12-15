#!/usr/bin/env Rscript
#-------------------------------------------------------------------------------
# Name:         VisCount
# Purpose:      Count compositional data visualisation tool
# Version:      1.0
# Licence:      MIT Licence
# Author:       Jack Simpson
# Email:        jack@jacksimpson.co
# Created:      2015-02-12
#-------------------------------------------------------------------------------

rm(list=ls())               # clear workspace variables
setwd("~/Research/VisCount/")
source("visualisation.R")   # load functions

packages.to.load <- c("ggvis", "dplyr")
install.load.packages(packages.to.load)

args = commandArgs(TRUE)
data.file.name <- args[1]

if (is.na(args[1])){
    data.file.name <- "data/lemurs.txt"
    data.file.sep <- "\t"
    csv.file.min.value <- 0.000001
    csv.file.factors <- c('Life.stage', 'Species', 'Individual')
    csv.file <- read.table(data.file.name, sep = data.file.sep, head = T, skip = 0, stringsAsFactors = F)
}else{
    if (args[2] == "tab"){
        data.file.sep <- "\t"
    }else if (args[2] == "comma"){
        data.file.sep <- ","
    }else{
        stopifnot(args[2] == "tab")
    }
    
    csv.file <- read.table(data.file.name, sep = data.file.sep, head = T, skip = 0, stringsAsFactors = F)
    csv.file.min.value <- as.numeric(args[3])
    csv.file.factors <- c(args[4:length(args)])
}

visualise.data(data = csv.file, all_factors = csv.file.factors, log_min_value = csv.file.min.value)