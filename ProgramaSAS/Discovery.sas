options symbolgen mprint mlogic;
filename rwiOut ".";
ods html close;
ods html path=rwiOut file="Discovery.html" dom;
data cabecalho;
input dt_report;
call symput(dt_atual, today());
dt_report = &dt_atual.;
run;
proc print data = cabecalho; run;
%include "/tmp/discovery_ms/ProgramaSAS/tab_infoServidor.sas";
%include "/tmp/discovery_ms/ProgramaSAS/tab_infoCPU.sas";
%include "/tmp/discovery_ms/ProgramaSAS/tab_infoMEM.sas";
%include "/tmp/discovery_ms/ProgramaSAS/tab_infoRede.sas";
%include "/tmp/discovery_ms/ProgramaSAS/tab_infoDisco.sas";
%include "/tmp/discovery_ms/ProgramaSAS/sasinstallreport.sas";
ods html close;
ods html;
