% Plots EEG responses to /da/
function plot_da_gender_violin(dataDa,dataDa_noO,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt)
% dataDa     : structure with /da/ data for each subject
% dataDa_noO : stucture with data data with outlier removed from all fields
% mark_ind   : marker size for individual data
% mark_avg   : marker size for group-average data
% mus_clr    : color of musician datapoints
% nmus_clr   : color of non-musician datapoints
% var_clr    : color of variable datapoints

% F0 Amplitude 
yF0 = dataDa.F0amp;
yH = dataDa.Hamp;
yF0_noO = dataDa_noO.F0amp;
yH_noO = dataDa_noO.Hamp;

%% ALL PARTICIPANTS
% F0 Amplitude
NMus_F_F0 = yF0(strcmp(dataDa.Group,'NMus') & (dataDa.gender==1)); % non-musician females
NMus_M_F0 = yF0(strcmp(dataDa.Group,'NMus') & (dataDa.gender==2)); % non-musician males
Mus_F_F0 = yF0(strcmp(dataDa.Group,'Mus') & (dataDa.gender==1)); % musician females
Mus_M_F0 = yF0(strcmp(dataDa.Group,'Mus') & (dataDa.gender==2)); % musician males

NMusLabel = dataDa.Group(strcmp(dataDa.Group,'NMus'));
MusLabel = dataDa.Group(strcmp(dataDa.Group,'Mus'));

NMusLabel_f = strcat(NMusLabel(1:length(NMus_F_F0)),'F');
NMusLabel_m = strcat(NMusLabel(1:length(NMus_M_F0)),'M');
MusLabel_f = strcat(MusLabel(1:length(Mus_F_F0)),'F');
MusLabel_m = strcat(MusLabel(1:length(Mus_M_F0)),'M');

groupLabels = cellstr([NMusLabel_f; NMusLabel_m; MusLabel_f; MusLabel_m]);

y2_F0 = [NMus_F_F0; NMus_M_F0; Mus_F_F0; Mus_M_F0];

SEM_nm_f = std(NMus_F_F0)/sqrt(length(NMus_F_F0)); % female non-musician standard error
SEM_nm_m = std(NMus_M_F0)/sqrt(length(NMus_M_F0)); % male non-musician standard error
SEM_m_f = std(Mus_F_F0)/sqrt(length(Mus_F_F0)); % female musician standard error 
SEM_m_m = std(Mus_M_F0)/sqrt(length(Mus_M_F0)); % male musician standard error 

figure('units','inch','position',[1,1,6,3.54]);
subplot(2,2,1)
violinplot(y2_F0, groupLabels,'ViolinColor',[nmus_clr; nmus_clr; mus_clr; mus_clr]);
hold on
annotation('arrow',[.22,.245],[.9,.915],'Linewidth',1)
annotation('arrow',[.305,.33],[.7,.715],'Linewidth',1)

errorbar(.6,mean(NMus_F_F0),SEM_nm_f,'k')
errorbar(1.6,mean(NMus_M_F0),SEM_nm_m,'k')
errorbar(2.6,mean(Mus_F_F0),SEM_m_f,'k')
errorbar(3.6,mean(Mus_M_F0),SEM_m_m,'k')
h2 = scatter([.6,1.6, 2.6,3.6],[mean(NMus_F_F0),mean(NMus_M_F0),mean(Mus_F_F0),mean(Mus_M_F0)],mark_avg,[nmus_clr; nmus_clr; mus_clr; mus_clr],'d','filled');
set(h2,'MarkerEdgeColor','k');

title('a           All Musicians & Non-Musicians           ','fontweight','bold')
ylabel(['F0 Amplitude (',char(181),'V)'])

text(2.25,.75,['NMusF: n = ' num2str(length(NMus_F_F0))],'fontweight','bold')
text(2.25,.7,['NMusM: n = ' num2str(length(NMus_M_F0))],'fontweight','bold')
text(2.25,.65,['MusF: n = ' num2str(length(Mus_F_F0))],'fontweight','bold')
text(2.25,.6,['MusM: n = ' num2str(length(Mus_M_F0))],'fontweight','bold')

hold on

% Upper Harmonics
NMus_F_H = yH(strcmp(dataDa.Group,'NMus') & (dataDa.gender==1)); % non-musician females
NMus_M_H = yH(strcmp(dataDa.Group,'NMus') & (dataDa.gender==2)); % non-musician males
Mus_F_H = yH(strcmp(dataDa.Group,'Mus') & (dataDa.gender==1)); % musician females
Mus_M_H = yH(strcmp(dataDa.Group,'Mus') & (dataDa.gender==2)); % musician males

