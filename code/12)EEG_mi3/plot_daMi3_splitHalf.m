% Plots spectral amplitudes for first and second half of /da/ data
function plot_daMi3_splitHalf(dataDa_s,dataDa_s_noO,data_rA_s,dataMi3_s,mark_ind,mus_clr,nmus_clr,var_clr,txt)
% dataDa_s     : structure with da split-half spectral amplitude data for each subject
% dataDa_s_noO : structure with da split-half spectral amplitude data with outlier removed
% data_rA_s    : structure of /da/ split-half site-adjusted stimulus-to-response correlations
% dataMi3_s    : structure of /mi3/ F0 stimulus-to-response correlations
% mark_ind : marker size for individual data
% mus_clr  : color of musician datapoints
% nmus_clr : color of non-musician datapoints
% var_clr  : color of variable datapoints

%% /DA/ F0 ENCODING SPLIT-HALF RELIABILITY

x = dataDa_s.F0amp_h1; % first half
y = dataDa_s.F0amp_h2; % second half

% Define colors for each group
color_map = containers.Map({'Mus','Var','NMus'}, {mus_clr, var_clr, nmus_clr}); 

figure('units','inch','position',[1,1,4.1,3.7]);
subplot(2,2,1)
for ii=1:length(x)
    scatter(x(ii),y(ii),mark_ind,color_map(dataDa_s.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x(ii), y(ii), dataDa_s.subj_uni{ii});
    end
end
plot(0:.025:.8,0:.025:.8,'--k')

title('a                    /da/: F0                      ','fontweight','bold')
ylabel('Second Half')
xlabel('First Half')

[r, p] = corr(x,y,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(.1, .7, ['n = ' num2str(length(x))],'fontweight','bold');
if p < .0001
    text(.1, .65, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.1, .65, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

%% /DA/ UPPER HARMONICS SPLIT-HALF RELIABILITY
x2 = dataDa_s.Hamp_h1; % first half
y2 = dataDa_s.Hamp_h2; % second half

subplot(2,2,2)
for ii=1:length(x2)
    scatter(x2(ii),y2(ii),mark_ind,color_map(dataDa_s.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x2(ii), y2(ii), dataDa_s.subj_uni{ii});
    end
end
plot(0:.025:.6,0:.025:.6,'--k')

title('b              /da/: H2-H10                 ','fontweight','bold')
ylabel('Second Half')
xlabel('First Half')

[r, p] = corr(x2,y2,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(.1, .56, ['n = ' num2str(length(x2))],'fontweight','bold');
if p < .0001
    text(.1, .52, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.1, .52, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

%% /DA/ STIMULUS-TO-RESPONSE CORRELATION RELIABILITY
x3 = data_rA_s.r_lim_h1; % first half
y3 = data_rA_s.r_lim_h2; % second half

zx3 = data_rA_s.z_lim_h1; % first half
zy3 = data_rA_s.z_lim_h2; % second half

subplot(2,2,3)
for ii=1:length(x3)
    scatter(x3(ii),y3(ii),mark_ind,color_map(dataDa_s.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x3(ii), y3(ii), data_rA_s.subj_uni{ii});
    end
end
plot(-.1:.005:.3,-.1:.005:.3,'--k')

title('c /da/: Stimulus-to-Response ({\itr}) ','fontweight','bold')
ylabel('Second Half')
xlabel('First Half')

[r, p] = corr(zx3,zy3,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(-.05, .27, ['n = ' num2str(length(zx3))],'fontweight','bold');
if p < .0001
    text(-.05, .25, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(-.05, .25, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

%% /MI3/ F0 STIMULUS-TO-RESPONSE CORRELATION RELIABILITY
x4 = dataMi3_s.Stim2resp_r_h1;
y4 = dataMi3_s.Stim2resp_r_h2;

subplot(2,2,4)
for ii=1:length(x4)
    scatter(x4(ii),y4(ii),mark_ind,color_map(dataMi3_s.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x3(ii), y3(ii), dataMi3_s.subj_uni{ii});
    end
end
xlim([-.7 1])
ylim([-.7 1])
plot(-.7:.005:1,-.7:.005:1,'--k')

title('d /mi3/: F0 Stim.-to-Response ({\itr})','fontweight','bold')
ylabel('Second Half')
xlabel('First Half')


[r, p] = corr(dataMi3_s.Stim2resp_z_h1,dataMi3_s.Stim2resp_z_h2,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(-.6, .95, ['n = ' num2str(length(x4))],'fontweight','bold');
if p < .0001
    text(-.6, .86, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(-.6, .86, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

figPath = ['../../results/','SupFig19'];
print(figPath,'-dpng') 

%% /DA/ RELIABILTY WITH OUTLIER REMOVED
% F0
x1_noO = dataDa_s_noO.F0amp_h1; % first half
y1_noO = dataDa_s_noO.F0amp_h2; % second half

figure('units','inch','position',[1,1,4,2]);
subplot(1,2,1)
for ii=1:length(x1_noO)
    scatter(x1_noO(ii),y1_noO(ii),mark_ind,color_map(dataDa_s_noO.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x1_noO(ii), y1_noO(ii), dataDa_s_noO.subj_uni{ii});
    end
end
plot(0:.025:.4,0:.025:.4,'--k')

title('a                   /da/: F0                     ','fontweight','bold')
ylabel('Second Half')
xlabel('First Half')

[r, p] = corr(x1_noO,y1_noO,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(.1, .37, ['n = ' num2str(length(x1_noO))],'fontweight','bold');
if p < .0001
    text(.1, .35, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.1, .35, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

% Upper harmonics
x2_noO = dataDa_s_noO.Hamp_h1; % first half
y2_noO = dataDa_s_noO.Hamp_h2; % second half

subplot(1,2,2)
for ii=1:length(x2_noO)
    scatter(x2_noO(ii),y2_noO(ii),mark_ind,color_map(dataDa_s_noO.Group{ii}),'filled','MarkerEdgeColor','black');
    hold on
    if strcmp(txt,'on')
        hold on
        text(x2_noO(ii), y2_noO(ii), dataDa_s_noO.subj_uni{ii});
    end
end
plot(0:.025:.4,0:.025:.4,'--k')

title('b               /da/: H2-H10                 ','fontweight','bold')
ylabel('Second Half')
xlabel('First Half')

[r, p] = corr(x2_noO,y2_noO,'tail','right','type','Pearson'); % one-tailed test predicting a positive correlation
text(.1, .37, ['n = ' num2str(length(x2_noO))],'fontweight','bold');
if p < .0001
    text(.1, .35, ['{\itr} = ' num2str(round(r,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(.1, .35, ['{\itr} = ' num2str(round(r,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

figPath = ['../../results/','SupFig20'];
print(figPath,'-dpng') 