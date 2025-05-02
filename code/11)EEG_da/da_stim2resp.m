%% Calculates stimulus-to-response correlations for /da/
% Analysis matches Parbery-Clark et al. (2009, JNeuro). 

function [stim2resp] = da_stim2resp
% Output
% stim2resp          : Structure
% stim2resp.r        : stimulus-to-response correlation for each subject
% stim2resp.z        : Fisher's r-to-z transform of stim2resp.r
% stim2resp.subj_uni : Subject and university ID

%% University file information
siteNames = {'BU','CMU','PU','UMN','UR','UWO'};
specificSubjs = 0; % set this to true to only analyze specific subjects

if specificSubjs
    subj = {'s1_umn','s2_umn','s22_umn'}; % List spefic subjects here!
    subj_file = strings([1,length(subj)]); % Preallocate string arrays with no characters
    for ii = 1:length(subj)
        subj_file{ii} = strcat('da_',subj{ii},'_Cz.mat');
    end
end

%% Resample stimulus to have same sampling rate as EEG data
[stimulus, Fs_stim] = audioread('DAbase_resampled.wav'); % load stimulus
fs = 16384;
stim = resample(stimulus,fs,Fs_stim); % Resampled stim has a sampling rate of Fs (16384)
stim = stim';

minTime_stim = 50; % Time where steady-state portion begins (ms)
maxTime_stim = 170; % Time where steady-state portion ends (ms) - this is the end of the stimulus
minSamp_stim = round(minTime_stim * fs/1000); % convert ms to samples
maxSamp_stim = round(maxTime_stim * fs/1000); % convert ms to samples
steadyState_stim = stim(1,minSamp_stim:maxSamp_stim); % just the steady-state response to /da/

%% Load preprocessed Cz data and stimulus-to-response correlation
c = 1; 
stim2resp.subj_uni = {};
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
        
        avgDat = Cz.SumAvg;
        Fs = Cz.Fs;
        minTime = 60; % Time where steady-state portion begins (ms)
        maxTime = 180; % Time where steady-state portion ends (ms)
        minSamp = round(minTime * Fs/1000); % convert ms to samples
        maxSamp = round(maxTime * Fs/1000); % convert ms to samples
        steadyState_resp = avgDat(1,minSamp:maxSamp); % just the steady-state response to /da/
        
        rs = xcorr(steadyState_stim,steadyState_resp,'coeff'); % Cross-correlations for all lag times
        best_corr = round(max(rs),3);

        stim2resp.r(c) = best_corr;
        stim2resp.z(c) = atanh(best_corr);
        stim2resp.subj_uni = [stim2resp.subj_uni; subj{s}];
        
        c = c + 1;
    end
    
    cd ../../../
end
cd ./code/11)EEG_da

save('stim2resp','stim2resp');