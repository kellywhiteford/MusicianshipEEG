%% Saves time averaged waveforms used for plotting to a .dat file

function [mi3_SumAvg_p] = saveSumAvgCz_mi3_p
% Output
% mi3_SumAvg_p               : Structure
% mi3_SumAvg_p.Fs            : Samplerate
% mi3_SumAvg_p.FixedDelay_ms : For each site
% mi3_SumAvg_p.Cz            : Summed response across the two polarities for Cz
% mi3_SumAvg_p.CzBaseline    : Summed baseline response across the two polarities for Cz
% mi3_SumAvg_p.subj_uni      : Subject and university ID

%% University file information
siteNames = {'BU','CMU','PU','UMN','UR','UWO'};

c = 0;
mi3_SumAvg_p.subj_uni = {};
cd ../../
for uni = 1:length(siteNames)
    
    cd(['./data/Within_Subj_Pilot/',siteNames{uni},'/mi3_Preprocessed_Cz'])
    
    
    Files=dir('*.*'); % Lists all data file names
    
    % Preallocate string arrays with no characters
    subj_file = strings([1,length(Files)-2]);
    subj = strings([1,length(Files)-2]);
    
    for k=3:length(Files)
        subj_file{k-2} = Files(k).name; % subject-specific file name
        subj(k-2) = extractBefore(extractAfter(subj_file{k-2},'mi3_'),'_Cz.mat'); % subj_uni ID
    end
    
    
    for s = 1:size(subj,2)
        
        load(subj_file{s});
        
        if uni == 1
            mi3_SumAvg_p.Fs(s) = Cz.Fs;
            mi3_SumAvg_p.FixedDelay_ms(s) = Cz.FixedDelay_ms;
            mi3_SumAvg_p.Cz(s,:) = Cz.SumAvg;
            mi3_SumAvg_p.CzBaseline(s,:) = Cz.SumAvg_Baseline;
        else
            mi3_SumAvg_p.Fs(c+1) = Cz.Fs;
            mi3_SumAvg_p.FixedDelay_ms(c+1) = Cz.FixedDelay_ms;
            mi3_SumAvg_p.Cz(c+1,:) = Cz.SumAvg;
            mi3_SumAvg_p.CzBaseline(c+1,:) = Cz.SumAvg_Baseline;
        end
        mi3_SumAvg_p.subj_uni = [mi3_SumAvg_p.subj_uni; subj{s}];
        
        c = c + 1;
    end
    
    cd ../../../../
end

cd ./code/12)EEG_mi3

save('mi3_SumAvg_p','mi3_SumAvg_p');