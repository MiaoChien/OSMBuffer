# K means clustering
library(magrittr)
library(dplyr)
library(data.table)

PL = read.csv("~/Dropbox/GIStec/R_Folder/OSMBuffer/data/PL.csv", header=T, stringsAsFactors = F) %>% data.table
DDH = PL$id
feature_list = readRDS("data/feature_list.rds")
subfeature_list = readRDS("data/subfeature_list.rds")

# source("source/GetBufferOSM.R")
# db=lapply(DDH, GetBufferOSM, 300) %>% do.call(rbind,.)

# feature_list = db$feature %>% unique
# subfeature_list=db$subfeature %>% unique
# 
# saveRDS(feature_list,file = "data/feature_list.rds")
# saveRDS(subfeature_list,file="data/subfeature_list.rds")

source("source/GetFeaturePresent.R")
buffer = 300

feature_p = 
  lapply(DDH, GetFeaturePresent, buffer) %>% 
  do.call(cbind,.)

row.names(feature_p)=feature_list
col.names(feature_p)=DDH

subfeature_p = 
  lapply(DDH, GetSubFeaturePresent, buffer) %>% 
  do.call(cbind,.)


