%% CODE OCEAN VERSION
% Formats, preprocesses, and plots data for /da/ study at each 
% university site location.

% All preprocessing matches Parbery-Clark et al. (2009, JNeuro). Script run
% using Matlab 2016b. 

% Before running this script, data were referenced using EEGLAB toolbox 
%(version 14.1.2b) and the raw, referenced data were formatted to be 
% consistent across sites. This script uses the referenced data at
% electrode Cz with uniform formatting across sites.

% Code written by Kelly L. Whiteford

%% STORE ORIGINAL PATH
% Running this script will change the path, so we want to save the name of
% the original path in order to restore it when the script is finished
% running.
original_path = path; % This is your current path

%% SET PATH SO THE FOLDERS WE NEED ARE ON TOP
analysisFolder_EEG = '../AnalysisFunctions'; % The folder with the custom analysis functions to be used.
violinFolder = '../AnalysisFunctions/Violinplot-Matlab-master'; % Subfolder with code for violin plots
addpath(analysisFolder_EEG,'-begin'); % Analysis folder is now at the top of the path. Functions in this folder will take priority over all other functions with the same name.
addpath(violinFolder,'-begin');

%% SET SEED
load('origSeed.mat')
rng(origSeed) % For reproducability 

%% PREPROCESS DATA FOR EACH SITE
% This section only needs to be run onced, then it can be commented out.
%run preprocess_da % Preprocesses Cz

%% DEFINE VARIABLES AND PLOTTING INFO
txt = 'off'; % Setting txt to 'on' adds subj_uni ID to scatterplot data points (note- may not be implemented for all plots)

setFigureDefaults % sets default font properties

% Outlier for between-groups comparisons of spectral encoding for /da/
outliers = {'s22_umn'}; 
 
%% PLOT EXAMPLE FFR
%Figure 1
%plotStimFFRexamples % commented out to decrease run time

%% CALCULATE AVERAGE AMPLITUDE OF THE EEG RESPONSE FOR EACH HARMONIC
%[da_dat] = da_amp_analysis; % commented out to decrease run time

%% CALCULATE STIMULUS TO RESPONSE CORRELATIONS
%[stim2resp] = da_stim2resp; % commented out to decrease run time

%[stim2resp_adjusted] = da_stim2resp_adjusted; % commented out to decrease run time

%% CALCULATE SNR OF RMS AMPLITUDE
%rms_da = snr_da; % commented out to decrease run time

%% LOAD SUBJECT INFORMATION
load subjInfo.mat 

%% LOAD /DA/ DATA
[da_dat] = loadEEG_da; % spectral encoding

[r_dat, rA_dat] = loadEEG_da_r; % stimulus-to-response correlations

load rms_da.mat

%% COMBINE SUBJECT INFORMATION WITH STUDY DATA
[dataDa, dataDaAll, missing_subj_uni] = matchDataNew(subjInfo,da_dat);

[data_r, data_rAll, missing_subj_uni] = matchDataNew(subjInfo,r_dat);

[data_rA, data_rAall, missing_subj_uni] = matchDataNew(subjInfo,rA_dat);

save('dataDa.mat','dataDa')
save('data_r.mat','data_r')
save('data_rA.mat','data_rA')

%% REMOVE SUBJECTS WITH POOR SNR FOR EXPLORATORY ANALYSES
veryBad = rms_da.subj_uni(rms_da.snr < 1);
subjEx = rms_da.subj_uni(rms_da.snr < 1.5); 

dataDaX = rmvSubjs(dataDa,subjEx);

dataX_r = rmvSubjs(data_r,subjEx);

dataX_rA = rmvSubjs(data_rA,subjEx);

%% REMOVE SPECTRAL ENCODING OUTLIER
dataDa_noO = rmvSubjs(dataDa,outliers);

dataDaX_noO = rmvSubjs(dataDaX,outliers);

save('dataDa_noO.mat','dataDa_noO')

%% PLOT
plot_da_violin(dataDa,dataDa_noO,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt,'Fig2','SupFig1')

plot_da_age(dataDa,dataDa_noO,mark_ind,mus_clr,nmus_clr,var_clr,txt)

plot_da_gender_violin(dataDa,dataDa_noO,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt)

plot_r_violin(data_r,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt,'Fig3')

plot_rA_lim_violin(data_rA,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt)

%% PLOT EXPLORATORY DATA WITH NEW NOISE FLOOR DEFINITION
plot_da_violin(dataDaX,dataDaX_noO,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt,'SupFig12','SupFig13')

plot_r_violin(dataX_r,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt,'SupFig14')

plot_rA_lim_violin(dataX_rA,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt)

%% SAVE DATA - this section doesn't work in Code Ocean or on Macs (PC only)
%saveDaData

%% RESTORE ORIGINAL PATH
path(original_path) % Now your path is back where you started. Hooray! :)