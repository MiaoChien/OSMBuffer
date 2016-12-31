setwd("~/Dropbox/GIStec/R_Folder/OSMBuffer")

library(magrittr)
library(data.table)


PL = read.csv("~/Dropbox/GIStec/R_Folder/OSMBuffer/data/PL.csv", header=T, stringsAsFactors = F) %>% data.table

DDH = PL$id


source("source/GetBufferOSM.R")
# DDHBufferlist=list()
# for(i in 1:length(DDH)){
#   DDHBufferlist[[DDH[i]]] = GetBufferOSM(DDH[i], 500)
# }
# 
# saveRDS(DDHBufferlist, "output/DDHBuffer500.rds")

# filename="DDHTPC063"
# res = GetBufferOSM(filename, 500)
# write.csv(res, paste0("output/special/", filename, ".csv"))


options(warn=-1)

for(i in 1:length(DDH)){
  filename=DDH[i]
  png(paste0(filename = "output/png/", filename, ".png"))
  GetOSMList(DDH[i], 300)
  dev.off()
}


#=================# K Means #=================# 

feature_list = readRDS("data/feature_list.rds")
subfeature_list = readRDS("data/subfeature_list.rds")

# feature_p = 
#   lapply(DDH, GetFeaturePresent, buffer) %>% 
#   do.call(rbind,.) %>% data.frame
# 
# colnames(feature_p)=feature_list
# row.names(feature_p)=DDH
# 
# saveRDS(feature_p, "output/kmeans/feature_p.rds")
feature_p = readRDS("output/kmeans/feature_p.rds")

# subfeature_p =
#   lapply(DDH, GetSubFeaturePresent, buffer) %>%
#   do.call(rbind,.) %>% data.frame
# 
# colnames(subfeature_p)=subfeature_list
# row.names(subfeature_p)=DDH
# 
# saveRDS(subfeature_p, "output/kmeans/subfeature_p.rds")
subfeature_p = readRDS("output/kmeans/subfeature_p.rds")

(feature.cl = kmeans(feature_p, 4))
feature.cl$cluster %>% data.frame
plot(feature_p, col=cl$cluster)


(subfeature.cl = kmeans(subfeature_p, 4))
subfeature.cl$cluster %>% data.frame
plot(subfeature_p, col=cl$cluster)

