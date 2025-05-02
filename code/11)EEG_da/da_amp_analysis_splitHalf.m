%% Calculates amplitude (in microVolts) of each harmonic for /da/
% Analysis matches Parbery-Clark et al. (2009, JNeuro). 

function [da_dat_s] = da_amp_analysis_splitHalf
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
da_dat_s.subj_uni = {};
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
        
        sCz.Fs = 16384;
        
        h_avg_h1 = dataFFT(sCz.SumAvg_h1,sCz.Fs,[subj{s},'-',siteNames{uni}],0);
        h_avg_h2 = dataFFT(sCz.SumAvg_h2,sCz.Fs,[subj{s},'-',siteNames{uni}],0);
        
        if uni == 1
            da_dat_s.F0amp_h1(s) = h_avg_h1(1);
            da_dat_s.F0amp_h2(s) = h_avg_h2(1);
            %da_dat.Hamp(s) = mean(h_avg(2:10));
            da_dat_s.Hamp_h1(s) = sum(h_avg_h1(2:10)); % Now matches Parbery-Clark et al. (2009, JNeuro) analysis
            da_dat_s.Hamp_h2(s) = sum(h_avg_h2(2:10)); 
        else
            da_dat_s.F0amp_h1(c+1) = h_avg_h1(1);
            da_dat_s.F0amp_h2(c+1) = h_avg_h2(1);
            %da_dat.Hamp(c+1) = mean(h_avg(2:10));
            da_dat_s.Hamp_h1(c+1) = sum(h_avg_h1(2:10));
            da_dat_s.Hamp_h2(c+1) = sum(h_avg_h2(2:10));
        end
        da_dat_s.subj_uni = [da_dat_s.subj_uni; subj{s}];
        
        c = c + 1;
    end
    
    cd ../../../
end
cd ./code/11)EEG_da

save('da_dat_s','da_dat_s');