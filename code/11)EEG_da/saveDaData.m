cd ../../data/ExcelDataForAnalyses

%% SPECTRAL ENCODING - ALL PARTICIPANTS
%Grab site string
uniID = strings([1,length(dataDa.subj_uni)])';
for ii=1:length(dataDa.subj_uni)
    sUniName = dataDa.subj_uni{ii};
    uniID(ii) = extractAfter(sUniName,'_');
end
site = siteCode(uniID); % convert uniID to number

% Note on Gender: 1 = Female, 2 = Male; NaN = "You don't have an option that applies to me."
colLabels = {'subjUni','Group','F0','UpperHarmonics','Age','YrsFormalTraining','dp','Gender','Site'};

xlswrite(['EEG_da(n=' num2str(length(da_dat.subj_uni)) ').xls'],colLabels,'allData','A1')
xlswrite(['EEG_da(n=' num2str(length(da_dat.subj_uni)) ').xls'],cellstr(dataDa.subj_uni),'allData','A2')
xlswrite(['EEG_da(n=' num2str(length(da_dat.subj_uni)) ').xls'],cellstr(dataDa.Group),'allData','B2')
xlswrite(['EEG_da(n=' num2str(length(da_dat.subj_uni)) ').xls'],dataDa.F0amp,'allData','C2')
xlswrite(['EEG_da(n=' num2str(length(da_dat.subj_uni)) ').xls'],dataDa.Hamp,'allData','D2')
xlswrite(['EEG_da(n=' num2str(length(da_dat.subj_uni)) ').xls'],dataDa.age,'allData','E2')
xlswrite(['EEG_da(n=' num2str(length(da_dat.subj_uni)) ').xls'],dataDa.yrsMusF,'allData','F2')
xlswrite(['EEG_da(n=' num2str(length(da_dat.subj_uni)) ').xls'],dataDa.dp,'allData','G2')
xlswrite(['EEG_da(n=' num2str(length(da_dat.subj_uni)) ').xls'],dataDa.gender,'allData','H2')
xlswrite(['EEG_da(n=' num2str(length(da_dat.subj_uni)) ').xls'],site,'allData','I2')

clear site uniID

%% STIMULUS-TO-RESPONSE CORRELATIONS
%Grab site string
uniID = strings([1,length(data_r.subj_uni)])';
for ii=1:length(data_r.subj_uni)
    sUniName = data_r.subj_uni{ii};
    uniID(ii) = extractAfter(sUniName,'_');
end
site = siteCode(uniID); % convert uniID to number

colLabels_r = {'subjUni','Group','stim2resp_z','Age','YrsFormalTraining','dp','Gender','Site'};
xlswrite(['EEG_da_r(n=' num2str(length(data_r.subj_uni)) ').xls'],colLabels_r,'allData','A1')
xlswrite(['EEG_da_r(n=' num2str(length(data_r.subj_uni)) ').xls'],cellstr(data_r.subj_uni),'allData','A2')
xlswrite(['EEG_da_r(n=' num2str(length(data_r.subj_uni)) ').xls'],cellstr(data_r.Group),'allData','B2')
xlswrite(['EEG_da_r(n=' num2str(length(data_r.subj_uni)) ').xls'],data_r.z,'allData','C2')
xlswrite(['EEG_da_r(n=' num2str(length(data_r.subj_uni)) ').xls'],data_r.age,'allData','D2')
xlswrite(['EEG_da_r(n=' num2str(length(data_r.subj_uni)) ').xls'],data_r.yrsMusF,'allData','E2')
xlswrite(['EEG_da_r(n=' num2str(length(data_r.subj_uni)) ').xls'],data_r.dp,'allData','F2')
xlswrite(['EEG_da_r(n=' num2str(length(data_r.subj_uni)) ').xls'],data_r.gender,'allData','G2')
xlswrite(['EEG_da_r(n=' num2str(length(data_r.subj_uni)) ').xls'],site,'allData','H2')

clear site uniID

