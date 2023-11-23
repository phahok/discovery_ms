#!/bin/bash
#echo "==================================================="
#echo " Servidor: `hostname` - `date` "
#echo "==================================================="

#Include de funcoes
saidaDiscovery=Discovery_teste.pdf
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
#echo "ods html path=rwiOut file=\"$2\" dom;" >> $1

#echo "data cabecalho;" >> $1
#echo "dt=datetime();" >> $1
#echo "format dt datetime18.;" >> $1
#echo "put dt;" >> $1
#echo "run;" >> $1

#echo "proc print data=cabecalho;" >> $1
#echo "run;" >> $1
echo "options nodate nonumber;" >> $1
echo "title;" >> $1
echo "ods escapechar=\"\~\";" >> $1
echo "footnote \"\~\{style \[font_size=10pt just=right color=cxffffff\] Provided to you by SAS 9.4 and ODS Absolute Layout features.\}\";" >> $1

echo "proc template;" >> $1
echo "define style Styles.Orionbackground;" >> $1
echo "parent=Styles.Printer;" >> $1
echo "style body \/" >> $1
#echo "background=cx01355b;" >> $1
echo "background=#87CEFA;" >> $1
echo "end;" >> $1
echo "run;" >> $1

echo "ods pdf file=\"$saidaDiscovery\" style=Styles.Orionbackground notoc;" >> $1

echo "data _null_ ;" >> $1
echo "dcl odsout trt();" >> $1
echo "trt.layout_absolute();" >> $1
echo "trt.region(y: '2in');" >> $1
echo "trt.format_text(data: 'Discovery', just: 'c'," >> $1
echo "style_attr: 'color=cxffffff just=center font_size=72pt');" >> $1
echo "trt.region(y: '3in', x: '3in');" >> $1
echo "trt.format_text(data: 'Managed Services'," >> $1
echo "style_attr:'color=cxffffff font_size=28pt');" >> $1
echo "trt.region(y: '5in');" >> $1
echo "trt.format_text(data: '$servidor'," >> $1
echo "just: 'c'," >> $1
echo "style_attr:'font_size=36pt color=cxffffff');" >> $1
echo "trt.region(y: '7in');" >> $1
echo "trt.format_text(data: '$dtExec'," >> $1
echo "just: "c"," >> $1
echo "style_attr:'font_size=20pt color=cxffffff');" >> $1
echo "trt.layout_end();" >> $1
echo "run;" >> $1

echo "ods pdf style=listing;" >> $1

        $relat_HDW  >> $1
        $relat_CPU >> $1
        $relat_MEM >> $1
        $relat_Rede >> $1
        $relat_Disco >> $1
        $relat_SASInstRep >> $1

#echo "ods html close;" >> $1
#echo "ods html;" >> $1

echo "ods pdf close;" >> $1

}

########################################################################################

#Include de funcoes

#Relatorio e Saida Discovery
documentoHTML "$pgm_Discovery" "$saidaDiscovery"
