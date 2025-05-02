%% CODE OCEAN VERSION
% Split-half analyses
% Code written by Kelly L. Whiteford

%% INFORMATION THAT NEEDS TO BE EDITED TO RUN ON YOUR COMPUTER 
daFolder = '../11)EEG_da';
folder_mi3_Analyses = '../12)EEG_mi3';

%% Set path so folders we need are on top.
analysisFolder_EEG = '../AnalysisFunctions'; % The folder with the custom analysis functions to be used.
addpath(analysisFolder_EEG,'-begin'); % Analysis folder is now at the top of the path. Functions in this folder will take priority over all other functions with the same name.

%% SET SEED
load('origSeed.mat')
rng(origSeed) % For reproducability 

%% PREPROCESS DATA FOR EACH SITE
% This section only needs to be run onced, then it can be commented out.
%run preprocess_mi3_splitHalf % Preprocesses Cz

%% DEFINE VARIABLES AND PLOTTING INFO
txt = 'off'; % Setting txt to 'on' adds subj_uni ID to data points

shouldPlot = 1; % Change to 1 to plot individual data

setFigureDefaults % sets default font properties

%% EXCLUDED SUBJECTS
% Subjects whose F0 tracking is in the noise floor or there are < 60% artifact-free trials. 
% Note : Subjects who were excluded by study site (e.g., due to technical
% issues, etc.) were never preprocessed and are not listed here.
excluded_subjs = {'s10_bu','s12_bu','s14_bu','s39_bu',...
    's7_cmu','s9_cmu','s12_cmu','s19_v2_cmu',...
    's4_pu','s9_pu','s15_pu','s24_pu','s26_pu','s32_pu','s45_pu',...
    's52_umn','s66_umn','s70_umn','s82_umn','s87_umn','s91_umn','s95_umn'...
    's2_ur','s8_ur','s20_ur','s29_ur','s33_ur','s56_ur','s68_ur',...
    's2_uwo','s13_uwo','s39_uwo','s47_uwo','s65_uwo'};

%% CALCULATE F0 TRACKING
%[mi3_dat_s] = mi3_f0_tracking_splitHalf(excluded_subjs); % commented out to decrease run time

%% LOAD /MI3/ DATA
[mi3_dat_s] = loadEEG_mi3_s; % F0 tracking

%% LOAD SUBJECT INFORMATION 
load subjInfo.mat % located in analysisFolder_EEG

%% COMBINE SUBJECT INFORMATION WITH EXPERIMENT DATA
[dataMi3_s, dataMi3_s_All, missing_subj_uni] = matchDataNew(subjInfo,mi3_dat_s);

%% LOAD /DA/ DATA
cd(daFolder)

load('dataDa_s.mat')

load('dataDa_s_noO.mat') % s22_umn removed from this dataset

load('data_rA_s.mat')

cd(folder_mi3_Analyses)

%% PLOT RELIABILITY BETWEEN THE TWO HALVES OF DATA
plot_daMi3_splitHalf(dataDa_s,dataDa_s_noO,data_rA_s,dataMi3_s,mark_ind,mus_clr,nmus_clr,var_clr,txt)