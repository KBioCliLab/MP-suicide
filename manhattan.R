library(data.table)
library(ramwas)
library(dplyr)
library(ggplot2)
library(qqman)

com.args <- commandArgs(TRUE)
p1 <- com.args[1]
g <- com.args[2]

prep.Mant.f <- function(te.mat){
        sum.info <- read.table("./manh.sum.info",sep='\t',header=F)
        rownames(sum.info) <- sum.info[,1]
        te.mat <- cbind(te.mat,tot=sum.info[te.mat[,"CHR"],2])
        te.mat <- cbind(te.mat,BPcum=te.mat[,"BP"] + te.mat[,"tot"])
        rev.te.mat <- te.mat
        return (rev.te.mat)
}

read.f <- function(te.p){
	s.te.p <- strsplit(gsub(".*/","",te.p),"-")[[1]]
	comp <- gsub(".*/","",te.p)
	p.mat <- read.table(paste0(oper.dir,g,"/",te.p,"/",s.te.p[1],"_",s.te.p[2],"_conjfdr_1_all.csv"),sep=',',header=T)
	p.mat <- cbind(p.mat,snp=paste0(p.mat[,"chrnum"],":",p.mat[,"chrpos"]),tp=comp)
	colnames(p.mat)[c(4,5,8,11,12)] <- c("CHR","BP","P","SNP","tp")
	return (p.mat[,c("CHR","BP","P","SNP","tp")])
}

oper.dir <- "../4.pleiofdr/2.result/"

s.p1 <- unlist(strsplit(p1,","))
all.f <- NULL
for (i in 1:length(s.p1)){
	print (i)
	ea.re <- read.f(s.p1[i])
	all.f <- rbind(all.f,ea.re)
}

size.v <- c(0.8,3)
all.rev.f <- prep.Mant.f(all.f)
axisdf <- all.rev.f %>% group_by(CHR) %>% summarize(center=( max(BPcum) + min(BPcum) ) / 2 )
col.v <- c("#4197d8", "#f8c120", "#7c162c", "#778899", "#413496","#495226", "#d60b6f", "#e66519", "#d581b7", "#83d3ad", "#26755d")
names(col.v)[1:length(s.p1)] <- gsub(".*/","",s.p1)


sampl.n <- sample(1:nrow(all.rev.f),10000)
all.gp <- ggplot(all.rev.f, aes(x=BPcum, y=-log10(P))) +
	geom_point(aes(color=as.factor(as.character(tp))), alpha=0.5, size=size.v[1]) +
	scale_color_manual(values = col.v[unique(all.rev.f[,"tp"])]) +
	scale_x_continuous(label = axisdf$CHR, breaks = axisdf$center) +
	theme_bw()


fdr.0.05 <- -log10(0.05)
fdr.0.1 <- -log10(0.1)
fdr.cut <- c(fdr.0.05,fdr.0.1)

t.gp <- all.gp + geom_abline(aes(slope=0, intercept=fdr.cut[1]), color = '#de0000', linetype= "dashed", size=1)
 

png(paste0("./",g,".",p1,".manh.png"),width=2500,height=1250,res=300)
print (t.gp)
dev.off()


