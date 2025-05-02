function [dataOnly, dataAll, allPartialDataSubjs] = matchDataExps(dataExp1, dataExp2)
% INPUTS
% dataExp1            : Structure of data from experiment 1
% dataExp2            : Structure of data from experiment 2
% OUTPUTS
% dataOnly            : Structure of only the subjects that did BOTH experiments
% dataAll             : Structure of all subject data (experiments 1 and 2), including participants that are missing experiment data.
% allPartialDataSubjs : subj_uni IDs of all subjects missing data from one experimen
% dataNoMissing       : Structure of only the subjects that did BOTH experiments and are not missing data on any of the fields in each structuret

[subjsMissingExp1] = setdiff(dataExp2.subj_uni,dataExp1.subj_uni); % returns subjIDs for those that did experiment 2 but are missing experiment 1 data
[subjsMissingExp2] = setdiff(dataExp1.subj_uni,dataExp2.subj_uni); % returns subjIDs for those that did experiment 1 but are missing experiment 2 data

allPartialDataSubjs = unique([subjsMissingExp1;subjsMissingExp2]); % subjIDs for those that only did one experiment

all_subj_uni = unique([dataExp1.subj_uni;dataExp2.subj_uni]);

allFieldsExp1 = fields(dataExp1); % all fields in structure dataExp1
allFieldsExp2 = fields(dataExp2); % all fields in structure dataExp2

onlyFieldsExp1 = setdiff(allFieldsExp1,allFieldsExp2); % unique fields from experiment 1
onlyFieldsExp2 = setdiff(allFieldsExp2,allFieldsExp1); % unique fields from experiment 2
dualFields = intersect(allFieldsExp1,allFieldsExp2); % fields common to both experiment (i.e., screening data)

dataAll = dataExp1;
dataAll.exp1_subj_uni = dataExp1.subj_uni; % dataAll.subj_uni should be in the same order as dataExp1.subj_uni
dataAll.exp2_subj_uni = dataExp2.subj_uni;

c = 1;
for s = 1:length(all_subj_uni)
    
    if s <= length(dataExp1.subj_uni)
        grab = strcmp(dataExp1.subj_uni(s),dataAll.exp2_subj_uni); % return index of experiment 2 data for specific subject in experiment 1
        
        if sum(grab) == 1
            
            for f = 1:length(onlyFieldsExp2)
                
                dataAll.(onlyFieldsExp2{f})(s,1) = dataExp2.(onlyFieldsExp2{f})(grab);
                
            end
        elseif sum(grab) == 0 % no experiment data for this particular subject
            
            for f = 1:length(onlyFieldsExp2)
                
                dataAll.(onlyFieldsExp2{f})(s,1) = NaN;
                
            end
        else
            error('Something weird happened.')
        end
        
    else
        grab = strcmp(subjsMissingExp1(c),dataAll.exp2_subj_uni); % include exp 2 people that didn't do experiment 1
        
        if sum(grab) == 1
            
            for f = 1:length(allFieldsExp1)
                
                theField = allFieldsExp1{f}; 
                
                if ismember(theField,dualFields) % keep screening data
                    dataAll.(allFieldsExp1{f})(s,1) = dataExp2.(allFieldsExp1{f})(grab,1);
                else
                    dataAll.(allFieldsExp1{f})(s,1) = NaN;
                end
            end
            
            for f = 1:length(onlyFieldsExp2)
                
                dataAll.(onlyFieldsExp2{f})(s,1) = dataExp2.(onlyFieldsExp2{f})(grab);
                  
            end
            c = c+1;
        elseif sum(grab) == 0 % no experiment data for this particular subject
            error('WHAT?')
        else
            error('What the heck.')
        end
    end
end

dataOnly = dataAll;

dataOnly = rmfield(dataOnly,{'exp1_subj_uni','exp2_subj_uni'});

allF = fields(dataOnly); % all fields in structure dataOnly

missingInds = [];
for ii = 1:length(onlyFieldsExp1)
    missingInds = [missingInds; find(ismissing(dataAll.(onlyFieldsExp1{ii}))==1)];
end
for ii = 1:length(onlyFieldsExp2)
    missingInds = [missingInds; find(ismissing(dataAll.(onlyFieldsExp2{ii}))==1)];
end

inds = unique(missingInds); 
for f = 1:length(allF)
    dataOnly.(allF{f})(inds,:) = []; % remove NaNs and missing data from each field  
end



