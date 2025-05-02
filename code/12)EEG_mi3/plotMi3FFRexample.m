% Plot /mi3/ stimulus and example FFR

function plotMi3FFRexample

% siteNames = {'UR'};
% subj = {'s38'};

siteNames = {'PU'};
subj = {'s35'};

figure('units','inch','position',[2,1,7.2,5]);

cd(['../../data/' siteNames{1} '/mi3_Preprocessed_Cz/']) % Go to site folder with preprocessed data

fileName = strcat('mi3_', subj{1} ,'_', lower(siteNames{1}), '_Cz.mat'); % Name of file for individual subject

load(fileName); % load preprocessed data

[stimulus, Fs_stim] = audioread('mi3.wav'); % load stimulus
stim = resample(stimulus,16384,Fs_stim); % Resampled stim has a sampling rate of Fs (16384)
stim = stim';
noSound = zeros(1,length(Cz.SumAvg) - length(stim));

stim = [stim,noSound];
subplot(3,1,1)
plotTime(stim,Cz.Fs,'/mi3/','/mi3/ Stimulus')

subplot(3,1,2)
plotTime(Cz.SumAvg,Cz.Fs,'/mi3/','Example FFR')

subplot(3,1,3)
[f0Max, f0amp_avg] = slidingFFT_mi3(Cz.SumAvg,Cz.SumAvg_Baseline,Cz.Fs,Cz.FixedDelay_ms,'no','yes'); % sliding FFT on EEG response
hold on
[f0Max_stim, f0amp_avg_stim, allFFT_mag_stim] = slidingFFT_mi3(stim,0.*Cz.SumAvg_Baseline,Cz.Fs,0,'yes','yes'); % sliding FFT on stimulus
title('F0 Tracking')

cd ../../../

cd ./code/12)EEG_mi3
