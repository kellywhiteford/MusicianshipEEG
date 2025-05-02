function [dataOnly, dataAll, missing_subj_uni] = matchDataNew(dataScreen, dataExp)
% INPUTS
% dataScreen       : Structure of online screening data
% dataExp          : Structure of experiment data
% OUTPUTS
% dataOnly         : Structure of only the subjects that did the experiment
% dataAll          : Structure of all subject data (screening and experiment), including participants that are missing experiment data.
% missing_subj_uni : subj_uni IDs of all subjects missing experiment data

[subjsMissingOnlineScreening] = setdiff(dataExp.subj_uni,dataScreen.subj_uni); % returns subjIDs for those that did experiment but are missing online screening data

if ~isempty(subjsMissingOnlineScreening) % if one or more subjects are missing online screening data
    error('At least one subject is missing online screening data.')
end

allFieldsExp = fields(dataExp); % all fields in structure dataExp

dataAll = dataScreen;
dataAll.screening_subj_uni = dataScreen.subj_uni; % dataAll.subj_uni should be in the same order as dataScreen.subj_uni
for s = 1:length(dataScreen.subj_uni)
    grab = strcmp(dataScreen.subj_uni(s),dataExp.subj_uni); % return index of experiment data for specific subject in screening
    
    if sum(grab) == 1
        
        for f = 1:length(allFieldsExp)
            
            
            dataAll.(allFieldsExp{f})(s,1) = dataExp.(allFieldsExp{f})(grab);
            
            
        end
    elseif sum(grab) == 0 % no experiment data for this particular subject
        
        for f = 1:length(allFieldsExp)
            
            dataAll.(allFieldsExp{f})(s,1) = NaN;

        end
    else
        error('Something weird happened.')
    end
end

dataOnly = dataAll;

allF = fields(dataOnly); % all fields in structure dataOnly

inds = ismissing(dataAll.subj_uni); % indices of subjects with missing data on experiment
for f = 1:length(allF)
    dataOnly.(allF{f})(inds,:) = []; % remove NaNs and missing data from each field  
end

missing_subj_uni = dataScreen.subj_uni(inds); % subj_uni IDs of participants with missing data on experiment