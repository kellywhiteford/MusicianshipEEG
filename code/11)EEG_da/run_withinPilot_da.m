% Formats, preprocesses, and plots within-subject pilot data for /da/ 
% experiment at each university site location.

% All preprocessing matches Parbery-Clark et al. (2009, JNeuro). Script run
% using Matlab 2016b. Prior to running this code, data were formatted to 
% be uniform across sites and referenced using software from EEGLAB
% toolbox (version 14.1.2b). 

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

%% DEFINE VARIABLES AND PLOTTING INFO
setFigureDefaults % sets default font properties

%% Preprocess data for each site
% This section only needs to be run once, then it can be commented out.
%run preprocess_da_pilot

%% CALCULATE AVERAGE AMPLITUDE OF THE EEG RESPONSE FOR EACH HARMONIC
%[da_dat_p] = da_amp_analysis_p; % commented out to decrease run time

%% SAVE TIME WAVEFORMS NEEDED FOR PLOTTING 
%[da_SumAvg_p] = saveSumAvgCz_p; % commented out to decrease run time

%% LOAD DATA FOR PLOTTING
load da_dat_p.mat
load da_SumAvg_p.mat 

%% PLOT FFRS
corrMat = plotWithinSubjFFRs(da_SumAvg_p);

cd ../../
%% Restore original path
path(original_path) % Now your path is back where you started. Hooray! :)