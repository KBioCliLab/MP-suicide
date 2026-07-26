
com.args <- commandArgs(TRUE)
st1 <- com.args[1]
st2 <- com.args[2]

print (st1)
print (st2)

oper.path <- "./MiXeR.dt/"
uni.mixer.p <- paste0(oper.path,"/2.MiXeR.uni/",st1,"/sum.re/",gsub(".*/","",st1),".sum.re.csv")

uni.mixer.re <- read.csv(uni.mixer.p,sep='\t')
uni.mixer.re[,c("h2..mean.","h2..std.","nc.p9..mean.","nc.p9..std.","AIC","BIC")]


g <- gsub("/.*","",st1)
s.s1 <- gsub(".*/","",st1)
s.s2 <- gsub(".*/","",st2)

bi.mixer.p <- paste0(oper.path,"3.MiXeR.bi/",g,"/",s.s2,"_",s.s1,"/sum.re/",s.s2,"_",s.s1,".sum.re.csv")
bi.mixer.re <- read.csv(bi.mixer.p,sep='\t')

bi.re <- bi.mixer.re[1,c("dice..mean.","dice..std.","fraction_concordant_within_shared..mean.",
			       "fraction_concordant_within_shared..std.","best_vs_min_AIC","best_vs_max_AIC")]

write.table(bi.re,paste0(st1,"_",st2,"bi.MiXeR.re"),sep='\t',quote=F,row.names=F)


