#!/bin/bash
#echo "==================================================="
#echo " Servidor: `hostname` - `date` "
#echo "==================================================="

#Delimitador definido nos arquivos de entrada
delimitadorSAS="#"

#Informacoesgerais
nmTabelaHDW=infoCPU
pgmHardware=$dir_pgmSAS/tab_infoServidor.sas

#Informacoes de CPU
nmTabelaCPU=infoCPU
pgmCPU=$dir_pgmSAS/tab_infoCPU.sas

#Informacoes de Memoria
nmTabelaMEM=infoMemoria
pgmMEM=$dir_pgmSAS/tab_infoMEM.sas

#Informacoes de Memoria
nmTabelaRede=infoRede
pgmRede=$dir_pgmSAS/tab_infoRede.sas

#Informacoes de Disco
nmTabelaDisco=infoDisco
pgmDisco=$dir_pgmSAS/tab_infoDisco.sas

# SAS Install Report
pgmSASInstRep=$dir_pgmSAS/sasinstallreport.sas

##########################################################
# Processamento dos dados
##########################################################


tabelasSAS()
{
#Criacao das tabelas
echo "data $2;" > $3
echo "infile datalines delimiter='$delimitadorSAS' missover dsd;" >> $3
echo "length descricao \$100 informacoes \$255.;" >> $3
echo "input descricao \$ informacoes \$;" >> $3
echo "datalines;" >> $3

        cat $1 >> $3

echo ";" >> $3
echo "run;" >> $3

echo "proc print data=$2 noobs;" >> $3
echo "title \"$4 - $servidor\";" >> $3
echo "run;" >> $3
}

######################################################################################

#Chamada da funcao que constroi os arquivos de dados extraidos do servidor
coletaInfoHardware
coletaInfoRedes
coletaInfoFilesystem

#Chamada da funcao TabelaSAS: Arqv de entrada, Nome da Tabela, Arqv de Saida e Descricao do item
tabelasSAS "$entrdHDW" "$nmTabelaHDW" "$pgmHardware" "Informacoes do Servidor"
tabelasSAS "$entrdCPU" "$nmTabelaCPU" "$pgmCPU" "Informacoes da CPU"
tabelasSAS "$entrdMEM" "$nmTabelaMEM" "$pgmMEM" "Informacoes da Memoria"
tabelasSAS "$entrdRede" "$nmTabelaRede" "$pgmRede" "Informacoes da Rede"
tabelasSAS "$entrdFilesys" "$nmTabelaDisco" "$pgmDisco" "Informacoes do Disco"
