% Removes subjects from dataExp who are missing data from fieldName
function [dataNoMissing, allPartialDataSubjs] = grabOneField(dataExp, fieldName)
% INPUTS
% dataExp             : Structure of data from experiment (NOTE: rows of all fields must correspond to subjects)
% fieldName           : Variable name for one field (string)
% OUTPUTS
% dataNoMissing       : Structure of experiment data for subjects that are not missing data on fieldName
% allPartialDataSubjs : subj_uni IDs of all subjects missing data from either the experiments 

allF = fields(dataExp); % all fields in structure dataOnly

inds = ismissing(dataExp.(fieldName)); 

allPartialDataSubjs = dataExp.subj_uni(inds); % subjects missing data from fieldName

dataNoMissing = dataExp;

for f = 1:length(allF)
    dataNoMissing.(allF{f})(inds,:) = []; % remove NaNs and missing data from each field  
end
