function [newDat] = rmvSubjs(dat,badSubj)

allFields = fields(dat); % all fields in structure dataDa

ind_x = find(ismember(dat.subj_uni,badSubj) == 1); % indices of subjects to remove
newDat = dat;

for f = 1:length(allFields)
    newDat.(allFields{f})(ind_x) = []; % Remove subjects from structure
end