%% Calculates stimulus-to-response correlations for /da/, adjusting for site-specific time delays
% Takes into account the time between the onset of the stimulus at the
% transducer and the time it takes for the stimulus to get to the ear
% canal; in Parbery-Clark et al. (2009), this time was 1.1 ms.
% Analysis matches Parbery-Clark et al. (2009, JNeuro).

function [stim2resp_adjusted_s] = da_stim2resp_adjusted_splitHalf
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
stim2resp_adjusted_s.subj_uni = {};
cd ../../
for uni = 1:length(siteNames)
    
    cd(['./data/',siteNames{uni},'/da_Preprocessed_sCz'])
    
    if ~specificSubjs % For preprocessing all subjects
        Files=dir('*.*'); % Lists all data file names

        % Preallocate string arrays with no characters
        subj_file = strings([1,length(Files)-2]);
        subj = strings([1,length(Files)-2]);

        for k=3:length(Files)
            subj_file{k-2} = Files(k).name; % subject-specific file name
            subj(k-2) = extractBefore(extractAfter(subj_file{k-2},'da_'),'_sCz.mat'); % subj_uni ID
        end
    end
    
    for s = 1:size(subj,2)
        
        load(subj_file{s});
        
        avgDat_h1 = sCz.SumAvg_h1;
        avgDat_h2 = sCz.SumAvg_h2;
        
        Fs = fs;
        ParberyClark_fixedDelay = 1.1; % stimulus transmission delay from ER-3 to ear insert (ms)
        minTime = 50; % Time where steady-state portion begins (ms)
        maxTime = 200; % Time where steady-state portion ends (ms)
        minSamp = round(minTime * Fs/1000); % convert ms to samples
        maxSamp = round(maxTime * Fs/1000); % convert ms to samples
        steadyState_resp_h1 = avgDat_h1(1,minSamp:maxSamp); % just the steady-state response to /da/
        steadyState_resp_h2 = avgDat_h2(1,minSamp:maxSamp);
        
        extra_length_h1 = length(steadyState_resp_h1) - length(steadyState_stim); 
        extra_zeros_h1 = zeros(1,extra_length_h1);
        
        extra_length_h2 = length(steadyState_resp_h2) - length(steadyState_stim); 
        extra_zeros_h2 = zeros(1,extra_length_h2);
        
        steadyState_stim_new_h1 = [steadyState_stim, extra_zeros_h1]; % append extra zeros to the stimulus so it matches the length of the response
        steadyState_stim_new_h2 = [steadyState_stim, extra_zeros_h2];
        
        % Positive lags: Correspond to samples that the STIMULUS is delayed
        % Negative algs: Correspond to samples that the RESPONSE is delayed
        [rs_h1, lags_h1] = xcorr(steadyState_resp_h1,steadyState_stim_new_h1,'coeff'); % Cross-correlations for all lag times
        best_corr_h1 = round(max(rs_h1),3); % maximum cross-correlation across all possible lag times
        
        [rs_h2, lags_h2] = xcorr(steadyState_resp_h2,steadyState_stim_new_h2,'coeff'); % Cross-correlations for all lag times
        best_corr_h2 = round(max(rs_h2),3); % maximum cross-correlation across all possible lag times
        
        minShiftTime = 8-ParberyClark_fixedDelay+sCz.FixedDelay_ms; % minimum stimulus lag time (ms) from Parbery-Clark et al. (2009), subtracting out their fixed delay
        maxShiftTime = 12-ParberyClark_fixedDelay+sCz.FixedDelay_ms; % maxmum stimulus lag time (ms) from Parbery-Clark et al. (2009), subtracting out their fixed delay
        
        minShift_smp = round(minShiftTime * Fs/1000); % convert ms to samples 
        maxShift_smp = round(maxShiftTime * Fs/1000); % convert ms to samples
        
        idx_min_h1 = find(lags_h1==minShift_smp);
        idx_max_h1 = find(lags_h1==maxShift_smp);
        
        idx_min_h2 = find(lags_h2==minShift_smp);
        idx_max_h2 = find(lags_h2==maxShift_smp);
        
        best_corr_limited_h1 = max(rs_h1(idx_min_h1:idx_max_h1)); % maximum correlation between 8-12 ms, once adjusting for site-specific transmission delay
        best_corr_limited_h2 = max(rs_h2(idx_min_h2:idx_max_h2)); % maximum correlation between 8-12 ms, once adjusting for site-specific transmission delay

        stim2resp_adjusted_s.r_h1(c) = best_corr_h1;
        stim2resp_adjusted_s.z_h1(c) = atanh(best_corr_h1);
        stim2resp_adjusted_s.r_lim_h1(c) = best_corr_limited_h1;
        stim2resp_adjusted_s.z_lim_h1(c) = atanh(best_corr_limited_h1);
        
        stim2resp_adjusted_s.r_h2(c) = best_corr_h2;
        stim2resp_adjusted_s.z_h2(c) = atanh(best_corr_h2);
        stim2resp_adjusted_s.r_lim_h2(c) = best_corr_limited_h2;
        stim2resp_adjusted_s.z_lim_h2(c) = atanh(best_corr_limited_h2);
        
        stim2resp_adjusted_s.subj_uni = [stim2resp_adjusted_s.subj_uni; subj{s}];
        
        c = c + 1;
    end
    
    cd ../../../
end
cd ./code/11)EEG_da

save('stim2resp_adjusted_s','stim2resp_adjusted_s');