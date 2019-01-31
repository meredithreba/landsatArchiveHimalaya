#!/bin/bash

#SBATCH --mail-type=ALL
#SBATCH --mail-user=baohui.chai@yale.edu
#SBATCH --job-name=144040_split_to14
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=day, pi_seto
#SBATCH --time=24:00:00
#SBATCH --mem-per-cpu=100
#SBATCH -o Outfiles/144040_split_to14_%A_%a.out

module load Apps/R/3.3.2-generic
module load Rpkgs/RASTER
module load Rpkgs/RGDAL
module load Rpkgs/RGEOS
module load Rpkgs/XML

R --vanilla --no-readline -q  << 'EOF'

file <- "/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/144040.txt"
con <- file(file,"r")
count1 <- 0
count2 <- 0
count3 <- 0
count4 <- 0
count5 <- 0
count6 <- 0
count7 <- 0
count8 <- 0
count9 <- 0
count10 <- 0
count11 <- 0
count12 <- 0
count13 <- 0
count14 <- 0
while ( TRUE ) {
  this_line <- readLines(con,n=1)
  if ( length(line) == 0 ) {
    break
  } else {
    x <- strsplit(this_line,' ')[[1]][2]
    y <- strsplit(this_line,' ')[[1]][3]
    if((strsplit(this_line,' ')[[1]][4]=="1")){
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_1.txt",sep="\n",append=TRUE)
      count1 <- count1+1
      print(paste("count1=",count1, sep=''))
    } else if ((strsplit(this_line,' ')[[1]][4]=="2")){
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_2.txt",sep="\n",append=TRUE)
      count2 <- count2+1
      print(paste("count2=",count2, sep=''))    
    } else if ((strsplit(this_line,' ')[[1]][4]=="3")){
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_3.txt",sep="\n",append=TRUE)
      count3 <- count3+1
      print(paste("count3=",count3, sep='')) 
    } else if ((strsplit(this_line,' ')[[1]][4]=="4")){
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_4.txt",sep="\n",append=TRUE)
      count4 <- count4+1
      print(paste("count4=",count4, sep='')) 
    } else if ((strsplit(this_line,' ')[[1]][4]=="5")){
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_5.txt",sep="\n",append=TRUE)
      count5 <- count5+1
      print(paste("count5=",count5, sep='')) 
    } else if ((strsplit(this_line,' ')[[1]][4]=="6")){
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_6.txt",sep="\n",append=TRUE)
      count6 <- count6+1
      print(paste("count6=",count6, sep='')) 
    } else if ((strsplit(this_line,' ')[[1]][4]=="7")){
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_7.txt",sep="\n",append=TRUE)
      count7 <- count7+1
      print(paste("count7=",count7, sep='')) 
    } else if ((strsplit(this_line,' ')[[1]][4]=="8")){
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_8.txt",sep="\n",append=TRUE)
      count8 <- count8+1
      print(paste("count8=",count8, sep='')) 
    } else if ((strsplit(this_line,' ')[[1]][4]=="9")){
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_9.txt",sep="\n",append=TRUE)
      count9 <- count9+1
      print(paste("count9=",count9, sep='')) 
    } else if ((strsplit(this_line,' ')[[1]][4]=="10")){
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_10.txt",sep="\n",append=TRUE)
      count10 <- count10+1
      print(paste("count10=",count10, sep='')) 
    } else if ((strsplit(this_line,' ')[[1]][4]=="11")){
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_11.txt",sep="\n",append=TRUE)
      count11 <- count11+1
      print(paste("count11=",count11, sep='')) 
    } else if ((strsplit(this_line,' ')[[1]][4]=="12")){
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_12.txt",sep="\n",append=TRUE)
      count12 <- count12+1
      print(paste("count12=",count12, sep='')) 
    } else if ((strsplit(this_line,' ')[[1]][4]=="13")){
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_13.txt",sep="\n",append=TRUE)
      count13 <- count13+1
      print(paste("count13=",count13, sep='')) 
    } else {
      cat(paste(x, y, sep=' '),file="/home/fas/seto/bc643/scratch60/grace1/decompose10_k14/split_clusters_1to14/144040_14.txt",sep="\n",append=TRUE)
      count14 <- count14+1
      print(paste("count14=",count14, sep='')) 
    } 
    
  }
}
close(con)
EOF