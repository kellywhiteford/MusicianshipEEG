function plotAllPartCorrs(dataDa,dataDa_noO,data_r,dataMi3,mark_ind,mus_clr,nmus_clr,var_clr,txt)

% Define colors for each group
color_map = containers.Map({'Mus','Var','NMus'}, {mus_clr, var_clr, nmus_clr}); 

indX = dataDa.subj_uni(isnan(dataDa.gender)); % subjIDs of participants that did not idenitfy as either male or female

% Confirmed that same subjects need to be excluded for all /da/ and /mi3/ measures
%dataMi3.subj_uni(isnan(dataMi3.gender))
%dataMi3_noO.subj_uni(isnan(dataMi3_noO.gender))
%data_rA.subj_uni(isnan(data_rA.gender))

dataDaMF = rmvSubjs(dataDa,indX);
dataDaMF_noO = rmvSubjs(dataDa_noO,indX);
data_rMF = rmvSubjs(data_r,indX);
dataMi3MF = rmvSubjs(dataMi3,indX);

indNaN = dataMi3MF.subj_uni(isnan(dataMi3MF.ageStart)); % remove participants with 0 yrs of musical training for age first started training correlations

dataMi3MF_A = rmvSubjs(dataMi3MF,indNaN); % Use this for correlations with "age first started training"

[~,~,da_F0_age] =  calcRegOnly(dataDaMF.age,dataDaMF.F0amp); % partial out age
[~,~,da_yrsMusF_age] =  calcRegOnly(dataDaMF.age,dataDaMF.yrsMusF); % partial out age
[~,~,da_H_age] =  calcRegOnly(dataDaMF.age,dataDaMF.Hamp); % partial out age
[~,~,da_r_age] =  calcRegOnly(data_rMF.age,data_rMF.z); % partial out age
[~,~,da_r_yrsMusF_age] =  calcRegOnly(data_rMF.age,data_rMF.yrsMusF); % partial out age
[~,~,da_noO_F0_age] =  calcRegOnly(dataDaMF_noO.age,dataDaMF_noO.F0amp); % partial out age
[~,~,da_noO_yrsMusF_age] =  calcRegOnly(dataDaMF_noO.age,dataDaMF_noO.yrsMusF); % partial out age
[~,~,da_noO_H_age] =  calcRegOnly(dataDaMF_noO.age,dataDaMF_noO.Hamp); % partial out age
[~,~,mi3_age] =  calcRegOnly(dataMi3MF.age,dataMi3MF.Stim2resp_z); % partial out age
[~,~,mi3_yrsMusF_age] =  calcRegOnly(dataMi3MF.age,dataMi3MF.yrsMusF); % partial out age
[~,~,mi3_A_ageStart_age] =  calcRegOnly(dataMi3MF_A.age,dataMi3MF_A.ageStart); % partial out age
[~,~,mi3_A_age] =  calcRegOnly(dataMi3MF_A.age,dataMi3MF_A.Stim2resp_z); % partial out age

[~,~,da_F0_age_gender] =  calcRegOnly(dataDaMF.gender,da_F0_age); % partial out gender
[~,~,da_yrsMusF_age_gender] =  calcRegOnly(dataDaMF.gender,da_yrsMusF_age); % partial out gender
[~,~,da_H_age_gender] =  calcRegOnly(dataDaMF.gender,da_H_age); % partial out gender
[~,~,da_r_age_gender] =  calcRegOnly(data_rMF.gender,da_r_age); % partial out gender
[~,~,da_r_yrsMusF_age_gender] =  calcRegOnly(data_rMF.gender,da_r_yrsMusF_age); % partial out gender
[~,~,da_noO_F0_age_gender] =  calcRegOnly(dataDaMF_noO.gender,da_noO_F0_age); % partial out gender
[~,~,da_noO_yrsMusF_age_gender] =  calcRegOnly(dataDaMF_noO.gender,da_noO_yrsMusF_age); % partial out gender
[~,~,da_noO_H_age_gender] =  calcRegOnly(dataDaMF_noO.gender,da_noO_H_age); % partial out gender
[~,~,mi3_age_gender] =  calcRegOnly(dataMi3MF.gender,mi3_age); % partial out gender
[~,~,mi3_yrsMusF_age_gender] =  calcRegOnly(dataMi3MF.gender,mi3_yrsMusF_age); % partial out gender
[~,~,mi3_A_ageStart_age_gender] =  calcRegOnly(dataMi3MF_A.gender,mi3_A_ageStart_age); % partial out gender
[~,~,mi3_A_age_gender] =  calcRegOnly(dataMi3MF_A.gender,mi3_A_age); % partial out gender

