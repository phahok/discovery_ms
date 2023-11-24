options symbolgen mprint mlogic;
filename rwiOut ".";
ods html close;
options nodate nonumber;
title;
ods escapechar="\~";
footnote "\~\{style \[font_size=10pt just=right color=cxffffff\] Provided to you by SAS 9.4 and ODS Absolute Layout features.\}";
proc template;
define style Styles.Orionbackground;
parent=Styles.Printer;
style body \/
background=#87CEFA;
end;
run;
ods pdf file="Discovery_teste.pdf" style=Styles.Orionbackground notoc;
data _null_ ;
dcl odsout trt();
trt.layout_absolute();
trt.region(y: '2in');
trt.format_text(data: 'Discovery', just: 'c',
style_attr: 'color=cxffffff just=center font_size=72pt');
trt.region(y: '3in', x: '3in');
trt.format_text(data: 'Managed Services',
style_attr:'color=cxffffff font_size=28pt');
trt.region(y: '5in');
trt.format_text(data: 'SASSERVER.DEMO.SAS.COM',
just: 'c',
style_attr:'font_size=36pt color=cxffffff');
trt.region(y: '7in');
trt.format_text(data: '24112023_1346',
just: c,
style_attr:'font_size=20pt color=cxffffff');
trt.layout_end();
run;
ods pdf style=listing;
%include "/tmp/discovery_ms/ProgramaSAS/tab_infoServidor.sas";
%include "/tmp/discovery_ms/ProgramaSAS/tab_infoCPU.sas";
%include "/tmp/discovery_ms/ProgramaSAS/tab_infoMEM.sas";
%include "/tmp/discovery_ms/ProgramaSAS/tab_infoRede.sas";
%include "/tmp/discovery_ms/ProgramaSAS/tab_infoDisco.sas";
%include "/tmp/discovery_ms/ProgramaSAS/sasinstallreport.sas";
ods pdf close;
