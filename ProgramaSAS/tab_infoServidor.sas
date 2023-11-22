data infoCPU;
infile datalines delimiter='#' missover dsd;
length descricao $100 informacoes $255.;
input descricao $ informacoes $;
datalines;
Hostname# sasserver.demo.sas.com
Tipo de Servidor# vm
Virtualizacao# vmware
Sistema Operacional# CentOS Linux release 7.9.2009 (Core)
Versao do Kernel# Linux 3.10.0-1160.88.1.el7.x86_64
;
run;
proc print data=infoCPU noobs;
title "Informacoes do Servidor - SASSERVER.DEMO.SAS.COM";
run;
