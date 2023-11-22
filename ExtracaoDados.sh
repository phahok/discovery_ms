#!/bin/bash
#echo "==================================================="
#echo " Servidor: `hostname` - `date` "
#echo "==================================================="

#Arquivo de saida com as informacoes gerais
entrdHDW=$dir_Entradas/tab_infoServidor.txt

#Arquivo de saida com as informacoes de CPU
entrdCPU=$dir_Entradas/tab_infoCPU.txt

#Arquivo de saida com as informacoes de Memoria
entrdMEM=$dir_Entradas/tab_infoMemoria.txt

#Arquivo de saida com as informacoes de Memoria
entrdRede=$dir_Entradas/tab_infoRede.txt

#Arquivo de saida com as informacoes de Memoria
entrdFilesys=$dir_Entradas/tab_filesystem.txt
##########################################################
# Coleta de dados
##########################################################

#Para comandos cuja saida contem mais de uma linha, é preciso adicionar no fim do comando a expressão abaixo:
#| awk '{print "<br>",$0}'
#Assim o formato de saida sera mais amigavel


coletaInfoHardware()
{

#Coleta de informacoes gerais do hardware:
hostname -f | awk '{ sub(/^[ \t]+/, ""); print }' | awk '{print "Hostname#",$0}' > $dir_Entradas/tab_nomeHost.txt
hostnamectl | grep -i chassis | awk -F: '{print $2}' | awk '{ sub(/^[ \t]+/, ""); print }' | awk '{print "Tipo de Servidor#",$0}' > $dir_Entradas/tab_tpserver.txt
hostnamectl | grep -i Virtualization | awk -F: '{print $2}'| awk '{ sub(/^[ \t]+/, ""); print }' | awk '{print "Virtualizacao#",$0}' > $dir_Entradas/tab_tpvirt.txt
cat /etc/redhat-release | awk '{ sub(/^[ \t]+/, ""); print }' | awk '{print "Sistema Operacional#",$0}' > $dir_Entradas/tab_OS_server.txt
hostnamectl | head -n 9 | tail -1f | awk -F: '{print $2}' | awk '{ sub(/^[ \t]+/, ""); print }' | awk '{print "Versao do Kernel#",$0}' > $dir_Entradas/tab_infoKernel.txt
timedatectl | awk '{ sub(/^[ \t]+/, ""); print }' | awk '{print "Configuracoes de Horario#",$0}' > $dir_Entradas/tab_infoTimedate.txt

#Coleta de informacoes de CPU:
cat /proc/cpuinfo | grep "model name" | awk -F: {'print $2'} | tail -1 | awk '{ sub(/^[ \t]+/, ""); print }' | awk '{print "Modelo da CPU#",$0}'  > $dir_Entradas/tab_modelo_CPU.txt
lscpu | head -n 6 | tail -1f | awk -F: '{print $2}' | awk '{ sub(/^[ \t]+/, ""); print }' | awk '{print "Total de Threads#",$0}' > $dir_Entradas/tab_qtdeThreads.txt
lscpu | head -n 7 | tail -1f | awk -F: '{print $2}' | awk '{ sub(/^[ \t]+/, ""); print }' | awk '{print "Total de VCores#",$0}' > $dir_Entradas/tab_qtdeVCore.txt
lscpu | head -n 4 | tail -1f | awk -F: '{print $2}' | awk '{ sub(/^[ \t]+/, ""); print }' | awk '{print "Total de Processadores#",$0}' > $dir_Entradas/tab_qtdeProcessadores.txt

#Coleta de informacoes de Memoria:
free -h | grep "Mem" | awk {'print $2'} | awk '{ sub(/^[ \t]+/, ""); print }' | awk '{print "Total de Memoria RAM#",$0}' > $dir_Entradas/tab_qtdeRAM.txt
free -h | grep "Swap" | awk {'print $2'} | awk '{ sub(/^[ \t]+/, ""); print }' | awk '{print "Total de SWAP#",$0}' > $dir_Entradas/tab_qtdeSWAP.txt

#Consolidacao dos dados de entrada
cat $dir_Entradas/tab_nomeHost.txt $dir_Entradas/tab_tpserver.txt $dir_Entradas/tab_tpvirt.txt $dir_Entradas/tab_OS_server.txt $dir_Entradas/tab_infoKernel.txt > $entrdHDW
cat $dir_Entradas/tab_modelo_CPU.txt $dir_Entradas/tab_qtdeThreads.txt $dir_Entradas/tab_qtdeVCore.txt $dir_Entradas/tab_qtdeProcessadores.txt > $entrdCPU
cat $dir_Entradas/tab_qtdeRAM.txt $dir_Entradas/tab_qtdeSWAP.txt  > $entrdMEM


#Adicione abaixo outras eventuais coletas

}

coletaInfoRedes()
{
#Coleta de informacoes de Redes:
#DNS
cat /etc/resolv.conf | tr '# #' ' ' | awk '{print "DNS#",$0}' > $dir_Entradas/tab_infoDNS.txt

#Placa de rede
ifconfig | egrep "^[a-z]|inet"| awk '{print "Placa de Rede#",$0}' > $dir_Entradas/tab_infoPlaca.txt

#Status do Firewall
systemctl status firewalld | grep -i "Active:" | awk '{print "Status do Firewall#",$0}' > $dir_Entradas/tab_infoFirewall.txt

cat $dir_Entradas/tab_infoDNS.txt $dir_Entradas/tab_infoPlaca.txt $dir_Entradas/tab_infoFirewall.txt > $entrdRede
#Dados a serem processados na saida

}

coletaInfoFilesystem()
{
#Coleta de informacoes do filesystem:
df -h --output=source,fstype,size,used,avail,pcent,target | awk '{print "Disco#",$0}' > $entrdFilesys

#Adicione abaixo outras eventuais coletas

}
