#!/bin/bash
#echo "==================================================="
#echo " Servidor: `hostname` - `date` "
#echo "==================================================="

#Include de funcoes
saidaHTML=Discovery.html
pgm_Discovery=$dir_pgmSAS/Discovery.sas

##########################################################
# Montagem do relatorio
##########################################################

documentoHTML()
{

#Includes dos programas
local relat_HDW="echo %include \"$pgmHardware\";"
local relat_CPU="echo %include \"$pgmCPU\";"
local relat_MEM="echo %include \"$pgmMEM\";"
local relat_SASInstRep="echo %include \"$pgmSASInstRep\";"
local relat_Rede="echo %include \"$pgmRede\";"
local relat_Disco="echo %include \"$pgmDisco\";"

#Teste de saida HTML
echo "options symbolgen mprint mlogic;" > $1
echo "filename rwiOut \".\";" >> $1
echo "ods html close;" >> $1
echo "ods html path=rwiOut file=\"$2\" dom;" >> $1
	
	echo "data _null_;" >> $1
	echo "call symput("dt_atual", today());" >> $1
	echo "run;" >> $1
	echo "%put &dt_atual.;" >> $1

        $relat_HDW  >> $1
        $relat_CPU >> $1
        $relat_MEM >> $1
	$relat_Rede >> $1
	$relat_Disco >> $1
        $relat_SASInstRep >> $1

echo "ods html close;" >> $1
echo "ods html;" >> $1

}

########################################################################################

#Include de funcoes

#Relatorio e Saida Discovery
documentoHTML "$pgm_Discovery" "$saidaHTML"

