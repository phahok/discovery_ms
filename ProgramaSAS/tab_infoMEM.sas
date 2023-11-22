data infoMemoria;
infile datalines delimiter='#' missover dsd;
length descricao $100 informacoes $255.;
input descricao $ informacoes $;
datalines;
Total de Memoria RAM# 62G
Total de SWAP# 799M
;
run;
proc print data=infoMemoria noobs;
title "Informacoes da Memoria - SASSERVER.DEMO.SAS.COM";
run;
