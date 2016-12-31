GetOSMList = function(DDH, buffer){
  source("source/GetBufferOSM.R")
  library(treemap)
  
  osm = GetBufferOSM(DDH, buffer)
  if(!is.na(osm)){
    a= osm %>% .[,.(count=.N), by=.(feature,subfeature)] %>%  .[,.(feature, subfeature, count)]
    
    map = treemap(a, index = c("feature", "subfeature"), 
                  vSize = "count", vColor = "count",  type="value", palette = "Reds",
                  title = paste0("Nearby Resources of Parking Lot ", DDH, " (Buffer = ", buffer, "m)") 
    )
    
    
    return(osm)  
  }else{
    return(NULL)
  }
  
  
}

