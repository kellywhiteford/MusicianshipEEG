% Plots correlations between musical ability and years of formal musical
% trianing.
function plotMusAll(allMus,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt)
% subjInfo : structure of online screening data for all participants who have full datasets for at least one neural task
% mark_avg : marker size for group-average data
% mus_clr  : color of musician datapoints
% nmus_clr : color of non-musician datapoints
% var_clr  : color of variable datapoints (partiicpnats that do not meet either musician or non-musician definition)
% txt      : 1 (label data points with subj_uni IDs) or 0

%% All data
x1 = allMus.yrsMusF; 
y1 = allMus.dp; % non-parametric sensitivity index for melody discrimination

% Define colors for each group
color_map = containers.Map({'Mus','Var','NMus'}, {mus_clr, var_clr, nmus_clr}); 

%% PLOT BETWEEN-GROUPS DATA
NMus = y1(strcmp(allMus.Group,'NMus')); % for plotting
Mus = y1(strcmp(allMus.Group,'Mus')); % for plotting

NMusLabel = allMus.Group(strcmp(allMus.Group,'NMus'));
MusLabel = allMus.Group(strcmp(allMus.Group,'Mus'));
groupLabels = cellstr([NMusLabel; MusLabel]);

y2 = [NMus; Mus];

SEM_nm = std(NMus)/sqrt(length(NMus)); % non-musician standard error s
SEM_m = std(Mus)/sqrt(length(Mus)); % musician standard error 

figure('units','inch','position',[1,1,3.54,1.8]);
subplot(1,2,1)
violinplot(y2, groupLabels,'ViolinColor',[nmus_clr; mus_clr]);
title('a  Strictly Defined Groups  ','fontweight','bold')
ylabel('Melody Discrimination ({\itd''_p})')
xlabel('Group')
%ylim([-1 1])

% if isO
%     annotation('arrow',[.325,.3],[.3,.325],'Linewidth',1,'Color',[0 0 0])
% end 

hold on
errorbar(.55,mean(NMus),SEM_nm,'k')
errorbar(1.55,mean(Mus),SEM_m,'k')
h2 = scatter([.55,1.55],[mean(NMus),mean(Mus)],mark_avg,[nmus_clr; mus_clr],'d','filled');
set(h2,'MarkerEdgeColor','k');

[~,p,ci,stats] = ttest2(Mus,NMus,'tail','right','vartype','equal') % One tailed test predicting better performance in the musicians relative to the non-musicians
text(.6,2.65,['Mus: n = ' num2str(length(Mus))],'fontweight','bold')
text(.6,2.4,['NMus: n = ' num2str(length(NMus))],'fontweight','bold')
if p < .0001
    text(.6, 2.9, ['{\itt}(' num2str(stats.df) ') = ' num2str(round(stats.tstat,2)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.6, 2.9, ['{\itt}(' num2str(stats.df) ') = ' num2str(round(stats.tstat,2)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end


%% ALL DATA
subplot(1,2,2)
for ii=1:length(x1)
    scatter(x1(ii),y1(ii),mark_ind,color_map(allMus.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x1(ii), y1(ii), allMus.subj_uni{ii});
    end
end

title('b               All Data                 ','fontweight','bold')
ylabel('Melody Discrimination ({\itd''_p})')
xlabel('Yrs. of Formal Musical Training')

[r, p] = corr(x1,y1,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(16, -.44, ['n = ' num2str(length(x1))],'fontweight','bold');
if p < .0001
    text(16, -.62, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(16, -.62, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

print('../../results/Fig5','-dpng')