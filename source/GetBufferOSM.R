GetBufferOSM =  function(id, buffer){
  library(RPostgreSQL)
  library(magrittr)
  library(data.table)
  
  buffer %<>% as.numeric
  query = paste0(
  "SELECT b.id, name, feature, subfeature FROM 
  ( SELECT id, ST_BUFFER(geom, ", buffer,") AS geom FROM parking) a,
    osm_point b
    WHERE ST_INTERSECTS(a.geom, b.geom)
    AND a.id = '",id,"';"
  ) %>% gsub("\\n", replacement=" ",.)
  
  drv = dbDriver("PostgreSQL")
  conn = dbConnect(drv, user='postgres', password='******', 
                   host='localhost', port='5432', dbname='*****')
  
  
  res = dbGetQuery(conn, query)
  dbDisconnect(conn)
  
  res = data.table(res)
  
  if(nrow(res)!=0){
    return(res)    
  }else{
    return(NULL)
  }
  
}
