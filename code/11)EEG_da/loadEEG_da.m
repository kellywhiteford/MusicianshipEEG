% Loads /da/ EEG data for Musicianship study.

function [da_dat] = loadEEG_da
% Output
% da_dat      : structure with /da/ EEG data and subj_uni IDs

load da_dat.mat

da_dat.F0amp = da_dat.F0amp';
da_dat.Hamp = da_dat.Hamp';

subj_uni = string(da_dat.subj_uni);


%% REMOVE V2 LABELS
for s=1:length(subj_uni)
    if contains(subj_uni{s},'v2')
        ID = extractBefore(subj_uni{s},'_v2_');
        uni = extractAfter(subj_uni{s},'_v2_');
        subj_uni(s) = strcat(ID,'_',uni); % '_v2' removed so that subj now matches the online screening
    end
end

da_dat.subj_uni = subj_uni;