%% CODE OCEAN AND GITHUB VERSION 
% Formats, preprocesses, and plots all Matlab-generated figures.
% Script run using Matlab 2016b.

cd ./11)EEG_da

run_da

clear all

cd ../code/12)EEG_mi3

run_mi3

clear all

cd ./11)EEG_da

run_withinPilot_da

clear all

cd ./code/12)EEG_mi3

run_withinPilot_mi3

clear all

cd ./code/11)EEG_da

run_da_splitHalf

clear all

cd ../
cd ../code/12)EEG_mi3

run_mi3_splitHalf

clear all