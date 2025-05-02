%% CODE OCEAN VERSION
% Formats, preprocesses, and plots data for /mi3/ study at each 
% university site location.

% All preprocessing matches Wong et al. (2007). Script run using Matlab 
% 2016b. 

% Before running this script, data were referenced using EEGLAB toolbox 
%(version 14.1.2b) and the raw, referenced data were formatted to be 
% consistent across sites. This script uses the referenced data at
% electrode Cz with uniform formatting across sites.

% Code written by Kelly L. Whiteford

%% LOCATION OF /DA/ AND /MI3/ STUDY FOLDERS
daFolder = '../11)EEG_da';
folder_mi3_Analyses = '../12)EEG_mi3';

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

%% PREPROCESS DATA FOR EACH SITE
% This section only needs to be run onced, then it can be commented out.
% run preprocess_mi3

%% SET SEED
load('origSeed.mat')
rng(origSeed) % For reproducability 

%% DEFINE VARIABLES AND PLOTTING INFO
txt = 'off'; % Setting txt to 'on' adds subj_uni ID to data points (note- may not be implemented for all plots)

shouldPlot = 1; % Change to 1 to plot individual data

setFigureDefaults % sets default font properties

% Outlier for stimulus-to-response correlations
outliers = {'s34_bu'}; 

%% PLOT EXAMPLE FFR
%plotMi3FFRexample

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
%[mi3_dat] = mi3_f0_tracking(excluded_subjs); % commented out to decrease run time

%% CALCULATE SNR OF RMS AMPLITUDE
%rms_mi3 = snr_mi3; % commented out to decrease run time

%% LOAD SUBJECT INFORMATION 
load subjInfo.mat % located in analysisFolder_EEG

%% LOAD /MI3/ DATA
[mi3_dat] = loadEEG_mi3; % F0 tracking

load rms_mi3.mat

%% COMBINE SUBJECT INFORMATION WITH EXPERIMENT DATA
[dataMi3, dataMi3All, missing_subj_uni] = matchDataNew(subjInfo,mi3_dat);

%% REMOVE SUBJECTS WITH POOR SNR
veryBad = rms_mi3.subj_uni(rms_mi3.snr < 1);
subjEx = rms_mi3.subj_uni(rms_mi3.snr < 1.5); 

dataMi3X = rmvSubjs(dataMi3,subjEx);

%% REMOVE OUTLIERS
dataMi3_noO = rmvSubjs(dataMi3,outliers);

dataMi3X_noO = rmvSubjs(dataMi3X,outliers);

%% PLOT
txt = 'off';
plot_mi3_violin(dataMi3,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt,1,'Fig4')

plot_mi3_violin(dataMi3_noO,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt,0,'mi3NoOutlier')

%% PLOT EXPLORATORY DATA USING NEW NOISE FLOOR CRITERION
plot_mi3_violin(dataMi3X,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt,1,'SupFig15')

plot_mi3_violin(dataMi3X_noO,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt,0,'SupFig16')

%% LOAD /DA/ DATA
cd(daFolder)

load('dataDa.mat')

load('dataDa_noO.mat') % s22_umn removed from this dataset

load('data_rA.mat')

load('data_r.mat')

cd(folder_mi3_Analyses)

%% BETWEEN-STUDY COMPARISONS
[mi3DaOnly, mi3DaAll, partialSubjs] = matchDataExps(dataDa,dataMi3);

[mi3DaOnly_noO, mi3DaAll_noO, partialSubjs_noO] = matchDataExps(dataDa_noO,dataMi3); % outlier non-musician removed

[mi3DaOnly_rA, mi3DaAll_rA, partialSubjs_rA] = matchDataExps(data_rA,dataMi3);

plot_mi3_da(mi3DaOnly, mi3DaOnly_noO, dataDa, dataDa_noO, mark_ind, mus_clr,nmus_clr,var_clr,txt);

%% ONLY SUBJECTS WHO HAVE MELODY DISCRIMINATION DATA AND NEURAL ENCODING
[dataDaM,missingSubjsM_da] = grabOneField(dataDa,'dp');

[dataDaM_noO] = grabOneField(dataDa_noO,'dp');

[dataDa_rA_M,missingSubjsM_da_rA] = grabOneField(data_rA,'dp');

[dataMi3M,missingSubjsM_mi3] = grabOneField(dataMi3,'dp');

%% MUSICAL ABILITY AND YEARS OF FORMAL MUSICAL TRAINING FOR ALL SUBJECTS
both = ismember(dataMi3M.subj_uni,dataDaM.subj_uni); % /mi3/ participants who also have analyzable data for /da/
onlyMi3 = ~ismember(dataMi3M.subj_uni,dataDaM.subj_uni); % /mi3/ participants who do NOT have analyzable data for /da/
onlyDa = ~ismember(dataDaM.subj_uni,dataMi3M.subj_uni); % /da/ particpants who do NOT have analyzable data for /mi3/

allMus.subj_uni = [dataMi3M.subj_uni(both); dataMi3M.subj_uni(onlyMi3); dataDaM.subj_uni(onlyDa)];
allMus.Group = [dataMi3M.Group(both); dataMi3M.Group(onlyMi3); dataDaM.Group(onlyDa)];
allMus.yrsMusF = [dataMi3M.yrsMusF(both); dataMi3M.yrsMusF(onlyMi3); dataDaM.yrsMusF(onlyDa)];
allMus.dp = [dataMi3M.dp(both); dataMi3M.dp(onlyMi3);dataDaM.dp(onlyDa)];

plotMusAll(allMus,mark_ind,mark_avg,mus_clr,nmus_clr,var_clr,txt)

%% MUSICAL ABILITY AND SOUND NEURAL ENCODING FOR /MI3/ IN QUIET AND /DA/ IN BABBLE
plotMusicalAbility(dataMi3M,dataDaM,dataDa_rA_M,dataDaM_noO,mark_ind,mus_clr,nmus_clr,var_clr,txt)

%% PARTIAL CORRELATION PLOTS 
plotAllPartCorrs(dataDa,dataDa_noO,data_r,dataMi3,mark_ind,mus_clr,nmus_clr,var_clr,txt)

%% SAVE DATA - this section doesn't work in Code Ocean or on Macs (PC only)
%saveMi3Data

%% RESTORE ORIGINAL PATH
path(original_path) % Now your path is back where you started. Hooray! :)