%[rp,p] = corr(da_yrsMusF_age_gender,da_F0_age_gender,'tail','right');  % equivalent to partial correlation controlling for age and gender
%[rp,p] = partialcorr(dataDaMF.yrsMusF,dataDaMF.F0amp,[dataDaMF.age,dataDaMF.gender],'tail','right')



%% Plot /da/ Residuals
figure('units','inch','position',[2,2,5.75,3]);
subplot(2,3,1)
for ii=1:length(da_F0_age_gender)
    scatter(da_yrsMusF_age_gender(ii),da_F0_age_gender(ii),mark_ind,color_map(dataDaMF.Group{ii}),'filled','MarkerEdgeColor','black'); 
    hold on
    if strcmp(txt,'on')
        hold on
        text(da_yrsMusF_age_gender(ii),da_F0_age_gender(ii), dataDaMF.subj_uni{ii});
    end
end
xlim([-10 31])
ylim([-.1 .8])
title('a       /da/: All Participants       ','fontweight','bold')
xlabel('Yrs. of Musical Training Residuals (A.U.)')
ylabel('F0 Amp. Residuals (A.U.)')
hold on

[rp,p] = partialcorr(dataDaMF.yrsMusF,dataDaMF.F0amp,[dataDaMF.age,dataDaMF.gender],'tail','right');
text(0, .7, ['n = ' num2str(length(da_yrsMusF_age_gender))],'fontweight','bold');
if p < .0001
    text(0, .62, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(0, .62, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

subplot(2,3,2)
for ii=1:length(da_H_age_gender)
    scatter(da_yrsMusF_age_gender(ii),da_H_age_gender(ii),mark_ind,color_map(dataDaMF.Group{ii}),'filled','MarkerEdgeColor','black'); 
    hold on
    if strcmp(txt,'on')
        hold on
        text(da_yrsMusF_age_gender(ii),da_H_age_gender(ii), dataDaMF.subj_uni{ii});
    end
end
xlim([-10 31])
ylim([-.1 .5])
title('b       /da/: All Participants       ','fontweight','bold')
xlabel('Yrs. of Musical Training Residuals (A.U.)')
ylabel('H2-H10 Amp. Residuals (A.U.)')
hold on

[rp,p] = partialcorr(dataDaMF.yrsMusF,dataDaMF.Hamp,[dataDaMF.age,dataDaMF.gender],'tail','right');
text(0, .46, ['n = ' num2str(length(da_yrsMusF_age_gender))],'fontweight','bold');
if p < .0001
    text(0, .41, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(0, .41, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

subplot(2,3,3)
for ii=1:length(da_r_age_gender)
    scatter(da_r_yrsMusF_age_gender(ii),da_r_age_gender(ii),mark_ind,color_map(data_rMF.Group{ii}),'filled','MarkerEdgeColor','black'); 
    hold on
    if strcmp(txt,'on')
        hold on
        text(da_r_yrsMusF_age_gender(ii),da_r_age_gender(ii), data_r.subj_uni{ii});
    end
end
xlim([-10 31])
ylim([-.1 .15])
title('c       /da/: All Participants       ','fontweight','bold')
xlabel('Yrs. of Musical Training Residuals (A.U.)')
ylabel('Stim-to-Resp. Residuals (A.U.)')
hold on

[rp,p] = partialcorr(data_rMF.yrsMusF,data_rMF.z,[data_rMF.age,data_rMF.gender],'tail','right');
text(0, .14, ['n = ' num2str(length(da_r_yrsMusF_age_gender))],'fontweight','bold');
if p < .0001
    text(0, .12, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(0, .12, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end


subplot(2,3,4)
for ii=1:length(da_noO_F0_age_gender)
    scatter(da_noO_yrsMusF_age_gender(ii),da_noO_F0_age_gender(ii),mark_ind,color_map(dataDaMF_noO.Group{ii}),'filled','MarkerEdgeColor','black'); 
    hold on
    if strcmp(txt,'on')
        hold on
        text(da_noO_yrsMusF_age_gender(ii),da_noO_F0_age_gender(ii), dataDaMF_noO.subj_uni{ii});
    end
end
xlim([-10 31])
ylim([-.1 .25])
title('d      /da/: Outlier Removed      ','fontweight','bold')
xlabel('Yrs. of Musical Training Residuals (A.U.)')
ylabel('F0 Amp. Residuals (A.U.)')
hold on

[rp,p] = partialcorr(dataDaMF_noO.yrsMusF,dataDaMF_noO.F0amp,[dataDaMF_noO.age,dataDaMF_noO.gender],'tail','right');
text(0, .19, ['n = ' num2str(length(da_noO_yrsMusF_age_gender))],'fontweight','bold');
if p < .0001
    text(0, .16, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(0, .16, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

subplot(2,3,5)
for ii=1:length(da_noO_H_age_gender)
    scatter(da_noO_yrsMusF_age_gender(ii),da_noO_H_age_gender(ii),mark_ind,color_map(dataDaMF_noO.Group{ii}),'filled','MarkerEdgeColor','black'); 
    hold on
    if strcmp(txt,'on')
        hold on
        text(da_noO_yrsMusF_age_gender(ii),da_noO_H_age_gender(ii), dataDaMF_noO.subj_uni{ii});
    end
end
xlim([-10 31])
ylim([-.1 .2])
title('e      /da/: Outlier Removed      ','fontweight','bold')
xlabel('Yrs. of Musical Training Residuals (A.U.)')
ylabel('H2-H10 Amp. Residuals (A.U.)')

[rp,p] = partialcorr(dataDaMF_noO.yrsMusF,dataDaMF_noO.Hamp,[dataDaMF_noO.age,dataDaMF_noO.gender],'tail','right');
text(-8, .18, ['n = ' num2str(length(da_noO_yrsMusF_age_gender))],'fontweight','bold');
if p < .0001
    text(-8, .155, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(-8, .155, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

figPath = ['../../results/','SupFig6'];
print(figPath,'-dpng') 

%% Plot /mi3/ Residuals
% figure('units','inch','position',[1,1,3.54,1.77]);
figure('units','inch','position',[1,1,4,1.77]);
subplot(1,2,1)
for ii=1:length(mi3_age_gender)
    scatter(mi3_yrsMusF_age_gender(ii),mi3_age_gender(ii),mark_ind,color_map(dataMi3MF.Group{ii}),'filled','MarkerEdgeColor','black'); 
    hold on
    if strcmp(txt,'on')
        hold on
        text(mi3_yrsMusF_age_gender(ii),mi3_age_gender(ii), dataMi3MF.subj_uni{ii});
    end
end
xlim([-9 26])
ylim([-1.5 1])
title('a        /mi3/: All Participants        ','fontweight','bold')
xlabel('Yrs. of Musical Training Residuals (A.U.)')
ylabel('F0 Stim-to-Resp. (A.U.)')
hold on

[rp,p] = partialcorr(dataMi3MF.yrsMusF,dataMi3MF.Stim2resp_z,[dataMi3MF.age,dataMi3MF.gender],'tail','right');
text(8, -1, ['n = ' num2str(length(mi3_yrsMusF_age_gender))],'fontweight','bold');
if p < .0001
    text(8, -1.17, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(8, -1.17, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

subplot(1,2,2)
for ii=1:length(mi3_A_age_gender)
    scatter(mi3_A_ageStart_age_gender(ii),mi3_A_age_gender(ii),mark_ind,color_map(dataMi3MF_A.Group{ii}),'filled','MarkerEdgeColor','black'); 
    hold on
    if strcmp(txt,'on')
        hold on
        text(mi3_A_ageStart_age_gender(ii),mi3_A_age_gender(ii), dataMi3MF_A.subj_uni{ii});
    end
end
xlim([-9 41])
ylim([-1.5 1])
title('b        /mi3/: All Participants        ','fontweight','bold')
xlabel('Age First Started Training Residuals (A.U.)')
ylabel('F0 Stim-to-Resp. (A.U.)')

[rp,p] = partialcorr(dataMi3MF_A.ageStart,dataMi3MF_A.Stim2resp_z,[dataMi3MF_A.age,dataMi3MF_A.gender],'tail','right');
text(14, -1, ['n = ' num2str(length(mi3_A_age_gender))],'fontweight','bold');
if p < .0001
    text(14, -1.17, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} < .0001'],'fontweight','bold');
else
    text(14, -1.17, ['{\itr_p} = ' num2str(round(rp,3)) ', {\itp} = ' num2str(round(p,3))],'fontweight','bold');
end

figPath = ['../../results/','SupFig9'];
print(figPath,'-dpng') 