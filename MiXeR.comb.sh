st1=${1}
st2=${2}
g=${3}
uni=${4}

mixer_p=./tools/
oper_f=./MiXeR.dt/

mkdir -p ${oper_f}/2.MiXeR.uni/${st1}/sum.re
mkdir -p ${oper_f}/2.MiXeR.uni/${st2}/sum.re
mkdir -p ${oper_f}/3.MiXeR.bi/${g}/${st1##*/}_${st2##*/}/sum.re


echo $st1
echo $st2
echo ${st1##*/}
echo ${st2##*/}


# Uni

if [ ${uni} == u1 -o ${uni} == u3 ];then
	python ${mixer_p}/mixer/precimed/mixer_figures.py combine \
		--json ${oper_f}/2.MiXeR.uni/${st1}/rand/${st1##*/}.@.fit.json \
		--out ${oper_f}/2.MiXeR.uni/${st1}/all.${st1##*/}.fit

	python ${mixer_p}/mixer/precimed/mixer_figures.py combine \
		--json ${oper_f}/2.MiXeR.uni/${st1}/rand/${st1##*/}.@.test.json \
		--out ${oper_f}/2.MiXeR.uni/${st1}/all.${st1##*/}.test

	python ${mixer_p}/mixer/precimed/mixer_figures.py one \
		--json ${oper_f}/2.MiXeR.uni/${st1}/all.${st1##*/}.test.json \
		--out ${oper_f}/2.MiXeR.uni/${st1}/sum.re/${st1##*/}.sum.re --statistic mean std

fi

if [ ${uni} == u2 -o ${uni} == u3 ];then
	python ${mixer_p}/mixer/precimed/mixer_figures.py combine \
		--json ${oper_f}/2.MiXeR.uni/${st2}/rand/${st2##*/}.@.fit.json \
		--out ${oper_f}/2.MiXeR.uni/${st2}/all.${st2##*/}.fit

	python ${mixer_p}/mixer/precimed/mixer_figures.py combine \
		--json ${oper_f}/2.MiXeR.uni/${st2}/rand/${st2##*/}.@.test.json \
		--out ${oper_f}/2.MiXeR.uni/${st2}/all.${st2##*/}.test

	python ${mixer_p}/mixer/precimed/mixer_figures.py one \
		--json ${oper_f}/2.MiXeR.uni/${st2}/all.${st2##*/}.test.json \
		--out ${oper_f}/2.MiXeR.uni/${st2}/sum.re/${st2##*/}.sum.re --statistic mean std
fi


# Bi

python ${mixer_p}/mixer/precimed/mixer_figures.py combine \
	--json ${oper_f}/3.MiXeR.bi/${g}/${st1##*/}_${st2##*/}/rand/${st1##*/}_${st2##*/}.@.fit.json \
	--out ${oper_f}/3.MiXeR.bi/${g}/${st1##*/}_${st2##*/}/all.${st1##*/}_${st2##*/}.fit

python ${mixer_p}/mixer/precimed/mixer_figures.py combine \
        --json ${oper_f}/3.MiXeR.bi/${g}/${st1##*/}_${st2##*/}/rand/${st1##*/}_${st2##*/}.@.test.json \
        --out ${oper_f}/3.MiXeR.bi/${g}/${st1##*/}_${st2##*/}/all.${st1##*/}_${st2##*/}.test

python ${mixer_p}/mixer/precimed/mixer_figures.py two \
	--json-fit ${oper_f}/3.MiXeR.bi/${g}/${st1##*/}_${st2##*/}/all.${st1##*/}_${st2##*/}.fit.json \
	--json-test ${oper_f}/3.MiXeR.bi/${g}/${st1##*/}_${st2##*/}/all.${st1##*/}_${st2##*/}.test.json \
	--out ${oper_f}/3.MiXeR.bi/${g}/${st1##*/}_${st2##*/}/sum.re/${st1##*/}_${st2##*/}.sum.re --statistic mean std 
	




