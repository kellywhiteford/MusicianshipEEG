%% Script for preprocessing between-subjects data 
% All preprocessing matches Wong et al. (2007, Nature Neuro.). 

%% University file information
siteNames = {'CMU','BU','PU','UMN','UR','UWO'};
specificSubjs = 0; % set this to true to only preprocess specific subjects

if specificSubjs
    subj = {'s22_cmu'}; % List spefic subjects here!
    subj_file = strings([1,length(subj)]); % Preallocate string arrays with no characters
    for ii = 1:length(subj)
        subj_file{ii} = strcat('mi3_',subj{ii},'_rawRefCz.mat');
    end
end

%% Parameters for preprocessing -- These are the same for each site.
%Filter parameters
N = 2; % Filter order; 2 corresponds to 12 dB/Oct
Fc1 = 80; % Lower-frequency cutoff (Hz)
Fc2 = 1000; % Higher-frequency cutoff (Hz)

% Artifact removal parameters
cutOff = 35; % Absolute value threshold for removing /da/ trials with artifacts (microvolts)

% Epoch parameters
baseline_start_in_ms = -45; % Where baseline epoch starts (ms)
start_in_ms = 0; % Time of stimulus onset in epoch (ms)
stop_in_ms = 295; % End time of epoch (ms)

cd ../../
%% Preprocess all subjects at each university 
for uni = 1:length(siteNames)
    
    cd(['./data/',siteNames{uni},'/mi3_Cz'])
    
    if ~specificSubjs % For preprocessing all subjects
        Files=dir('*.*'); % Lists all data file names

        % Preallocate string arrays with no characters
        subj_file = strings([1,length(Files)-2]);
        subj = strings([1,length(Files)-2]);

        for k=3:length(Files)
            subj_file{k-2} = Files(k).name; % subject-specific file name
            subj(k-2) = extractBefore(extractAfter(subj_file{k-2},'mi3_'),'_rawRefCz.mat'); % subj_uni ID
        end
    end

    for s = 1:size(subj,2)
        
        load(subj_file{s});
        output_file_Cz = strcat('../mi3_Preprocessed_Cz/mi3_',subj{s},'_Cz.mat');
        
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
        Cz = preprocess_modified(data,'/mi3/','no');
        
        %% Save preprocessed data
        % Save analyzed data for Cz:
        disp('   Saving analyzed data to a MAT file...');
        save(output_file_Cz,'Cz');
        disp('      Analyzed data saved as:  ');
        disp(['         ', output_file_Cz]);
                
        %% Clear all variables except a few that we need
        clearvars -except uni s N Fc1 Fc2 cutOff baseline_start_in_ms start_in_ms stop_in_ms folderName original_path siteNames subj_file subj specificSubjs
    end
    
    cd ../../../
end
clearvars -except folderName original_path siteNames

cd ./code/12)EEG_mi3

