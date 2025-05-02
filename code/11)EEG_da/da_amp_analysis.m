%% Calculates amplitude (in microVolts) of each harmonic for /da/
% Analysis matches Parbery-Clark et al. (2009, JNeuro). 

function [da_dat] = da_amp_analysis
% Output
% da_dat          : Structure
% da_dat.F0amp    : Average F0 amplitude of EEG response for each subject
% da_dat.Hamp     : Summed H2-H10 amplitude of EEG response for each subject
% da_dat.subj_uni : Subject and university ID

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

%% Load preprocessed Cz data and calculate average spectral amplitude
c = 0; 
da_dat.subj_uni = {};

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
        
        h_avg = dataFFT(Cz.SumAvg,Cz.Fs,[subj{s},'-',siteNames{uni}],0);
        
        if uni == 1
            da_dat.F0amp(s) = h_avg(1);
            %da_dat.Hamp(s) = mean(h_avg(2:10));
            da_dat.Hamp(s) = sum(h_avg(2:10)); % Now matches Parbery-Clark et al. (2009, JNeuro) analysis
        else
            da_dat.F0amp(c+1) = h_avg(1);
            %da_dat.Hamp(c+1) = mean(h_avg(2:10));
            da_dat.Hamp(c+1) = sum(h_avg(2:10));
        end
        da_dat.subj_uni = [da_dat.subj_uni; subj{s}];
        
        c = c + 1;
    end
    
    cd ../../../
end
cd ./code/11)EEG_da

save('da_dat','da_dat');