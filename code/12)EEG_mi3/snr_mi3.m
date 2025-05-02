function [rms_mi3] = snr_mi3
% Output
% rms_mi3          : Structure
% rms_mi3.subj_uni : Subject and university ID
% rms_mi3.Cz       : rms amplitude during stimulus presentation
% rms_mi3.baseline : rms amplitude during baseline period
% rms_mi3.snr      : rms during stimulus period divided by baseline period

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
rms_mi3.subj_uni = {};

cd ../../
for uni = 1:length(siteNames)
    
    cd(['./data/',siteNames{uni},'/mi3_Preprocessed_Cz'])
    
    if ~specificSubjs % For preprocessing all subjects
        Files=dir('*.*'); % Lists all data file names
        
        % Preallocate string arrays with no characters
        subj_file = strings([1,length(Files)-2]);
        subj = strings([1,length(Files)-2]);
        
        for k=3:length(Files)
            subj_file{k-2} = Files(k).name; % subject-specific file name
            subj(k-2) = extractBefore(extractAfter(subj_file{k-2},'mi3_'),'_Cz.mat'); % subj_uni ID
        end
    end
    
    for s = 1:size(subj,2)
        
        load(subj_file{s});
        
        
        if uni == 1
            rms_mi3.Cz(s) = rms(Cz.SumAvg);
            rms_mi3.baseline(s) = rms(Cz.SumAvg_Baseline);
            rms_mi3.snr(s) = rms_mi3.Cz(s)/rms_mi3.baseline(s);
          
        else
            rms_mi3.Cz(c+1) = rms(Cz.SumAvg);
            rms_mi3.baseline(c+1) = rms(Cz.SumAvg_Baseline);
            rms_mi3.snr(c+1) = rms_mi3.Cz(c+1)/rms_mi3.baseline(c+1);
          
        end
        rms_mi3.subj_uni = [rms_mi3.subj_uni; subj{s}];
        
        c = c + 1;
    end
    
    cd ../../../
end
cd ./code/12)EEG_mi3

save('rms_mi3','rms_mi3');

