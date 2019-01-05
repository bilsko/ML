library(PlayerRatings)
afl <- aflodds[,c(2,3,4,7)]
robj <- fide(afl)
robj
robj <- fide(afl[afl$Week==1,])
for(i in 2:max(afl$Week)) robj <- fide(afl[afl$Week==i,], robj$ratings)
robj

