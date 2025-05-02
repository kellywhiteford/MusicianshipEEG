cd ../../data/ExcelDataForAnalyses

%% F0 ENCODING - ALL PARTICIPANTS
%Grab site string
uniID = strings([1,length(dataMi3.subj_uni)])';
for ii=1:length(dataMi3.subj_uni)
    sUniName = dataMi3.subj_uni{ii};
    uniID(ii) = extractAfter(sUniName,'_');
end
site = siteCode(uniID); % convert uniID to number

% Note on Gender: 1 = Female, 2 = Male; NaN = "You don't have an option that applies to me."
colLabels = {'subjUni','Group','stim2resp_z','Age','YrsFormalTraining','AgeStart','dp','Gender','Site'};
xlswrite(['EEG_mi3(n=' num2str(length(mi3_dat.subj_uni)) ').xls'],colLabels,'allData','A1')
xlswrite(['EEG_mi3(n=' num2str(length(mi3_dat.subj_uni)) ').xls'],cellstr(dataMi3.subj_uni),'allData','A2')
xlswrite(['EEG_mi3(n=' num2str(length(mi3_dat.subj_uni)) ').xls'],cellstr(dataMi3.Group),'allData','B2')
xlswrite(['EEG_mi3(n=' num2str(length(mi3_dat.subj_uni)) ').xls'],dataMi3.Stim2resp_z,'allData','C2')
xlswrite(['EEG_mi3(n=' num2str(length(mi3_dat.subj_uni)) ').xls'],dataMi3.age,'allData','D2')
xlswrite(['EEG_mi3(n=' num2str(length(mi3_dat.subj_uni)) ').xls'],dataMi3.yrsMusF,'allData','E2')
xlswrite(['EEG_mi3(n=' num2str(length(mi3_dat.subj_uni)) ').xls'],dataMi3.ageStart,'allData','F2')
xlswrite(['EEG_mi3(n=' num2str(length(mi3_dat.subj_uni)) ').xls'],dataMi3.dp,'allData','G2')
xlswrite(['EEG_mi3(n=' num2str(length(mi3_dat.subj_uni)) ').xls'],dataMi3.gender,'allData','H2')
xlswrite(['EEG_mi3(n=' num2str(length(mi3_dat.subj_uni)) ').xls'],site,'allData','I2')

clear site uniID

%% /MI3/ AND /DA/ DATA FOR PARTICIPANTS WHO HAVE DATA FOR BOTH STUDIES
%Grab site string
uniID = strings([1,length(mi3DaOnly.subj_uni)])';
for ii=1:length(mi3DaOnly.subj_uni)
    sUniName = mi3DaOnly.subj_uni{ii};
    uniID(ii) = extractAfter(sUniName,'_');
end
site = siteCode(uniID); % convert uniID to number

colLabels = {'subjUni','Group','da_F0amp','da_Hamp','mi3_stim2resp_z','Age','YrsFormalTraining','AgeStart','Gender'};
xlswrite(['EEG_mi3Da(n=' num2str(length(mi3DaOnly.subj_uni)) ').xls'],colLabels,'allData','A1')
xlswrite(['EEG_mi3Da(n=' num2str(length(mi3DaOnly.subj_uni)) ').xls'],cellstr(mi3DaOnly.subj_uni),'allData','A2')
xlswrite(['EEG_mi3Da(n=' num2str(length(mi3DaOnly.subj_uni)) ').xls'],cellstr(mi3DaOnly.Group),'allData','B2')
xlswrite(['EEG_mi3Da(n=' num2str(length(mi3DaOnly.subj_uni)) ').xls'],mi3DaOnly.F0amp,'allData','C2')
xlswrite(['EEG_mi3Da(n=' num2str(length(mi3DaOnly.subj_uni)) ').xls'],mi3DaOnly.Hamp,'allData','D2')
xlswrite(['EEG_mi3Da(n=' num2str(length(mi3DaOnly.subj_uni)) ').xls'],mi3DaOnly.Stim2resp_z,'allData','E2')
xlswrite(['EEG_mi3Da(n=' num2str(length(mi3DaOnly.subj_uni)) ').xls'],mi3DaOnly.age,'allData','F2')
xlswrite(['EEG_mi3Da(n=' num2str(length(mi3DaOnly.subj_uni)) ').xls'],mi3DaOnly.yrsMusF,'allData','G2')
xlswrite(['EEG_mi3Da(n=' num2str(length(mi3DaOnly.subj_uni)) ').xls'],mi3DaOnly.ageStart,'allData','H2')
xlswrite(['EEG_mi3Da(n=' num2str(length(mi3DaOnly.subj_uni)) ').xls'],mi3DaOnly.gender,'allData','I2')
xlswrite(['EEG_mi3Da(n=' num2str(length(mi3DaOnly.subj_uni)) ').xls'],site,'allData','J2')

