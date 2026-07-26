library(LAVA)

com.args <- commandArgs(TRUE)
p1 <- com.args[1]
p2 <- com.args[2]
out.p <- com.args[3]

input.p <- paste0("1.data/2.sample.info/",p1,"-",p2,".txt")
sam.ov <- paste0("1.data/3.sam.over/",p1,"-",p2,".samp.ov.txt")

loci <- read.loci("1.data/LAVA/support_data/blocks_s2500_m25_f1_w200.GRCh37_hg19.locfile")
input.dt <- process.input(input.info.file=input.p,
			  sample.overlap.file=sam.ov,
			  ref.prefix="../ref/TGP.ref/09.08.2025.EUR.ref/g1000_eur"
			  )
uni.nm <- NULL
f.re <- NULL
for (i in 1:length(loci[,1])){
	print (i)
	ea.loc = process.locus(loci[i,], input.dt)
	if (!length(ea.loc))    next
	uni.re <- run.univ(ea.loc)
	if (nrow(rbind(uni.re)) < 2)    next
	if (!length(uni.nm)){
		uni.nm <- uni.re[,1]
	}
	bi.re <- run.bivar(ea.loc)
	f.re <- rbind(f.re,c(loci[i,],uni.re[,"p"],bi.re[,c("rho","r2","p")]))
}

colnames(f.re)[5:6] <- uni.nm

out.p <- paste0("2.result/",out.p,".lava.re")
save(f.re,file=out.p)