y2_H = [NMus_F_H; NMus_M_H; Mus_F_H; Mus_M_H];

SEM_nm_f = std(NMus_F_H)/sqrt(length(NMus_F_H)); % female non-musician standard error
SEM_nm_m = std(NMus_M_H)/sqrt(length(NMus_M_H)); % male non-musician standard error
SEM_m_f = std(Mus_F_H)/sqrt(length(Mus_F_H)); % female musician standard error 
SEM_m_m = std(Mus_M_H)/sqrt(length(Mus_M_H)); % male musician standard error 

subplot(2,2,2)
violinplot(y2_H, groupLabels,'ViolinColor',[nmus_clr; nmus_clr; mus_clr; mus_clr]);
hold on
annotation('arrow',[.665,.69],[.875,.89],'Linewidth',1)

errorbar(.6,mean(NMus_F_H),SEM_nm_f,'k')
errorbar(1.6,mean(NMus_M_H),SEM_nm_m,'k')
errorbar(2.6,mean(Mus_F_H),SEM_m_f,'k')
errorbar(3.6,mean(Mus_M_H),SEM_m_m,'k')
h2 = scatter([.6,1.6, 2.6,3.6],[mean(NMus_F_H),mean(NMus_M_H),mean(Mus_F_H),mean(Mus_M_H)],mark_avg,[nmus_clr; nmus_clr; mus_clr; mus_clr],'d','filled');
set(h2,'MarkerEdgeColor','k');

title('b           All Musicians & Non-Musicians           ','fontweight','bold')
ylabel(['H2-H10 Amplitude (',char(181),'V)'])

text(2.25,.575,['NMusF: n = ' num2str(length(NMus_F_H))],'fontweight','bold')
text(2.25,.535,['NMusM: n = ' num2str(length(NMus_M_H))],'fontweight','bold')
text(2.25,.495,['MusF: n = ' num2str(length(Mus_F_H))],'fontweight','bold')
text(2.25,.455,['MusM: n = ' num2str(length(Mus_M_H))],'fontweight','bold')

%% OUTLIER REMOVED
% F0 Amplitude
NMus_F_F0_noO = yF0_noO(strcmp(dataDa_noO.Group,'NMus') & (dataDa_noO.gender==1)); % non-musician females
NMus_M_F0_noO = yF0_noO(strcmp(dataDa_noO.Group,'NMus') & (dataDa_noO.gender==2)); % non-musician males
Mus_F_F0_noO = yF0_noO(strcmp(dataDa_noO.Group,'Mus') & (dataDa_noO.gender==1)); % musician females
Mus_M_F0_noO = yF0_noO(strcmp(dataDa_noO.Group,'Mus') & (dataDa_noO.gender==2)); % musician males

NMusLabel_noO = dataDa_noO.Group(strcmp(dataDa_noO.Group,'NMus'));
MusLabel_noO = dataDa_noO.Group(strcmp(dataDa_noO.Group,'Mus'));

NMusLabel_f_noO = strcat(NMusLabel_noO(1:length(NMus_F_F0_noO)),'F');
NMusLabel_m_noO = strcat(NMusLabel_noO(1:length(NMus_M_F0_noO)),'M');
MusLabel_f_noO = strcat(MusLabel_noO(1:length(Mus_F_F0_noO)),'F');
MusLabel_m_noO = strcat(MusLabel_noO(1:length(Mus_M_F0_noO)),'M');

groupLabels_noO = cellstr([NMusLabel_f_noO; NMusLabel_m_noO; MusLabel_f_noO; MusLabel_m_noO]);

y2_F0_noO = [NMus_F_F0_noO; NMus_M_F0_noO; Mus_F_F0_noO; Mus_M_F0_noO];

SEM_nm_f_noO = std(NMus_F_F0_noO)/sqrt(length(NMus_F_F0_noO)); % female non-musician standard error
SEM_nm_m_noO = std(NMus_M_F0_noO)/sqrt(length(NMus_M_F0_noO)); % male non-musician standard error
SEM_m_f_noO = std(Mus_F_F0_noO)/sqrt(length(Mus_F_F0_noO)); % female musician standard error 
SEM_m_m_noO = std(Mus_M_F0_noO)/sqrt(length(Mus_M_F0_noO)); % male musician standard error 

