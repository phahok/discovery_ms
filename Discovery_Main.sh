#!/bin/bash
echo "==================================================="
echo " Servidor: `hostname` - `date` "
echo "==================================================="

#Variaveis globais
servidor=${HOSTNAME^^}
servidores=("sasserver.demo.sas.com") #Lista dos servidores do ambiente
dtExec="`date '+%d%m%Y_%H%M'`"

#Include de funcoes
dir_modulos=/home/sas/discovery_ms
dir_Entradas=$dir_modulos/Entradas
dir_pgmSAS=$dir_modulos/ProgramaSAS
logScript=$dir_modulos/log

#Criacao dos diretorios caso nao existam
diretorios=("$dir_modulos" "$dir_Entradas" "$dir_pgmSAS" "$logScript")

for dir in ${diretorios[@]}
do
	if test ! -d $dir 
	then
	 mkdir $dir
	 chmod 775 $dir
	fi
done

#Chamada do script de extracao dos dados dos servidores
source $dir_modulos/ExtracaoDados.sh

#Chamada do script que gera os programas SAS que constroem as tabelas necessarias para construcao do Discovery
source $dir_modulos/ProcessamentoDados.sh

#Chamada do script que gera o programa SAS que constroi o Discovery
source $dir_modulos/RelatorioDados.sh


#Execucao do programa que constroi o Discovery
/opt/sasinside/SASHome/SASFoundation/9.4/sas -sysin $dir_pgmSAS/Discovery.sas -log $logScript/Discovery.log

#Remove os arquivos temporarios
rm -f $dir_modulos/sashtml*.htm
rm -f $dir_modulos/*.lst
