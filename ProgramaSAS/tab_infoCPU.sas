data infoCPU;
infile datalines delimiter='#' missover dsd;
length descricao $100 informacoes $255.;
input descricao $ informacoes $;
datalines;
Modelo da CPU# Intel(R) Xeon(R) Gold 6148 CPU @ 2.40GHz
Total de Threads# 1
Total de VCores# 4
Total de Processadores# 8
;
run;
proc print data=infoCPU noobs;
title "Informacoes da CPU - SASSERVER.DEMO.SAS.COM";
run;
