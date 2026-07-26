oper_f=./MiXeR.dt/1.sumstats

s1=${1##*/}
s2=${2##*/}

f_1=${oper_f}/${1}/ldsc/${s1}.ldsc.mat.sumstats.gz
f_2=${oper_f}/${2}/ldsc/${s2}.ldsc.mat.sumstats.gz
out_f=${3}

ldsctool=./tools/ldsc/
python ${ldsctool}/ldsc.py --rg ${f_1},${f_2} \
        --ref-ld-chr ${ldsctool}/ldsc.dt/eur_w_ld_chr/ \
        --w-ld-chr ${ldsctool}/ldsc.dt/eur_w_ld_chr/ \
        --out ./${out_f}/${out_f}.re


