function [rms_da] = snr_da
% Output
% rms_da          : Structure
% rms_da.subj_uni : Subject and university ID
% rms_da.Cz       : rms amplitude during stimulus presentation
% rms_da.baseline : rms amplitude during baseline period
% rms_da.snr      : rms during stimulus period divided by baseline period
% da_dat.subj_uni : Subject and university ID

%% University file information
siteNames = {'BU','CMU','PU','UMN','UR','UWO'};
specificSubjs = 0; % set this to true to only analyze specific subjects

if specificSubjs
    subj = {'s1_umn','s2_umn','s22_umn'}; % List spefic subjects here!
%     subj = {'s2_umn','s22_umn', 's30_umn','s28_umn','s34_umn','s32_umn','s41_umn','s52_umn',...
%         's4_umn','s35_umn','s38_umn','s9_umn','s45_umn','s9_umn','s29_umn'}; % List spefic subjects here!
    subj_file = strings([1,length(subj)]); % Preallocate string arrays with no characters
    for ii = 1:length(subj)
        subj_file{ii} = strcat('da_',subj{ii},'_Cz.mat');
    end
end

%% Load preprocessed Cz data and calculate average spectral amplitude
c = 0; 
rms_da.subj_uni = {};
cd ../../
for uni = 1:length(siteNames)
    
    cd(['./data/',siteNames{uni},'/da_Preprocessed_Cz'])
    
    if ~specificSubjs % For preprocessing all subjects
        Files=dir('*.*'); % Lists all data file names
        
        % Preallocate string arrays with no characters
        subj_file = strings([1,length(Files)-2]);
        subj = strings([1,length(Files)-2]);
        
        for k=3:length(Files)
            subj_file{k-2} = Files(k).name; % subject-specific file name
            subj(k-2) = extractBefore(extractAfter(subj_file{k-2},'da_'),'_Cz.mat'); % subj_uni ID
        end
    end
    
    for s = 1:size(subj,2)
        
        load(subj_file{s});
        
        
        if uni == 1
            rms_da.Cz(s) = rms(Cz.SumAvg);
            rms_da.baseline(s) = rms(Cz.SumAvg_Baseline);
            rms_da.snr(s) = rms_da.Cz(s)/rms_da.baseline(s);
          
        else
            rms_da.Cz(c+1) = rms(Cz.SumAvg);
            rms_da.baseline(c+1) = rms(Cz.SumAvg_Baseline);
            rms_da.snr(c+1) = rms_da.Cz(c+1)/rms_da.baseline(c+1);
          
        end
        rms_da.subj_uni = [rms_da.subj_uni; subj{s}];
        
        c = c + 1;
    end
    
    cd ../../../
end
cd ./code/11)EEG_da
save('rms_da','rms_da');

