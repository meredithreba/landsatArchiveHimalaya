library(klaR)
A<- read.delim("/home/fas/seto/xl533/scratch60/grace6/urban_only_traj_round.txt",header = FALSE,sep = "", dec = ".")
nc=ncol(A)
nr=nrow(A)
B=A[2:nr,3:nc]
print("DONE READ IN")
######################Change cluster number accordingly
(cl <- kmodes(B, 10))
write.table(cl$cluster, file = "/home/fas/seto/xl533/scratch60/grace6/kmodes.txt",quote=FALSE,row.names=FALSE,col.names=FALSE)
######################Change cluster number (denominator) accordingly
sum(cl$withindiff/cl$size))/10

