%% Script for preprocessing /da/ data 
% All preprocessing matches Parbery-Clark et al. (2009, JNeuro). 

%% University file information
siteNames = {'BU','CMU','PU','UMN','UR','UWO'};
specificSubjs = 0; % set this to true to only preprocess specific subjects

if specificSubjs
    subj = {'s1_umn'}; % List spefic subjects here!
    subj_file = strings([1,length(subj)]); % Preallocate string arrays with no characters
    for ii = 1:length(subj)
        subj_file{ii} = strcat('da_',subj{ii},'_rawRefCz.mat'); % raw data at Cz after referencing
    end
end

%% Parameters for preprocessing -- These are the same for each site.
%Filter parameters
N = 2; % Filter order; 2 corresponds to 12 dB/Oct
Fc1 = 70; % Lower-frequency cutoff (Hz)
Fc2 = 2000; % Higher-frequency cutoff (Hz)

% Artifact removal parameters
cutOff = 35; % Absolute value threshold for removing /da/ trials with artifacts (microvolts)

% Epoch parameters
baseline_start_in_ms = -40; % Where baseline epoch starts (ms)
start_in_ms = 0; % Time of stimulus onset in epoch (ms)
stop_in_ms = 213; % End time of epoch (ms)

%% Preprocess all subjects at each university 
cd ../../
for uni = 1:length(siteNames)
    
    cd(['./data/Within_Subj_Pilot/',siteNames{uni},'/da_Cz'])
    
    if ~specificSubjs % For preprocessing all subjects
        Files=dir('*.*'); % Lists all data file names

        % Preallocate string arrays with no characters
        subj_file = strings([1,length(Files)-2]);
        subj = strings([1,length(Files)-2]);
        
        for k=3:length(Files)
            subj_file{k-2} = Files(k).name; % subject-specific file name
            subj(k-2) = extractBefore(extractAfter(subj_file{k-2},'da_'),'_rawRefCz.mat'); % subj_uni ID
        end
    end
    
    for s = 1:size(subj,2)
        
        load(subj_file{s});
        output_file_Czmod = strcat('../da_Preprocessed_Cz/da_',subj{s},'_Cz.mat');
        
        data.EventTimingParams = [baseline_start_in_ms start_in_ms stop_in_ms];
        data.FilterParams = [N Fc1 Fc2];
        data.ArtifactThreshold = cutOff;
        
        if isempty(find(strcmp(data.Labels,'A32'),1))
            Cz_ind = find(strcmp(data.Labels,'Cz')); % index for electrode Cz with 1- or 16-channel cap
        else
            Cz_ind = find(strcmp(data.Labels,'A32')); % index for electrode Cz with 32-channel cap
        end
        
        data.Record = data.Record(Cz_ind,:); % Only use Cz data
        
        if strcmp(data.Labels(Cz_ind),'C')
            data.Labels = data.Labels; % for site UR, which only has Cz
        else
            data.Labels = data.Labels(Cz_ind); % Only keep Cz label
        end
        
        %% Filter raw EEG data
        % Setting the last input of filtEEG to 'yes' will plot the filters 
        % and their impulse response.
        data.Record = filtEEG(data.Record,Fc1,Fc2,N,data.Fs,'no'); % Performs bandpass butterworth filtering with zero-phase shift.
        
        %% Epoch, artifact reject, and baseline EEG data
        % Setting the last variable to 'yes' in preprocess will plot the
        % preprocessed average data for each trigger.
        Cz = preprocess_modified(data,'/da/','no');
        
        %% Save preprocessed data
        % Save analyzed data for Cz:
        disp('   Saving analyzed data to a MAT file...');
        save(output_file_Czmod,'Cz');
        disp('      Analyzed data saved as:  ');
        disp(['         ', output_file_Czmod]);
        
        %% Clear all variables except a few that we need
        clearvars -except uni s N Fc1 Fc2 cutOff baseline_start_in_ms start_in_ms stop_in_ms folderName original_path siteNames subj_file subj specificSubjs
    end
    
    cd ../../../../
end
clearvars -except folderName original_path siteNames

cd ./code/11)EEG_da

