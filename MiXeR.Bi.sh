st1=${1}
st2=${2}
g=${3}
nm=${4}

mixer_p=./tools/
oper_f=./MiXeR.dt/

mkdir -p ${oper_f}/3.MiXeR.bi/${g}/${st1##*/}_${st2##*/}/rand/

echo $st1
echo $st2
echo ${st1##*/}
echo ${st2##*/}
echo $nm


python ${mixer_p}/mixer/precimed/mixer.py fit2 \
	--trait1-file ${oper_f}/1.sumstats/${st1}/MiXeR.csv/${st1##*/}.MiXer.qc.noMHCsumstats \
	--trait2-file ${oper_f}/1.sumstats/${st2}/MiXeR.csv/${st2##*/}.MiXer.qc.noMHCsumstats \
	--trait1-params-file ${oper_f}/2.MiXeR.uni/${st1}/rand/${st1##*/}.${nm}.fit.json \
	--trait2-params-file ${oper_f}/2.MiXeR.uni/${st2}/rand/${st2##*/}.${nm}.fit.json \
	--out ${oper_f}/3.MiXeR.bi/${g}/${st1##*/}_${st2##*/}/rand/${st1##*/}_${st2##*/}.${nm}.fit \
	--bim-file ${oper_f}/ref/TGP.ref/1000G_EUR_Phase3_plink/1000G.EUR.QC.@.bim \
	--ld-file ${oper_f}/ref/TGP.ref/test.ld/1000G.EUR.QC.@.run4.ld \
	--extract ${oper_f}/ref/rand.snp.set/MiXer.snps.${nm} \
	--lib ${mixer_p}/mixer/src/build/lib/libbgmg.so \
	--threads 12

python ${mixer_p}/mixer/precimed/mixer.py test2 \
	--trait1-file ${oper_f}/1.sumstats/${st1}/MiXeR.csv/${st1##*/}.MiXer.qc.noMHCsumstats \
    --trait2-file ${oper_f}/1.sumstats/${st2}/MiXeR.csv/${st2##*/}.MiXer.qc.noMHCsumstats \
    --load-params-file ${oper_f}/3.MiXeR.bi/${g}/${st1##*/}_${st2##*/}/rand/${st1##*/}_${st2##*/}.${nm}.fit.json \
    --out ${oper_f}/3.MiXeR.bi/${g}/${st1##*/}_${st2##*/}/rand/${st1##*/}_${st2##*/}.${nm}.test \
    --bim-file ${oper_f}/ref/TGP.ref/1000G_EUR_Phase3_plink/1000G.EUR.QC.@.bim \
    --ld-file ${oper_f}/ref/TGP.ref/test.ld/1000G.EUR.QC.@.run4.ld \
    --lib ${mixer_p}/mixer/src/build/lib/libbgmg.so \
    --threads 12

