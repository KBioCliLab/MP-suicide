st=${1}
nm=${2}
mixer_p=./tools/
oper_f=./MiXeR.dt/

mkdir -p ${oper_f}/2.MiXeR.uni/${st}/rand/
echo $1
echo $2
echo ${st##*/}


python ${mixer_p}/mixer/precimed/mixer.py fit1 \
	--trait1-file ${oper_f}/1.sumstats/${st}/MiXeR.csv/${st##*/}.MiXer.qc.noMHCsumstats \
	--extract ${oper_f}/ref/rand.snp.set/MiXer.snps.${nm} \
	--bim-file ${oper_f}/ref/TGP.ref/1000G_EUR_Phase3_plink/1000G.EUR.QC.@.bim \
	--ld-file ${oper_f}/ref/TGP.ref/test.ld/1000G.EUR.QC.@.run4.ld \
	--lib ${mixer_p}/mixer/src/build/lib/libbgmg.so \
	--out ${oper_f}/2.MiXeR.uni/${st}/rand/${st##*/}.${nm}.fit \
	--threads 10

python ${mixer_p}/mixer/precimed/mixer.py test1 \
	--trait1-file ${oper_f}/1.sumstats/${st}/MiXeR.csv/${st##*/}.MiXer.qc.noMHCsumstats \
	--load-params-file ${oper_f}/2.MiXeR.uni/${st}/rand/${st##*/}.${nm}.fit.json \
	--bim-file ${oper_f}/ref/TGP.ref/1000G_EUR_Phase3_plink/1000G.EUR.QC.@.bim \
	--ld-file ${oper_f}/ref/TGP.ref/test.ld/1000G.EUR.QC.@.run4.ld \
	--lib ${mixer_p}/mixer/src/build/lib/libbgmg.so \
	--out ${oper_f}/2.MiXeR.uni/${st}/rand/${st##*/}.${nm}.test \
	--threads 10


