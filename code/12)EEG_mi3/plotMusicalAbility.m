% Plots correlations between neural coding and musical ability 
function plotMusicalAbility(dataMi3M,dataDaM,dataDa_rA_M,dataDaM_noO,mark_ind,mus_clr,nmus_clr,var_clr,txt)
% dataMi3  : structure of data for all participants who meet analysis criteria for /mi3/ experiment who ALSO have melody discrimination data
% dataDa   : structure of data for all participants who meet analysis criteria for /da/ experiment who ALSO have melody discrimination data
% mark_avg : marker size for group-average data
% mus_clr  : color of musician datapoints
% nmus_clr : color of non-musician datapoints
% var_clr  : color of variable datapoints (partiicpnats that do not meet either musician or non-musician definition)
% txt      : 1 (label data points with subj_uni IDs) or 0

%% All data
x = dataDaM.dp; % non-parametric sensitivity index for melody discrimination
y1 = dataDaM.F0amp; % spectral encoding for the F0 of /da/ in babble
y2 = dataDaM.Hamp; 
y3 = dataDa_rA_M.r_lim; % for plotting
z3 = dataDa_rA_M.z_lim; % for analyses
y4 = dataMi3M.Stim2resp_r; % for plotting
z4 = dataMi3M.Stim2resp_z; % for analyses

x4 = dataMi3M.dp;
% Define colors for each group
color_map = containers.Map({'Mus','Var','NMus'}, {mus_clr, var_clr, nmus_clr}); 

figure('units','inch','position',[1,1,3.54,3.54]);
subplot(2,2,1)
for ii=1:length(x)
    scatter(x(ii),y1(ii),mark_ind,color_map(dataDaM.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x(ii), y1(ii), dataDaM.subj_uni{ii});
    end
end

annotation('arrow',[.172,.2],[.91,.915],'Linewidth',1,'Color',[0 0 0])

title('a                   /da/                   ','fontweight','bold')
ylabel(['F0 Amplitude (',char(181),'V)'])
xlabel('Melody Discrimination ({\itd''_p})')

[r, p] = corr(x,y1,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(0, .5, ['n = ' num2str(length(x))],'fontweight','bold');
if p < .0001
    text(0, .45, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(0, .45, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

subplot(2,2,2)
for ii=1:length(x)
    scatter(x(ii),y2(ii),mark_ind,color_map(dataDaM.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x(ii), y2(ii), dataDaM.subj_uni{ii});
    end
end

annotation('arrow',[.695,.665],[.885,.89],'Linewidth',1,'Color',[0 0 0])

title('b                   /da/                   ','fontweight','bold')
ylabel(['H2-H10 Amplitude (',char(181),'V)'])
xlabel('Melody Discrimination ({\itd''_p})')

[r, p] = corr(x,y2,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(0, .45, ['n = ' num2str(length(x))],'fontweight','bold');
if p < .0001
    text(0, .41, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(0, .41, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

subplot(2,2,3)
for ii=1:length(x)
    scatter(x(ii),y3(ii),mark_ind,color_map(dataDaM.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x(ii), y3(ii), dataDaM.subj_uni{ii});
    end
end
title('c                   /da/                   ','fontweight','bold')
ylabel('Stimulus-to-Response ({\itr})')
xlabel('Melody Discrimination ({\itd''_p})')
ylim([-.1 .4])

[r, p] = corr(x,z3,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(-.5, .38, ['n = ' num2str(length(x))],'fontweight','bold');
if p < .0001
    text(-.5, .35, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(-.5, .35, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

subplot(2,2,4)
for ii=1:length(x4)
    scatter(x4(ii),y4(ii),mark_ind,color_map(dataMi3M.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x4(ii), y4(ii), dataMi3M.subj_uni{ii});
    end
end
title('d                 /mi3/                  ','fontweight','bold')
ylabel('F0 Stimulus-to-Response ({\itr})')
xlabel('Melody Discrimination ({\itd''_p})')

[r, p] = corr(x4,z4,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(-.5, -.6, ['n = ' num2str(length(x4))],'fontweight','bold');
if p < .0001
    text(-.5, -.74, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(-.5, -.74, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

print('../../results/Fig6','-dpng') 
%% /da/ Outlier Excluded
x_noO = dataDaM_noO.dp; % non-parametric sensitivity index for melody discrimination
y1_noO = dataDaM_noO.F0amp; % spectral encoding for the F0 of /da/ in babble
y2_noO = dataDaM_noO.Hamp; 

%figure('units','inch','position',[1,1,4.75,2.375]);
figure('units','inch','position',[1,1,3.54,1.77]);
subplot(1,2,1)
for ii=1:length(x_noO)
    scatter(x_noO(ii),y1_noO(ii),mark_ind,color_map(dataDaM_noO.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x_noO(ii), y1_noO(ii), dataDaM_noO.subj_uni{ii});
    end
end
title('a                                           ','fontweight','bold')
ylabel(['F0 Amplitude (',char(181),'V)'])
xlabel('Melody Discrimination ({\itd''_p})')

[r, p] = corr(x_noO,y1_noO,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(-.8, .38, ['n = ' num2str(length(x_noO))],'fontweight','bold');
if p < .0001
    text(-.8, .35, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(-.8, .35, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

subplot(1,2,2)
for ii=1:length(x_noO)
    scatter(x_noO(ii),y2_noO(ii),mark_ind,color_map(dataDaM.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x_noO(ii), y2_noO(ii), dataDaM_noO.subj_uni{ii});
    end
end
title('b                                           ','fontweight','bold')
ylabel(['H2-H10 Amplitude (',char(181),'V)'])
xlabel('Melody Discrimination ({\itd''_p})')

[r, p] = corr(x_noO,y2_noO,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(-.8, .29, ['n = ' num2str(length(x_noO))],'fontweight','bold');
if p < .0001
    text(-.8, .27, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(-.8, .27, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

print('../../results/SupFig11','-dpng') 

