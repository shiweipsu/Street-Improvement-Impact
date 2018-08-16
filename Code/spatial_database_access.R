if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load( RPostgres, sf, dbplyr, dplyr)

pw <- scan("batteries.pgpss", what = "")
user <- "shiwei"
host <- "pgsql102.rc.pdx.edu"
dbname <- "bike_lanes"

con <- dbConnect(Postgres(), dbname = dbname, host = host, user = user, password = pw, port = 5433)

# read file
indy_corridor <- st_read(dsn=con, query= "select buildstart, geom as geom from indy_corridors;")

# write file
dbWriteTable(conn = con, "minn_sales_tax", value = minn_sale, overwrite = TRUE, row.names = FALSE)
st_write(minn_lehd, dsn = con, overwrite = TRUE, "minneapolis_lehd", geom_column = "geometry")

dbGetQuery()