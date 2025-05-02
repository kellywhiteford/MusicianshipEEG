% Plots stimulus-to-response correlations for /mi3/
function plot_mi3_violin(dataMi3,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt,isO,figName)
% dataMi3   : structure with /mi3/ data for each subject
% mark_ind : marker size for individual data
% mark_avg : marker size for group-average data
% mus_clr  : color of musician datapoints
% nmus_clr : color of non-musician datapoints
% isO      : is outlier included (1: yes; 0: no)
% figName  : name of figure file (string)

%% PLOT ALL DATA
% All stimulus-to-response correlations 
x = dataMi3.yrsMusF; % Years of formal musical training
y = dataMi3.Stim2resp_r; % Individual stimulus-to-response correlations
z = dataMi3.Stim2resp_z; % Individual z-transformed data for analyses

% Define colors for each group
color_map = containers.Map({'Mus','Var','NMus'}, {mus_clr, var_clr, nmus_clr}); 

% [2,2,7.6,2.25])
figure('units','inch','position',[2,2,7.086,1.736]);
subplot(1,3,2)
for ii=1:length(x)
    scatter(x(ii),y(ii),mark_ind,color_map(dataMi3.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x(ii), y(ii), dataMi3.subj_uni{ii});
    end
end

title('b                      All Data                        ','fontweight','bold')
ylabel('Stimulus-to-Response ({\itr})')
xlabel('Yrs. of Formal Musical Training')
ylim([-1 1])


[r, p] = corr(x,z,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(16, -.5, ['n = ' num2str(length(x))],'fontweight','bold');
if p < .0001
    text(16, -.62, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(16, -.62, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

%% PLOT BETWEEN-GROUPS DATA
NMus = y(strcmp(dataMi3.Group,'NMus')); % for plotting
Mus = y(strcmp(dataMi3.Group,'Mus')); % for plotting

NMus_z = z(strcmp(dataMi3.Group,'NMus')); % for analyses
Mus_z = z(strcmp(dataMi3.Group,'Mus')); % for analyses

NMusLabel = dataMi3.Group(strcmp(dataMi3.Group,'NMus'));
MusLabel = dataMi3.Group(strcmp(dataMi3.Group,'Mus'));
groupLabels = cellstr([NMusLabel; MusLabel]);

y2 = [NMus; Mus];

SEM_nm = std(NMus)/sqrt(length(NMus)); % non-musician standard error for Q10s
SEM_m = std(Mus)/sqrt(length(Mus)); % musician standard error for Q10s

subplot(1,3,1)
violinplot(y2, groupLabels,'ViolinColor',[nmus_clr; mus_clr]);
title('a        Strictly Defined Groups         ','fontweight','bold')
ylabel('Stimulus-to-Response ({\itr})')
xlabel('Group')
ylim([-1 1])

if isO
    annotation('arrow',[.325,.3],[.3,.325],'Linewidth',1,'Color',[0 0 0])
end 

hold on
errorbar(.6,mean(NMus),SEM_nm,'k')
errorbar(1.6,mean(Mus),SEM_m,'k')
h2 = scatter([.6,1.6],[mean(NMus),mean(Mus)],mark_avg,[nmus_clr; mus_clr],'d','filled');
set(h2,'MarkerEdgeColor','k');

[~,p,ci,stats] = ttest2(Mus_z,NMus_z,'tail','right','vartype','equal') % One tailed test predicting better performance in the musicians relative to the non-musicians
text(.6,-.5,['Mus: n = ' num2str(length(Mus_z))],'fontweight','bold')
text(.6,-.61,['NMus: n = ' num2str(length(NMus_z))],'fontweight','bold')
if p < .0001
    text(.6, -.72, ['{\itt}(' num2str(stats.df) ') = ' num2str(round(stats.tstat,2)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.6, -.72, ['{\itt}(' num2str(stats.df) ') = ' num2str(round(stats.tstat,2)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end


%% PLOT AGE AT FIRST START 
% All stimulus-to-response correlations 
x3 = dataMi3.ageStart; % Age first started musical training
y3 = dataMi3.Stim2resp_r; % Individual stimulus-to-response correlations
z3 = dataMi3.Stim2resp_z; % z-transformed data for analyses
subset_subjIDs = dataMi3.subj_uni;
group3 = dataMi3.Group;
age3 = dataMi3.age;

indNaN = isnan(x3); %indices of subjects that never played a musical instrument
x3(indNaN) = []; % removes people with no age-at-first start since they never played an instrument
y3(indNaN) = []; % removes eeg correlations for people that never played an instrument
z3(indNaN) = [];
subset_subjIDs(indNaN) = [];
group3(indNaN) = [];
age3(indNaN) = [];

subplot(1,3,3)
for ii=1:length(x3)
    scatter(x3(ii),y3(ii),mark_ind,color_map(group3{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        dx = 0.1; dy = 0; % displacement so the text does not overlay the data points
        text(x3(ii)+dx, y3(ii)+dy, subset_subjIDs{ii})
    end
end
ylabel('Stimulus-to-Response ({\itr})')
xlabel('Age First Started Training')
title('c               \geq 1 Yr. Training              ','fontweight','bold')
ylim([-1 1])

text(20, -.5, ['n = ' num2str(length(x3))],'fontweight','bold');
[r, p] = corr(x3,z3,'tail','left','type','Pearson'); % one-tailed test predicting a negative correlation
if p < .0001
    text(20, -.62, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(20, -.62, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

[rp, pp] = partialcorr(x3,z3,age3,'tail','left','type','Pearson'); % one-tailed test predicting a negative correlation

figPath = ['../../results/',figName];
print(figPath,'-dpng') 
