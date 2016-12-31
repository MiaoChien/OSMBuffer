library(plyr)
GetFeaturePresent = function(DDH, buffer){
  feature_list = readRDS("data/feature_list.rds")
  source("source/GetBufferOSM.R")
  
  buffer %<>% as.numeric 
  a = GetBufferOSM(DDH, buffer)
  
  if(!is.null(a)){
    b1 = a[,.(count=.N), by=.(feature)] %>% as.data.frame 
    b1$feature = factor(b1$feature, levels=feature_list)
    
    feature_group = 
      ddply(b1, .(feature), summarise, count=sum(count), .drop=FALSE) %>% 
      data.table %>% .[,.(feature, present=count/sum(count))] %>% 
      .[order(match(feature, feature_list))]
    
    return(feature_group$present)  
  }else{
    return(rep(0, length(feature_list)))
  }
  
}