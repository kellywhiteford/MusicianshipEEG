% Plots EEG responses to /da/
function plot_da_violin(dataDa,dataDa_noO,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt,figLabel1,figLabel2)
% dataDa     : structure with /da/ data for each subject
% dataDa_noO : stucture with data data with outlier removed from all fields
% mark_ind   : marker size for individual data
% mark_avg   : marker size for group-average data
% mus_clr    : color of musician datapoints
% nmus_clr   : color of non-musician datapoints
% var_clr    : color of variable datapoints

%% PLOT ALL DATA

% F0 Amplitude 
x = dataDa.yrsMusF;
y = dataDa.F0amp;

% Define colors for each group
color_map = containers.Map({'Mus','Var','NMus'}, {mus_clr, var_clr, nmus_clr}); 

% [1,1,4.75,4.75]
figure('units','inch','position',[1,1,3.54,3.54]);
subplot(2,2,2)
for ii=1:length(x)
    scatter(x(ii),y(ii),mark_ind,color_map(dataDa.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        dx = 0.1; dy = 0; % displacement so the text does not overlay the data points
        text(x(ii)+dx, y(ii)+dy, dataDa.subj_uni{ii},'Interpreter', 'none')
    end
end
annotation('arrow',[.615,.585],[.91,.915],'Linewidth',1,'Color',[0 0 0])

title('b              All Data                ','fontweight','bold')
ylabel(['F0 Amplitude (',char(181),'V)'])
[r, p] = corr(x,y,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(3, .70, ['n = ' num2str(length(x))],'fontweight','bold');
if p < .0001
    text(3, .65, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(3, .65, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

% H2-H10 Amplitude
xh = dataDa.yrsMusF; % Years of formal musical training
yh = dataDa.Hamp; % Individual amplitudes, averaged across H2-H10

subplot(2,2,4)
for ii=1:length(xh)
    scatter(xh(ii),yh(ii),mark_ind,color_map(dataDa.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        dx = 0.1; dy = 0; % displacement so the text does not overlay the data points
        text(xh(ii)+dx, yh(ii)+dy, dataDa.subj_uni{ii},'Interpreter', 'none')  
    end
end
annotation('arrow',[.615,.585],[.435,.42],'Linewidth',1)

ylim([0 .6])
title('d                                            ','fontweight','bold')
ylabel(['H2-H10 Amplitude (',char(181),'V)'])
xlabel('Yrs. of Formal Musical Training')

[rh, ph] = corr(xh,yh,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(3, .5, ['n = ' num2str(length(xh))],'fontweight','bold');
if ph < .0001
    text(3, .46, ['{\itr} = ' num2str(round(rh,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(3, .46, ['{\itr} = ' num2str(round(rh,3)) ', {\itp} = ' num2str(round(ph,3))],'fontweight','bold');
end


%% PLOT BETWEEN-GROUPS DATA

% F0 Amplitude
NMus = y(strcmp(dataDa.Group,'NMus'));
Mus = y(strcmp(dataDa.Group,'Mus'));

NMusLabel = dataDa.Group(strcmp(dataDa.Group,'NMus'));
MusLabel = dataDa.Group(strcmp(dataDa.Group,'Mus'));
groupLabels = cellstr([NMusLabel; MusLabel]);

y2 = [NMus; Mus];

SEM_nm = std(NMus)/sqrt(length(NMus)); % non-musician standard error
SEM_m = std(Mus)/sqrt(length(Mus)); % musician standard error 

subplot(2,2,1)
violinplot(y2, groupLabels,'ViolinColor',[nmus_clr; mus_clr]);
hold on
annotation('arrow',[.175,.2],[.9,.915],'Linewidth',1)

errorbar(.55,mean(NMus),SEM_nm,'k')
errorbar(1.55,mean(Mus),SEM_m,'k')
h2 = scatter([.55,1.55],[mean(NMus),mean(Mus)],mark_avg,[nmus_clr; mus_clr],'d','filled');
set(h2,'MarkerEdgeColor','k');

title('a  Strictly Defined Groups  ','fontweight','bold')
ylabel(['F0 Amplitude (',char(181),'V)'])

[~,p,ci,stats] = ttest2(Mus,NMus,'tail','right','vartype','equal') % One tailed test predicting better performance in the musicians relative to the non-musicians
text(1.05,.70,['Mus: n = ' num2str(length(Mus))],'fontweight','bold')
text(1.05,.65,['NMus: n = ' num2str(length(NMus))],'fontweight','bold')
if p < .0001
    text(1.05, .6, ['{\itt}(' num2str(stats.df) ') = ' num2str(round(stats.tstat,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(1.05, .6, ['{\itt}(' num2str(stats.df) ') = ' num2str(round(stats.tstat,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end


% H2-H10 Amplitude
NMus_h = yh(strcmp(dataDa.Group,'NMus'));
Mus_h = yh(strcmp(dataDa.Group,'Mus'));

y2_h = [NMus_h; Mus_h];

SEM_nm_h = std(NMus_h)/sqrt(length(NMus_h)); % non-musician standard error for Q10s
SEM_m_h = std(Mus_h)/sqrt(length(Mus_h)); % musician standard error for Q10s 

subplot(2,2,3)
violinplot(y2_h, groupLabels,'ViolinColor',[nmus_clr; mus_clr]);
hold on
annotation('arrow',[.175,.2],[.4,.415],'Linewidth',1)

errorbar(.55,mean(NMus_h),SEM_nm_h,'k')
errorbar(1.55,mean(Mus_h),SEM_m_h,'k')
h2 = scatter([.55,1.55],[mean(NMus_h),mean(Mus_h)],mark_avg,[nmus_clr; mus_clr],'d','filled');
set(h2,'MarkerEdgeColor','k');

title('c                                           ','fontweight','bold')
ylabel(['H2-H10 Amplitude (',char(181),'V)'])

xlabel('Group')

[~,p,ci,stats] = ttest2(Mus_h,NMus_h,'tail','right','vartype','equal') % One tailed test predicting better performance in the musicians relative to the non-musicians
text(1.05,.5,['Mus: n = ' num2str(length(Mus_h))],'fontweight','bold')
text(1.05,.46,['NMus: n = ' num2str(length(NMus_h))],'fontweight','bold')
if p < .0001
    text(1.05, .42, ['{\itt}(' num2str(stats.df) ') = ' num2str(round(stats.tstat,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(1.05, .42, ['{\itt}(' num2str(stats.df) ') = ' num2str(round(stats.tstat,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

%print('../../results/Fig2','-dpng') 
print(strcat('../../results/',figLabel1),'-dpng') 


%% OUTLIER REMOVED
% Correlations

% F0 Amplitude 
x_o = dataDa_noO.yrsMusF;
y_o = dataDa_noO.F0amp;

% Define colors for each group
color_map = containers.Map({'Mus','Var','NMus'}, {mus_clr, var_clr, nmus_clr}); 

figure('units','inch','position',[1,1,3.54,3.54]);
subplot(2,2,2)
for ii=1:length(x_o)
    scatter(x_o(ii),y_o(ii),mark_ind,color_map(dataDa_noO.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        dx = 0.1; dy = 0; % displacement so the text does not overlay the data points
        text(x_o(ii)+dx, y_o(ii)+dy, dataDa_noO.subj_uni{ii},'Interpreter', 'none')
    end
end
title('b              All Data                 ','fontweight','bold')
ylabel(['F0 Amplitude (',char(181),'V)'])
ylim([0 .33])

[r, p] = corr(x_o,y_o,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(6, .28, ['n = ' num2str(length(x_o))],'fontweight','bold');
if p < .0001
    text(6, .26, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(6, .26, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

% H2-H10 Amplitude
xh_o = dataDa_noO.yrsMusF; % Years of formal musical training
yh_o = dataDa_noO.Hamp; % Individual amplitudes, averaged across H2-H10

subplot(2,2,4)
for ii=1:length(xh_o)
    scatter(xh_o(ii),yh_o(ii),mark_ind,color_map(dataDa_noO.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        dx = 0.1; dy = 0; % displacement so the text does not overlay the data points
        text(xh_o(ii)+dx, yh_o(ii)+dy, dataDa_noO.subj_uni{ii},'Interpreter', 'none')  
    end
end
%ylim([0 .6])
title('d                                            ','fontweight','bold')
ylabel(['H2-H10 Amplitude (',char(181),'V)'])
xlabel('Yrs. of Formal Musical Training')

[rh, ph] = corr(xh_o,yh_o,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(2, .28, ['n = ' num2str(length(xh_o))],'fontweight','bold');
if ph < .0001
    text(2, .26, ['{\itr} = ' num2str(round(rh,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(2, .26, ['{\itr} = ' num2str(round(rh,3)) ', {\itp} = ' num2str(round(ph,3))],'fontweight','bold');
end

%% PLOT BETWEEN-GROUPS DATA

% F0 Amplitude
NMus_o = y_o(strcmp(dataDa_noO.Group,'NMus'));
Mus_o = y_o(strcmp(dataDa_noO.Group,'Mus'));

NMusLabel_noO = dataDa_noO.Group(strcmp(dataDa_noO.Group,'NMus'));
MusLabel_noO = dataDa_noO.Group(strcmp(dataDa_noO.Group,'Mus'));
groupLabels_noO = cellstr([NMusLabel_noO; MusLabel_noO]);

y2_o = [NMus_o; Mus_o];

SEM_nm_o = std(NMus_o)/sqrt(length(NMus_o)); % non-musician standard error
SEM_m_o = std(Mus_o)/sqrt(length(Mus_o)); % musician standard error 

subplot(2,2,1)
violinplot(y2_o, groupLabels_noO,'ViolinColor',[nmus_clr; mus_clr]);
hold on

errorbar(.55,mean(NMus_o),SEM_nm_o,'k')
errorbar(1.55,mean(Mus_o),SEM_m_o,'k')
h2 = scatter([.55,1.55],[mean(NMus_o),mean(Mus_o)],mark_avg,[nmus_clr; mus_clr],'d','filled');
set(h2,'MarkerEdgeColor','k');

title('a  Strictly Defined Groups   ','fontweight','bold')
ylabel(['F0 Amplitude (',char(181),'V)'])
ylim([0 .33])

[~,p,ci,stats] = ttest2(Mus_o,NMus_o,'tail','right','vartype','equal') % One tailed test predicting better performance in the musicians relative to the non-musicians
text(.55,.3,['Mus: n = ' num2str(length(Mus_o))],'fontweight','bold')
text(.55,.28,['NMus: n = ' num2str(length(NMus_o))],'fontweight','bold')
if p < .0001
    text(.55, .26, ['{\itt}(' num2str(stats.df) ') = ' num2str(round(stats.tstat,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.55, .26, ['{\itt}(' num2str(stats.df) ') = ' num2str(round(stats.tstat,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end


% H2-H10 Amplitude
NMus_h_o = yh_o(strcmp(dataDa_noO.Group,'NMus'));
Mus_h_o = yh_o(strcmp(dataDa_noO.Group,'Mus'));

y2_h_o = [NMus_h_o; Mus_h_o];

SEM_nm_h_o = std(NMus_h_o)/sqrt(length(NMus_h_o)); % non-musician standard error for Q10s
SEM_m_h_o = std(Mus_h_o)/sqrt(length(Mus_h_o)); % musician standard error for Q10s 

subplot(2,2,3)
violinplot(y2_h_o, groupLabels_noO,'ViolinColor',[nmus_clr; mus_clr]);
hold on

errorbar(.55,mean(NMus_h_o),SEM_nm_h_o,'k')
errorbar(1.55,mean(Mus_h_o),SEM_m_h_o,'k')
h2 = scatter([.55,1.55],[mean(NMus_h_o),mean(Mus_h_o)],mark_avg,[nmus_clr; mus_clr],'d','filled');
set(h2,'MarkerEdgeColor','k');

title('c                                            ','fontweight','bold')
ylabel(['H2-H10 Amplitude (',char(181),'V)'])

xlabel('Group')

[~,p,ci,stats] = ttest2(Mus_h_o,NMus_h_o,'tail','right','vartype','equal') % One tailed test predicting better performance in the musicians relative to the non-musicians
text(.55,.28,['Mus: n = ' num2str(length(Mus_h_o))],'fontweight','bold')
text(.55,.26,['NMus: n = ' num2str(length(NMus_h_o))],'fontweight','bold')
if p < .0001
    text(.55, .24, ['{\itt}(' num2str(stats.df) ') = ' num2str(round(stats.tstat,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.55, .24, ['{\itt}(' num2str(stats.df) ') = ' num2str(round(stats.tstat,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

print(strcat('../../results/', figLabel2),'-dpng') 