%% SITE-ADJUSTED STIMULUS-TO-RESPONSE CORRELATIONS
%Grab site string
uniID = strings([1,length(data_rA.subj_uni)])';
for ii=1:length(data_rA.subj_uni)
    sUniName = data_rA.subj_uni{ii};
    uniID(ii) = extractAfter(sUniName,'_');
end
site = siteCode(uniID); % convert uniID to number

colLabels_rA = {'subjUni','Group','stim2resp_z_adjusted','Age','YrsFormalTraining','dp','Gender','Site'};
xlswrite(['EEG_da_r_adjusted(n=' num2str(length(data_rA.subj_uni)) ').xls'],colLabels_rA,'allData','A1')
xlswrite(['EEG_da_r_adjusted(n=' num2str(length(data_rA.subj_uni)) ').xls'],cellstr(data_rA.subj_uni),'allData','A2')
xlswrite(['EEG_da_r_adjusted(n=' num2str(length(data_rA.subj_uni)) ').xls'],cellstr(data_rA.Group),'allData','B2')
xlswrite(['EEG_da_r_adjusted(n=' num2str(length(data_rA.subj_uni)) ').xls'],data_rA.z_lim,'allData','C2')
xlswrite(['EEG_da_r_adjusted(n=' num2str(length(data_rA.subj_uni)) ').xls'],data_rA.age,'allData','D2')
xlswrite(['EEG_da_r_adjusted(n=' num2str(length(data_rA.subj_uni)) ').xls'],data_rA.yrsMusF,'allData','E2')
xlswrite(['EEG_da_r_adjusted(n=' num2str(length(data_rA.subj_uni)) ').xls'],data_rA.dp,'allData','F2')
xlswrite(['EEG_da_r_adjusted(n=' num2str(length(data_rA.subj_uni)) ').xls'],data_rA.gender,'allData','G2')
xlswrite(['EEG_da_r_adjusted(n=' num2str(length(data_rA.subj_uni)) ').xls'],site,'allData','H2')

clear site uniID

%% POOR SNR SUBJECTS EXCLUDED - SPECTRAL ENCODING
%Grab site string
uniID = strings([1,length(dataDaX.subj_uni)])';
for ii=1:length(dataDaX.subj_uni)
    sUniName = dataDaX.subj_uni{ii};
    uniID(ii) = extractAfter(sUniName,'_');
end
site = siteCode(uniID); % convert uniID to number

colLabels = {'subjUni','Group','F0','UpperHarmonics','Age','YrsFormalTraining','dp','Gender','Site'};
xlswrite(['EEG_daX(n=' num2str(length(dataDaX.subj_uni)) ').xls'],colLabels,'allData','A1')
xlswrite(['EEG_daX(n=' num2str(length(dataDaX.subj_uni)) ').xls'],cellstr(dataDaX.subj_uni),'allData','A2')
xlswrite(['EEG_daX(n=' num2str(length(dataDaX.subj_uni)) ').xls'],cellstr(dataDaX.Group),'allData','B2')
xlswrite(['EEG_daX(n=' num2str(length(dataDaX.subj_uni)) ').xls'],dataDaX.F0amp,'allData','C2')
xlswrite(['EEG_daX(n=' num2str(length(dataDaX.subj_uni)) ').xls'],dataDaX.Hamp,'allData','D2')
xlswrite(['EEG_daX(n=' num2str(length(dataDaX.subj_uni)) ').xls'],dataDaX.age,'allData','E2')
xlswrite(['EEG_daX(n=' num2str(length(dataDaX.subj_uni)) ').xls'],dataDaX.yrsMusF,'allData','F2')
xlswrite(['EEG_daX(n=' num2str(length(dataDaX.subj_uni)) ').xls'],dataDaX.dp,'allData','G2')
xlswrite(['EEG_daX(n=' num2str(length(dataDaX.subj_uni)) ').xls'],dataDaX.gender,'allData','H2')
xlswrite(['EEG_daX(n=' num2str(length(dataDaX.subj_uni)) ').xls'],site,'allData','I2')

clear site uniID

