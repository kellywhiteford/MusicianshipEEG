% Plots EEG responses to /da/ as a function of age
function plot_da_age(dataDa,dataDa_noO,mark_ind,mus_clr,nmus_clr,var_clr,txt)
% dataDa     : structure with /da/ data for each subject
% dataDa_noO : stucture with data data with outlier removed from all fields
% mark_ind   : marker size for individual data
% mark_avg   : marker size for group-average data
% mus_clr    : color of musician datapoints
% nmus_clr   : color of non-musician datapoints
% var_clr    : color of variable datapoints

%% PLOT ALL DATA

% F0 Amplitude 
x = dataDa.age;
y = dataDa.F0amp;

% Define colors for each group
color_map = containers.Map({'Mus','Var','NMus'}, {mus_clr, var_clr, nmus_clr}); 

figure('units','inch','position',[1,1,3.54,3.54]);
subplot(2,2,1)
for ii=1:length(x)
    scatter(x(ii),y(ii),mark_ind,color_map(dataDa.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        dx = 0.1; dy = 0; % displacement so the text does not overlay the data points
        text(x(ii)+dx, y(ii)+dy, dataDa.subj_uni{ii},'Interpreter', 'none')
    end
end
annotation('arrow',[.3,.27],[.91,.915],'Linewidth',1,'Color',[0 0 0])

title('a              All Data                 ','fontweight','bold')
ylabel(['F0 Amplitude (',char(181),'V)'])

[r, p] = corr(x,y,'tail','left','type','Pearson'); % one-tailed test predicting a positive correlation
text(20, .65, ['n = ' num2str(length(x))],'fontweight','bold');
if p < .0001
    text(20, .6, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(20, .6, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end


% H2-H10 Amplitude
xh = dataDa.age; % Age
yh = dataDa.Hamp; % Individual amplitudes, averaged across H2-H10

subplot(2,2,2)
for ii=1:length(xh)
    scatter(xh(ii),yh(ii),mark_ind,color_map(dataDa.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        dx = 0.1; dy = 0; % displacement so the text does not overlay the data points
        text(xh(ii)+dx, yh(ii)+dy, dataDa.subj_uni{ii},'Interpreter', 'none')  
    end
end
annotation('arrow',[.74,.71],[.88,.887],'Linewidth',1)

ylim([0 .6])
title('b              All Data                 ','fontweight','bold')
ylabel(['H2-H10 Amplitude (',char(181),'V)'])

[rh, ph] = corr(xh,yh,'tail','left','type','Pearson'); % one-tailed test predicting a positive correlation
text(20, .46, ['n = ' num2str(length(xh))],'fontweight','bold');
if ph < .0001
    text(20, .42, ['{\itr} = ' num2str(round(rh,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(20, .42, ['{\itr} = ' num2str(round(rh,3)) ', {\itp} = ' num2str(round(ph,3))],'fontweight','bold');
end


%% OUTLIER REMOVED
% Correlations

% F0 Amplitude 
x_o = dataDa_noO.age;
y_o = dataDa_noO.F0amp;

% Define colors for each group
color_map = containers.Map({'Mus','Var','NMus'}, {mus_clr, var_clr, nmus_clr}); 

subplot(2,2,3)
for ii=1:length(x_o)
    scatter(x_o(ii),y_o(ii),mark_ind,color_map(dataDa_noO.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        dx = 0.1; dy = 0; % displacement so the text does not overlay the data points
        text(x_o(ii)+dx, y_o(ii)+dy, dataDa_noO.subj_uni{ii},'Interpreter', 'none')
    end
end
title('c      Outlier Removed         ','fontweight','bold')
ylabel(['F0 Amplitude (',char(181),'V)'])
xlabel('Age')
ylim([0 .33])

[r, p] = corr(x_o,y_o,'tail','left','type','Pearson'); % one-tailed test predicting a positive correlation
text(20, .25, ['n = ' num2str(length(x_o))],'fontweight','bold');
if p < .0001
    text(20, .23, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(20, .23, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end


% H2-H10 Amplitude
xh_o = dataDa_noO.age; % Age
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
title('d       Outlier Removed        ','fontweight','bold')
ylabel(['H2-H10 Amplitude (',char(181),'V)'])
xlabel('Age')

[rh, ph] = corr(xh_o,yh_o,'tail','left','type','Pearson'); 
text(20, .28, ['n = ' num2str(length(xh_o))],'fontweight','bold');
if ph < .0001
    text(20, .26, ['{\itr} = ' num2str(round(rh,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(20, .26, ['{\itr} = ' num2str(round(rh,3)) ', {\itp} = ' num2str(round(ph,3))],'fontweight','bold');
end

print('../../results/SupFig3','-dpng') 
