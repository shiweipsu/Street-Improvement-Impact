options(scipen = 999) # Supress scientific notation so we can see census geocodes
library(plyr); library(dplyr)
library(downloader) # downloads and then runs the source() function on scripts from github
library(R.utils) # load the R.utils package (counts the number of lines in a file quickly)


# Program start ----------------------------------------------------------------
tf <- tempfile(); td <- tempdir() # Create a temporary file and a temporary directory
# Load the download.cache and related functions
# to prevent re-downloading of files once they've been downloaded.
source_url(
  "https://raw.github.com/ajdamico/asdfree/master/Download%20Cache/download%20cache.R",
  prompt = FALSE,
  echo = FALSE
)


# All files except federal ------------------------------------------------
# Download all except federal categorey, JT04/05. Federal categories are only available from 2010-2014

# Loop through and download S000, each type and each year
# S000 references all workforce segments
years.to.download <- c(2002:2014)
JT.to.download <- c(0:3)
# JT00 references all job types
# JT01 references all primary jobs, jobs individual make most of the money, equals to total working population
# JT02 references all private jobs
# JT03 refernces primary private jobs

for(JT in JT.to.download) {
  for(year in years.to.download){
  cat("now loading", JT, "...", '\n\r')
  download_cached(
    url = paste0("http://lehd.ces.census.gov/data/lodes/LODES7/or/wac/or_wac_S000_JT0", JT,"_",year,".csv.gz"),
    destfile = tf,
    mode = 'wb'
  )
  # Create a variable to store the wac file for each year
  assign(paste0("wac.S000.JT0", JT,".",year), read.table(gzfile(tf), header = TRUE, sep = ",",
                                                    colClasses = "numeric", stringsAsFactors = FALSE))
  }
  
  # Remove the temporary file from the local disk
  file.remove(tf)
  # And free up RAM
  gc()
}

# Loop through and download SA category, each type and each year
years.to.download <- c(2002:2014)
JT.to.download <- c(0:3)
S.to.download <- c("SA","SE","SI")
s.to.download <- c(1:3)
# SA01 references number of jobs for workers 29 and younger
# SA02 references number of jobs for workers 30-54
# SA03 references number of jobs for workers 55 and above
# SE01 references number of jobs with earning $1250 or less
# SE02 references number of jobs with earning $1251-$3333
# SE03 references number of jobs with earning $3334 above
# SI01 references number of jobs in Goods Producing sector
# SI02 references number of jobs in Trade & Transportation sector
# SI03 references number of jobs in all other sectors

for(S in S.to.download){
  for(s in s.to.download){
    for(JT in JT.to.download) {
      for(year in years.to.download){
      cat("now loading", JT, "...", '\n\r')
      download_cached(
        url = paste0("http://lehd.ces.census.gov/data/lodes/LODES7/or/wac/or_wac_",S,"0",s,"_JT0", JT,"_",year,".csv.gz"),
        destfile = tf,
        mode = 'wb'
      )
      # Create a variable to store the wac file for each year
      assign(paste0("wac.",S,"0",s,".JT0", JT,".",year), read.table(gzfile(tf), header = TRUE, sep = ",",
                                                      colClasses = "numeric", stringsAsFactors = FALSE))
      }
  }
}
  # Remove the temporary file from the local disk
  file.remove(tf)
  # And free up RAM
  gc()
}


# For Federal tables ------------------------------------------------------
years.to.download <- c(2010:2014)
JT.to.download <- c(4:5)
# JT00 references all job types
# JT01 references all primary jobs, jobs individual make most of the money, equals to total working population
# JT02 references all private jobs
# JT03 refernces primary private jobs

for(JT in JT.to.download) {
  for(year in years.to.download){
    cat("now loading", JT, "...", '\n\r')
    download_cached(
      url = paste0("http://lehd.ces.census.gov/data/lodes/LODES7/or/wac/or_wac_S000_JT0", JT,"_",year,".csv.gz"),
      destfile = tf,
      mode = 'wb'
    )
    # Create a variable to store the wac file for each year
    assign(paste0("wac.S000.JT0", JT,".",year), read.table(gzfile(tf), header = TRUE, sep = ",",
                                                           colClasses = "numeric", stringsAsFactors = FALSE))
  }
  
  # Remove the temporary file from the local disk
  file.remove(tf)
  # And free up RAM
  gc()
}

# Loop through and download SA category, each type and each year
years.to.download <- c(2010:2014)
JT.to.download <- c(4:5)
S.to.download <- c("SA","SE","SI")
s.to.download <- c(1:3)

for(S in S.to.download){
  for(s in s.to.download){
    for(JT in JT.to.download) {
      for(year in years.to.download){
        cat("now loading", JT, "...", '\n\r')
        download_cached(
          url = paste0("http://lehd.ces.census.gov/data/lodes/LODES7/or/wac/or_wac_",S,"0",s,"_JT0", JT,"_",year,".csv.gz"),
          destfile = tf,
          mode = 'wb'
        )
        # Create a variable to store the wac file for each year
        assign(paste0("wac.",S,"0",s,".JT0", JT,".",year), read.table(gzfile(tf), header = TRUE, sep = ",",
                                                                      colClasses = "numeric", stringsAsFactors = FALSE))
      }
    }
  }
  # Remove the temporary file from the local disk
  file.remove(tf)
  # And free up RAM
  gc()
}


# Save data ---------------------------------------------------------------
dfs<-Filter(function(x) is.data.frame(get(x)) , ls()) # get a vector of all of data.frame names
save(list=dfs, file="wac.RData")