%% POOR SNR SUBJECTS EXCLUDED - STIMULUS-TO-RESPONSE CORRELATIONS
%Grab site string
uniID = strings([1,length(dataX_r.subj_uni)])';
for ii=1:length(dataX_r.subj_uni)
    sUniName = dataX_r.subj_uni{ii};
    uniID(ii) = extractAfter(sUniName,'_');
end
site = siteCode(uniID); % convert uniID to number

colLabels_r = {'subjUni','Group','stim2resp_z','Age','YrsFormalTraining','dp','Gender','Site'};
xlswrite(['EEG_daX_r(n=' num2str(length(dataX_r.subj_uni)) ').xls'],colLabels_r,'allData','A1')
xlswrite(['EEG_daX_r(n=' num2str(length(dataX_r.subj_uni)) ').xls'],cellstr(dataX_r.subj_uni),'allData','A2')
xlswrite(['EEG_daX_r(n=' num2str(length(dataX_r.subj_uni)) ').xls'],cellstr(dataX_r.Group),'allData','B2')
xlswrite(['EEG_daX_r(n=' num2str(length(dataX_r.subj_uni)) ').xls'],dataX_r.z,'allData','C2')
xlswrite(['EEG_daX_r(n=' num2str(length(dataX_r.subj_uni)) ').xls'],dataX_r.age,'allData','D2')
xlswrite(['EEG_daX_r(n=' num2str(length(dataX_r.subj_uni)) ').xls'],dataX_r.yrsMusF,'allData','E2')
xlswrite(['EEG_daX_r(n=' num2str(length(dataX_r.subj_uni)) ').xls'],dataX_r.dp,'allData','F2')
xlswrite(['EEG_daX_r(n=' num2str(length(dataX_r.subj_uni)) ').xls'],dataX_r.gender,'allData','G2')
xlswrite(['EEG_daX_r(n=' num2str(length(dataX_r.subj_uni)) ').xls'],site,'allData','H2')

clear site uniID

%% POOR SNR SUBJECTS EXCLUDED - SITE-ADJUSTED STIMULUS-TO-RESPONSE CORRELATIONS
%Grab site string
uniID = strings([1,length(dataX_rA.subj_uni)])';
for ii=1:length(dataX_rA.subj_uni)
    sUniName = dataX_rA.subj_uni{ii};
    uniID(ii) = extractAfter(sUniName,'_');
end
site = siteCode(uniID); % convert uniID to number

colLabels_rA = {'subjUni','Group','stim2resp_z_adjusted','Age','YrsFormalTraining','dp','Gender','Site'};
xlswrite(['EEG_daX_r_adjusted(n=' num2str(length(dataX_rA.subj_uni)) ').xls'],colLabels_rA,'allData','A1')
xlswrite(['EEG_daX_r_adjusted(n=' num2str(length(dataX_rA.subj_uni)) ').xls'],cellstr(dataX_rA.subj_uni),'allData','A2')
xlswrite(['EEG_daX_r_adjusted(n=' num2str(length(dataX_rA.subj_uni)) ').xls'],cellstr(dataX_rA.Group),'allData','B2')
xlswrite(['EEG_daX_r_adjusted(n=' num2str(length(dataX_rA.subj_uni)) ').xls'],dataX_rA.z_lim,'allData','C2')
xlswrite(['EEG_daX_r_adjusted(n=' num2str(length(dataX_rA.subj_uni)) ').xls'],dataX_rA.age,'allData','D2')
xlswrite(['EEG_daX_r_adjusted(n=' num2str(length(dataX_rA.subj_uni)) ').xls'],dataX_rA.yrsMusF,'allData','E2')
xlswrite(['EEG_daX_r_adjusted(n=' num2str(length(dataX_rA.subj_uni)) ').xls'],dataX_rA.dp,'allData','F2')
xlswrite(['EEG_daX_r_adjusted(n=' num2str(length(dataX_rA.subj_uni)) ').xls'],dataX_rA.gender,'allData','G2')
xlswrite(['EEG_daX_r_adjusted(n=' num2str(length(dataX_rA.subj_uni)) ').xls'],site,'allData','H2')

clear site uniID

cd ../../code