clear site uniID

%% MUSICAL ABILITY DATA
%Grab site string
uniID = strings([1,length(allMus.subj_uni)])';
for ii=1:length(allMus.subj_uni)
    sUniName = allMus.subj_uni{ii};
    uniID(ii) = extractAfter(sUniName,'_');
end
site = siteCode(uniID); % convert uniID to number

colLabels = {'subjUni','Group','dp','YrsFormalTraining','Site'};
xlswrite(['musicalAbility(n=' num2str(length(allMus.subj_uni)) ').xls'],colLabels,'allData','A1')
xlswrite(['musicalAbility(n=' num2str(length(allMus.subj_uni)) ').xls'],cellstr(allMus.subj_uni),'allData','A2')
xlswrite(['musicalAbility(n=' num2str(length(allMus.subj_uni)) ').xls'],cellstr(allMus.Group),'allData','B2')
xlswrite(['musicalAbility(n=' num2str(length(allMus.subj_uni)) ').xls'],allMus.dp,'allData','C2')
xlswrite(['musicalAbility(n=' num2str(length(allMus.subj_uni)) ').xls'],allMus.yrsMusF,'allData','D2')
xlswrite(['musicalAbility(n=' num2str(length(allMus.subj_uni)) ').xls'],site,'allData','E2')

clear site uniID

%% F0 TRACKING FOR NEW NOISE FLOOR CRITERION
%Grab site string
uniID = strings([1,length(dataMi3X.subj_uni)])';
for ii=1:length(dataMi3X.subj_uni)
    sUniName = dataMi3X.subj_uni{ii};
    uniID(ii) = extractAfter(sUniName,'_');
end
site = siteCode(uniID); % convert uniID to number

colLabels = {'subjUni','Group','stim2resp_z','Age','YrsFormalTraining','AgeStart','dp','Gender','Site'};
xlswrite(['EEG_mi3X(n=' num2str(length(dataMi3X.subj_uni)) ').xls'],colLabels,'allData','A1')
xlswrite(['EEG_mi3X(n=' num2str(length(dataMi3X.subj_uni)) ').xls'],cellstr(dataMi3X.subj_uni),'allData','A2')
xlswrite(['EEG_mi3X(n=' num2str(length(dataMi3X.subj_uni)) ').xls'],cellstr(dataMi3X.Group),'allData','B2')
xlswrite(['EEG_mi3X(n=' num2str(length(dataMi3X.subj_uni)) ').xls'],dataMi3X.Stim2resp_z,'allData','C2')
xlswrite(['EEG_mi3X(n=' num2str(length(dataMi3X.subj_uni)) ').xls'],dataMi3X.age,'allData','D2')
xlswrite(['EEG_mi3X(n=' num2str(length(dataMi3X.subj_uni)) ').xls'],dataMi3X.yrsMusF,'allData','E2')
xlswrite(['EEG_mi3X(n=' num2str(length(dataMi3X.subj_uni)) ').xls'],dataMi3X.ageStart,'allData','F2')
xlswrite(['EEG_mi3X(n=' num2str(length(dataMi3X.subj_uni)) ').xls'],dataMi3X.dp,'allData','G2')
xlswrite(['EEG_mi3X(n=' num2str(length(dataMi3X.subj_uni)) ').xls'],dataMi3X.gender,'allData','H2')
xlswrite(['EEG_mi3X(n=' num2str(length(dataMi3X.subj_uni)) ').xls'],site,'allData','I2')

clear site uniID

cd ../../code