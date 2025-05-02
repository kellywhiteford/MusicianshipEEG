% Plots EEG responses to /da/
function plot_rA_lim_violin(data_rA,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt)
% data_rA   : structure with /da/ adjusted stimulus-to-response correlations 
% mark_ind : marker size for individual data
% mark_avg  : marker size for group-average data
% mus_clr   : color of musician datapoints
% nmus_clr  : color of non-musician datapoints

%% PLOT ALL DATA
% Z
x = data_rA.yrsMusF;
y = data_rA.r_lim;
z = data_rA.z_lim;

% Define colors for each group
color_map = containers.Map({'Mus','Var','NMus'}, {mus_clr, var_clr, nmus_clr}); 

figure('units','inch','position',[2,2,4.8,2.25]);
subplot(1,2,2)
for ii=1:length(x)
    scatter(x(ii),y(ii),mark_ind,color_map(data_rA.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        dx = 0.1; dy = 0; % displacement so the text does not overlay the data points
        text(x(ii)+dx, y(ii)+dy, data_rA.subj_uni{ii},'Interpreter', 'none')  
    end
end
title('b               All Data                 ','fontweight','bold')
ylabel('Stimulus-to-Response ({\itr})')
xlabel('Yrs. of Formal Musical Training')
% ylim([0 .3])


[r, p] = corr(x,z,'tail','right','type','Pearson') % one-tailed test predicting a positive correlation
text(3, -.05, ['n = ' num2str(length(x))],'fontweight','bold');
if p < .0001
    text(3, -.07, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(3, -.07, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

%% PLOT BETWEEN-GROUPS DATA

% Z
NMus = y(strcmp(data_rA.Group,'NMus'));
Mus = y(strcmp(data_rA.Group,'Mus'));

NMus_z = z(strcmp(data_rA.Group,'NMus'));
Mus_z = z(strcmp(data_rA.Group,'Mus'));

NMusLabel = data_rA.Group(strcmp(data_rA.Group,'NMus'));
MusLabel = data_rA.Group(strcmp(data_rA.Group,'Mus'));
groupLabels = cellstr([NMusLabel; MusLabel]);

y2 = [NMus; Mus];

SEM_nm = std(NMus)/sqrt(length(NMus)); % non-musician standard error for Q10s
SEM_m = std(Mus)/sqrt(length(Mus)); % musician standard error for Q10s 

subplot(1,2,1)
violinplot(y2, groupLabels,'ViolinColor',[nmus_clr; mus_clr]);
title('a  Strictly Defined Groups   ','fontweight','bold')
ylabel('Stimulus-to-Response ({\itr})')
xlabel('Group')

hold on
errorbar(.6,mean(NMus),SEM_nm,'k')
errorbar(1.6,mean(Mus),SEM_m,'k')
h2 = scatter([.6,1.6],[mean(NMus),mean(Mus)],mark_avg,[nmus_clr; mus_clr],'d','filled');
set(h2,'MarkerEdgeColor','k');

[~,p,ci,stats] = ttest2(Mus_z,NMus_z,'tail','right','vartype','equal') % One tailed test predicting better performance in the musicians relative to the non-musicians

