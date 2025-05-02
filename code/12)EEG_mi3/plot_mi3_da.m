% Plots between-experiment correlations for /da/ and /mi3/
function plot_mi3_da(mi3DaOnly,mi3DaOnly_noO, dataDa, dataDa_noO, mark_ind, mus_clr,nmus_clr,var_clr,txt)
% mi3DaOnly   : structure with /mi3/ and /da/ data for subjects that met inclusion criteria for both experiments
% mark_avg    : marker size for group-average data
% mus_clr     : color of musician datapoints
% nmus_clr    : color of non-musician datapoints

%% PLOT ALL DATA
% All stimulus-to-response correlations 
x = mi3DaOnly.F0amp; % F0 spectral encoding for /da/ in babble
x2 = mi3DaOnly.Hamp; % spectral encoding of the upper harmonics for /da/ in babble
y = mi3DaOnly.Stim2resp_r; % Individual stimulus-to-response correlations for /mi3/
z = mi3DaOnly.Stim2resp_z; % Individual z-transformed data for analyses for /mi3/

x3 = dataDa.F0amp;
y3 = dataDa.Hamp;

x4 = mi3DaOnly_noO.F0amp; % outlier non-musician removed
y4 = mi3DaOnly_noO.Stim2resp_r;
z4 = mi3DaOnly_noO.Stim2resp_z;

x5 = mi3DaOnly_noO.Hamp;
y5 = y4;
z5 = z4;

x6 = dataDa_noO.F0amp;
y6 = dataDa_noO.Hamp;

% Define colors for each group
color_map = containers.Map({'Mus','Var','NMus'}, {mus_clr, var_clr, nmus_clr}); 

figure('units','inch','position',[2,2,5.75,3]);
subplot(2,3,1)
for ii=1:length(x)
    scatter(x(ii),y(ii),mark_ind,color_map(mi3DaOnly.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x(ii), y(ii), mi3DaOnly.subj_uni{ii});
    end
end
title('a          All Participants            ','fontweight','bold')
ylabel('/mi3/ Stimulus-to-Response ({\itr})')
xlabel('/da/ F0 Amplitude')

[r, p] = corr(x,z,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(.2, -.5, ['n = ' num2str(length(x))],'fontweight','bold');
if p < .0001
    text(.2, -.62, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.2, -.62, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

subplot(2,3,2)
for ii=1:length(x2)
    scatter(x2(ii),y(ii),mark_ind,color_map(mi3DaOnly.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x2(ii), y(ii), mi3DaOnly.subj_uni{ii});
    end
end
title('b          All Participants            ','fontweight','bold')
ylabel('/mi3/ Stimulus-to-Response ({\itr})')
xlabel('/da/ H2-H10 Amplitude')

[r, p] = corr(x2,z,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(.1, -.5, ['n = ' num2str(length(x2))],'fontweight','bold');
if p < .0001
    text(.1, -.62, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.1, -.62, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

subplot(2,3,3)
for ii=1:length(x3)
    scatter(x3(ii),y3(ii),mark_ind,color_map(dataDa.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x3(ii), y3(ii), dataDa.subj_uni{ii});
    end
end
title('c          All Participants            ','fontweight','bold')
ylabel('/da/ H2-H10 Amplitude')
xlabel('/da/ F0 Amplitude')

[r, p] = corr(x3,y3,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(.15, .5, ['n = ' num2str(length(x3))],'fontweight','bold');
if p < .0001
    text(.15, .45, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.15, .45, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

%% No Outlier
%figure('units','inch','position',[2,2,8,2.25]);
subplot(2,3,4)
for ii=1:length(x4)
    scatter(x4(ii),y4(ii),mark_ind,color_map(mi3DaOnly_noO.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x5(ii), y5(ii), mi3DaOnly_noO.subj_uni{ii});
    end
end
title('d        Outlier Removed           ','fontweight','bold')
ylabel('/mi3/ Stimulus-to-Response ({\itr})')
xlabel('/da/ F0 Amplitude')

[r, p] = corr(x4,z4,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(.12, -.5, ['n = ' num2str(length(x4))],'fontweight','bold');
if p < .0001
    text(.12, -.62, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.12, -.62, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end


subplot(2,3,5)
for ii=1:length(x5)
    scatter(x5(ii),y5(ii),mark_ind,color_map(mi3DaOnly_noO.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x5(ii), y5(ii), mi3DaOnly_noO.subj_uni{ii});
    end
end
title('e        Outlier Removed           ','fontweight','bold')
ylabel('/mi3/ Stimulus-to-Response ({\itr})')
xlabel('/da/ H2-H10 Amplitude')

[r, p] = corr(x5,z5,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(.12, -.56, ['n = ' num2str(length(x5))],'fontweight','bold');
if p < .0001
    text(.12, -.68, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.12, -.68, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end


subplot(2,3,6)
for ii=1:length(x6)
    scatter(x6(ii),y6(ii),mark_ind,color_map(dataDa_noO.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x6(ii), y6(ii), dataDa_noO.subj_uni{ii});
    end
end
title('f        Outlier Removed           ','fontweight','bold')
ylabel('/da/ H2-H10 Amplitude')
xlabel('/da/ F0 Amplitude')

[r, p] = corr(x6,y6,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(.12, .28, ['n = ' num2str(length(x6))],'fontweight','bold');
if p < .0001
    text(.12, .26, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.12, .26, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

print('../../results/SupFig10','-dpng') 