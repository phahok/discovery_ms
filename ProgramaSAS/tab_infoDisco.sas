data infoDisco;
infile datalines delimiter='#' missover dsd;
length descricao $100 informacoes $255.;
input descricao $ informacoes $;
datalines;
Disco# Filesystem     Type      Size  Used Avail Use% Mounted on
Disco# devtmpfs       devtmpfs   32G     0   32G   0% /dev
Disco# tmpfs          tmpfs      32G  728K   32G   1% /dev/shm
Disco# tmpfs          tmpfs      32G   19M   32G   1% /run
Disco# tmpfs          tmpfs      32G     0   32G   0% /sys/fs/cgroup
Disco# /dev/sda2      xfs       304G  101G  203G  34% /
Disco# tmpfs          tmpfs     6.3G   36K  6.3G   1% /run/user/0
Disco# tmpfs          tmpfs     6.3G   40K  6.3G   1% /run/user/1002
;
run;
proc print data=infoDisco noobs;
title "Informacoes do Disco - SASSERVER.DEMO.SAS.COM";
run;
