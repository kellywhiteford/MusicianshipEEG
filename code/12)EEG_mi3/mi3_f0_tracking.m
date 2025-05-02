% Calculates F0 tracking for all participants to /mi3/.
% Analysis matches Parbery-Clark et al. (Wong et al., 2007).

function [mi3_dat] = mi3_f0_tracking(excluded_subjs)
% Input
% excluded_subjs      : Array of subj_uni IDs with subjects to exclude.
% Output
% mi3_dat             : Structure
% mi3_dat.Stim2resp_r : Stimulus-to-response correlation (Pearson's r)
% mi3_dat.Stim2resp_z : Z-transformed stimulus-to-response correlation
% da_dat.subj_uni     : Subject and university ID

%% University file information
siteNames = {'BU','CMU','PU','UMN','UR','UWO'};
specificSubjs = 0; % set this to true to only analyze specific subjects

if specificSubjs
    subj = {'s1_umn','s2_umn','s22_umn'}; % List spefic subjects here!
    subj_file = strings([1,length(subj)]); % Preallocate string arrays with no characters
    for ii = 1:length(subj)
        subj_file{ii} = strcat('mi3_',subj{ii},'_Cz.mat');
    end
end

%% Resample stimulus to have same sampling rate as EEG data
[stimulus, Fs_stim] = audioread('mi3.wav'); % load stimulus
stim = resample(stimulus,16384,Fs_stim); % Resampled stim has a sampling rate of Fs (16384)
stim = stim';

f0Max_stim = slidingFFT_mi3(stim,zeros(1,737),16384,0,'yes','no'); % sliding FFT on stimulus

%% Load preprocessed Cz data and calculate average spectral amplitude
c = 0; 
mi3_dat.subj_uni = {};

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
        
        if ~strcmp(subj(s),excluded_subjs) % Only analyze subjects that are NOT on the excluded subjects list
            disp(['Processing ' subj{s} '...'])    
            load(subj_file{s});
            
            f0Max = slidingFFT_mi3(Cz.SumAvg,Cz.SumAvg_Baseline,Cz.Fs,Cz.FixedDelay_ms,'no','no'); % sliding FFT on EEG response
            stimToResp = round(corr(f0Max',f0Max_stim'),3); % F0 tracking stimulus-to-response correlation
            
            mi3_dat.Stim2resp_r(c+1) = stimToResp; % Pearson correlation coefficient 
            mi3_dat.Stim2resp_z(c+1) = atanh(stimToResp); % Fisher's r-to-z transform 
            
            mi3_dat.subj_uni = [mi3_dat.subj_uni; subj{s}];
            
            c = c + 1;
        elseif sum(strcmp(subj(s),excluded_subjs)) >= 1
            disp(['Excluding ' subj{s} ' from /mi3/ analyses.'])
        end
    end
    
    cd ../../../
end
cd ./code/12)EEG_mi3

save('mi3_dat','mi3_dat');