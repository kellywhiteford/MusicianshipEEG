%% CODE OCEAN VERSION
% Split-half analyses
% Code written by Kelly L. Whiteford

%% Store orignal path
% Running this script will change the path, so we want to save the name of
% the original path in order to restore it when the script is finished
% running.
original_path = path; % This is your current path

%% Set path so folders we need are on top.
analysisFolder_EEG = '../AnalysisFunctions'; % The folder with the custom analysis functions to be used.
addpath(analysisFolder_EEG,'-begin'); % Analysis folder is now at the top of the path. Functions in this folder will take priority over all other functions with the same name.

%% SET SEED
load('origSeed.mat')
rng(origSeed) % For reproducability 

%% PREPROCESS DATA FOR EACH SITE
% This section only needs to be run onced, then it can be commented out.
%run preprocess_da_splitHalf % Only preprocesses Cz

%% DEFINE VARIABLES AND PLOTTING INFO
txt = 'off'; % Setting txt to 'on' adds subj_uni ID to scatterplot data points

setFigureDefaults % sets default font properties

% Outlier for between-groups comparisons of spectral encoding for /da/
outliers = {'s22_umn'}; 

%% CALCULATE AVERAGE AMPLITUDE OF THE EEG RESPONSE FOR EACH HARMONIC
%[da_dat_s] = da_amp_analysis_splitHalf; % commented out to decrease run time

%% CALCULATE STIMULUS-TO-RESPONSE CORRELATIONS
%[stim2resp_adjusted_s] = da_stim2resp_adjusted_splitHalf; % commented out to decrease run time

%% LOAD /DA/ DATA
[da_dat_s] = loadEEG_da_s; % spectral encoding

rA_dat_s = loadEEG_da_r_s; % stimulus-to-response correlations

%% LOAD SUBJECT INFORMATION
load subjInfo.mat 

%% COMBINE SUBJECT INFORMATION WITH STUDY DATA
[dataDa_s, dataDa_s_All, missing_subj_uni] = matchDataNew(subjInfo,da_dat_s);

[data_rA_s, data_rA_s_All, missing_subj_uni] = matchDataNew(subjInfo,rA_dat_s);

save('dataDa_s.mat','dataDa_s')
save('data_rA_s.mat','data_rA_s')

%% REMOVE SPECTRAL ENCODING OUTLIER
dataDa_s_noO = rmvSubjs(dataDa_s,outliers);

save('dataDa_s_noO.mat','dataDa_s_noO')
