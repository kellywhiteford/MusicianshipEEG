% Plot /da/ and /mi3/ stimuli and example FFRs

function plotStimFFRexamples

siteNames = {'UR'};
subj = {'s38'};

cd(['../../data/' siteNames{1} '/da_Preprocessed_Cz/']) % Go to site folder with preprocessed data

fileName = strcat('da_', subj{1} ,'_', lower(siteNames{1}), '_Cz.mat'); % Name of file for individual subject

load(fileName); % load preprocessed Cz data

[stimulus, Fs_stim] = audioread('DAbase_resampled.wav'); % load stimulus
stim = resample(stimulus,Cz.Fs,Fs_stim); % Resampled stim has a sampling rate of Fs (16384)
stim = stim';

noSound = zeros(1,length(Cz.SumAvg) - length(stim));

stim = [stim,noSound];

figure('units','inch','position',[2,1,4,4]);
subplot(3,2,1)
plotTimeWithBaseline(stim,Cz.SumAvg_Baseline.*0,Cz.Fs,'/da/','a      /da/ Stimulus        ','stim')
hold on

subplot(3,2,3)
plotTimeWithBaseline(Cz.SumAvg,Cz.SumAvg_Baseline,Cz.Fs,'/da/','c        FFR to /da/          ')
ylim([-1 1.5])


cd '../../' % Go back to Data/11)EEG_da folder

subplot(3,2,5)
dataFFT(Cz.SumAvg,Cz.Fs,'e FFT of Steady State ',1);
hold on


cd (['./' siteNames{1} '/mi3_Preprocessed_Cz/']) % Go to site folder with preprocessed data

fileName = strcat('mi3_', subj{1} ,'_', lower(siteNames{1}), '_Cz.mat'); % Name of file for individual subject

load(fileName); % load preprocessed data

[stimulus, Fs_stim] = audioread('mi3.wav'); % load stimulus
stim = resample(stimulus,16384,Fs_stim); % Resampled stim has a sampling rate of Fs (16384)
stim = stim';
noSound = zeros(1,length(Cz.SumAvg) - length(stim));

stim = [stim,noSound];
subplot(3,2,2)
plotTimeWithBaseline(stim,Cz.SumAvg_Baseline.*0,Cz.Fs,'/mi3/','b     /mi3/ Stimulus     ','stim')
xlim([-45 295])

subplot(3,2,4)
plotTimeWithBaseline(Cz.SumAvg,Cz.SumAvg_Baseline,Cz.Fs,'/mi3/','d       FFR to /mi3/        ')
xlim([-45 295])

subplot(3,2,6)
[f0Max, f0amp_avg] = slidingFFT_mi3(Cz.SumAvg,Cz.SumAvg_Baseline,Cz.Fs,Cz.FixedDelay_ms,'no','yes'); % sliding FFT on EEG response
hold on
[f0Max_stim, f0amp_avg_stim, allFFT_mag_stim] = slidingFFT_mi3(stim,0.*Cz.SumAvg_Baseline,Cz.Fs,0,'yes','yes'); % sliding FFT on stimulus
title('f       F0 Tracking         ')
ylim([75 125])

cd ../../../
cd ./code/11)EEG_da

print('../../results/Fig1','-dpng') 