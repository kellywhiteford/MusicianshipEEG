%% Calculates stimulus-to-response correlations for /da/, adjusting for site-specific time delays
% Takes into account the time between the onset of the stimulus at the
% transducer and the time it takes for the stimulus to get to the ear
% canal; in Parbery-Clark et al. (2009), this time was 1.1 ms.
% Analysis matches Parbery-Clark et al. (2009, JNeuro).

function [stim2resp_adjusted] = da_stim2resp_adjusted
% Output
% stim2resp_adjusted          : Structure
% stim2resp_adjusted.r        : stimulus-to-response correlation for each subject
% stim2resp_adjusted.z        : Fisher's r-to-z transform of stim2resp.r
% stim2resp_adjusted.subj_uni : Subject and university ID

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
stim2resp_adjusted.subj_uni = {};
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
        ParberyClark_fixedDelay = 1.1; % stimulus transmission delay from ER-3 to ear insert (ms)
        minTime = 50; % Time where steady-state portion begins (ms)
        maxTime = 200; % Time where steady-state portion ends (ms)
        minSamp = round(minTime * Fs/1000); % convert ms to samples
        maxSamp = round(maxTime * Fs/1000); % convert ms to samples
        steadyState_resp = avgDat(1,minSamp:maxSamp); % just the steady-state response to /da/
        
        extra_length = length(steadyState_resp) - length(steadyState_stim); 
        extra_zeros = zeros(1,extra_length);
        
        steadyState_stim_new = [steadyState_stim, extra_zeros]; % append extra zeros to the stimulus so it matches the length of the response
        
        % Positive lags: Correspond to samples that the STIMULUS is delayed
        % Negative algs: Correspond to samples that the RESPONSE is delayed
        [rs, lags] = xcorr(steadyState_resp,steadyState_stim_new,'coeff'); % Cross-correlations for all lag times
        best_corr = round(max(rs),3); % maximum cross-correlation across all possible lag times
        
        minShiftTime = 8-ParberyClark_fixedDelay+Cz.FixedDelay_ms; % minimum stimulus lag time (ms) from Parbery-Clark et al. (2009), subtracting out their fixed delay
        maxShiftTime = 12-ParberyClark_fixedDelay+Cz.FixedDelay_ms; % maxmum stimulus lag time (ms) from Parbery-Clark et al. (2009), subtracting out their fixed delay
        
        minShift_smp = round(minShiftTime * Fs/1000); % convert ms to samples 
        maxShift_smp = round(maxShiftTime * Fs/1000); % convert ms to samples
        
        idx_min = find(lags==minShift_smp);
        idx_max = find(lags==maxShift_smp);
        
        best_corr_limited = max(rs(idx_min:idx_max)); % maximum correlation between 8-12 ms, once adjusting for site-specific transmission delay

        stim2resp_adjusted.r(c) = best_corr;
        stim2resp_adjusted.z(c) = atanh(best_corr);
        stim2resp_adjusted.r_lim(c) = best_corr_limited;
        stim2resp_adjusted.z_lim(c) = atanh(best_corr_limited);
        stim2resp_adjusted.subj_uni = [stim2resp_adjusted.subj_uni; subj{s}];
        
        c = c + 1;
    end
    
    cd ../../../
end
cd ./code/11)EEG_da

save('stim2resp_adjusted','stim2resp_adjusted');