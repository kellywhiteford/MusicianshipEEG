% Loads /mi3/ EEG data for Musicianship study.

function [mi3_dat] = loadEEG_mi3
% Output
% mi3_dat      : structure with /mi3/ EEG data and subj_uni IDs

load mi3_dat.mat

mi3_dat.Stim2resp_r = mi3_dat.Stim2resp_r';
mi3_dat.Stim2resp_z = mi3_dat.Stim2resp_z';

subj_uni = string(mi3_dat.subj_uni);


%% REMOVE V2 LABELS
for s=1:length(subj_uni)
    if contains(subj_uni{s},'v2')
        ID = extractBefore(subj_uni{s},'_v2_');
        uni = extractAfter(subj_uni{s},'_v2_');
        subj_uni(s) = strcat(ID,'_',uni); % '_v2' removed so that subj now matches the online screening
    end
end

mi3_dat.subj_uni = subj_uni;