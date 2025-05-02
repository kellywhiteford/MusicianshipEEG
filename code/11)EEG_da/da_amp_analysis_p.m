%% Calculates amplitude (in microVolts) of each harmonic for /da/
% Analysis matches Parbery-Clark et al. (2009, JNeuro). 

function [da_dat_p] = da_amp_analysis_p
% Output
% da_dat_p          : Structure
% da_dat_p.F0amp    : Average F0 amplitude of EEG response for each subject
% da_dat_p.Hamp     : Summed H2-H10 amplitude of EEG response for each subject
% da_dat_p.subj_uni : Subject and university ID

%% University file information
siteNames = {'BU','CMU','PU','UMN','UR','UWO'};

%% Load preprocessed Cz data and calculate average spectral amplitude
c = 0;
da_dat_p.subj_uni = {};
cd ../../
for uni = 1:length(siteNames)
    
    cd(['./data/Within_Subj_Pilot/',siteNames{uni},'/da_Preprocessed_Cz'])
    
    
    Files=dir('*.*'); % Lists all data file names
    
    % Preallocate string arrays with no characters
    subj_file = strings([1,length(Files)-2]);
    subj = strings([1,length(Files)-2]);
    
    for k=3:length(Files)
        subj_file{k-2} = Files(k).name; % subject-specific file name
        subj(k-2) = extractBefore(extractAfter(subj_file{k-2},'da_'),'_Cz.mat'); % subj_uni ID
    end
    
    
    for s = 1:size(subj,2)
        
        load(subj_file{s});
        
        h_avg = dataFFT(Cz.SumAvg,Cz.Fs,[subj{s},'-',siteNames{uni}],0);
        
        if uni == 1
            da_dat_p.F0amp(s) = h_avg(1);
            %da_dat.Hamp(s) = mean(h_avg(2:10));
            da_dat_p.Hamp(s) = sum(h_avg(2:10)); % Now matches Parbery-Clark et al. (2009, JNeuro) analysis
        else
            da_dat_p.F0amp(c+1) = h_avg(1);
            %da_dat.Hamp(c+1) = mean(h_avg(2:10));
            da_dat_p.Hamp(c+1) = sum(h_avg(2:10));
        end
        da_dat_p.subj_uni = [da_dat_p.subj_uni; subj{s}];
        
        c = c + 1;
    end
    
    cd ../../../../
end

cd ./code/11)EEG_da
save('da_dat_p','da_dat_p');