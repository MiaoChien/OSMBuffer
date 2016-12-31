library(plyr)
GetSubFeaturePresent = function(DDH, buffer){
  subfeature_list = readRDS("data/subfeature_list.rds")
  source("source/GetBufferOSM.R")
  
  buffer %<>% as.numeric 
  a = GetBufferOSM(DDH, buffer)
  
  if(!is.null(a)){
    b2 = a[,.(count=.N), by=.(subfeature)] %>% as.data.frame
    b2$subfeature = factor(b2$subfeature, levels=subfeature_list)
    
    
    subfeature_group =
      ddply(b2, .(subfeature), summarise, count=sum(count), .drop=FALSE) %>% 
      data.table %>% .[,.(subfeature, present=count/sum(count))] %>% 
      .[order(match(subfeature, subfeature_list))]
    
    return(subfeature_group$present)  
  }else{
    return(rep(0, length(subfeature_list)))
  }
  
  
}