subplot(2,2,3)
violinplot(y2_F0_noO, groupLabels_noO,'ViolinColor',[nmus_clr; nmus_clr; mus_clr; mus_clr]);
hold on
annotation('arrow',[.305,.33],[.36,.375],'Linewidth',1)

errorbar(.6,mean(NMus_F_F0_noO),SEM_nm_f_noO,'k')
errorbar(1.6,mean(NMus_M_F0_noO),SEM_nm_m_noO,'k')
errorbar(2.6,mean(Mus_F_F0_noO),SEM_m_f_noO,'k')
errorbar(3.6,mean(Mus_M_F0_noO),SEM_m_m_noO,'k')
h2 = scatter([.6,1.6, 2.6,3.6],[mean(NMus_F_F0_noO),mean(NMus_M_F0_noO),mean(Mus_F_F0_noO),mean(Mus_M_F0_noO)],mark_avg,[nmus_clr; nmus_clr; mus_clr; mus_clr],'d','filled');
set(h2,'MarkerEdgeColor','k');

title('c       Outlier Non-Musician Male Removed       ','fontweight','bold')
ylabel(['F0 Amplitude (',char(181),'V)'])

text(.75,.375,['NMusF: n = ' num2str(length(NMus_F_F0_noO))],'fontweight','bold')
text(.75,.35,['NMusM: n = ' num2str(length(NMus_M_F0_noO))],'fontweight','bold')
text(.75,.325,['MusF: n = ' num2str(length(Mus_F_F0_noO))],'fontweight','bold')
text(.75,.3,['MusM: n = ' num2str(length(Mus_M_F0_noO))],'fontweight','bold')

hold on

% Upper Harmonics
NMus_F_H_noO = yH_noO(strcmp(dataDa_noO.Group,'NMus') & (dataDa_noO.gender==1)); % non-musician females
NMus_M_H_noO = yH_noO(strcmp(dataDa_noO.Group,'NMus') & (dataDa_noO.gender==2)); % non-musician males
Mus_F_H_noO = yH_noO(strcmp(dataDa_noO.Group,'Mus') & (dataDa_noO.gender==1)); % musician females
Mus_M_H_noO = yH_noO(strcmp(dataDa_noO.Group,'Mus') & (dataDa_noO.gender==2)); % musician males

y2_H_noO = [NMus_F_H_noO; NMus_M_H_noO; Mus_F_H_noO; Mus_M_H_noO];

SEM_nm_f_noO = std(NMus_F_H_noO)/sqrt(length(NMus_F_H_noO)); % female non-musician standard error
SEM_nm_m_noO = std(NMus_M_H_noO)/sqrt(length(NMus_M_H_noO)); % male non-musician standard error
SEM_m_f_noO = std(Mus_F_H_noO)/sqrt(length(Mus_F_H_noO)); % female musician standard error 
SEM_m_m_noO = std(Mus_M_H_noO)/sqrt(length(Mus_M_H_noO)); % male musician standard error 

subplot(2,2,4)
violinplot(y2_H_noO, groupLabels_noO,'ViolinColor',[nmus_clr; nmus_clr; mus_clr; mus_clr]);
hold on

errorbar(.6,mean(NMus_F_H_noO),SEM_nm_f_noO,'k')
errorbar(1.6,mean(NMus_M_H_noO),SEM_nm_m_noO,'k')
errorbar(2.6,mean(Mus_F_H_noO),SEM_m_f_noO,'k')
errorbar(3.6,mean(Mus_M_H_noO),SEM_m_m_noO,'k')
h2 = scatter([.6,1.6, 2.6,3.6],[mean(NMus_F_H_noO),mean(NMus_M_H_noO),mean(Mus_F_H_noO),mean(Mus_M_H_noO)],mark_avg,[nmus_clr; nmus_clr; mus_clr; mus_clr],'d','filled');
set(h2,'MarkerEdgeColor','k');

title('d       Outlier Non-Musician Male Removed       ','fontweight','bold')
ylabel(['H2-H10 Amplitude (',char(181),'V)'])

text(.75,.275,['NMusF: n = ' num2str(length(NMus_F_H_noO))],'fontweight','bold')
text(.75,.255,['NMusM: n = ' num2str(length(NMus_M_H_noO))],'fontweight','bold')
text(.75,.235,['MusF: n = ' num2str(length(Mus_F_H_noO))],'fontweight','bold')
text(.75,.215,['MusM: n = ' num2str(length(Mus_M_H_noO))],'fontweight','bold')

print('../../results/SupFig4','-dpng') 
