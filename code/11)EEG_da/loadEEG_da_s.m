% Loads /da/ EEG data for Musicianship study.

function [da_dat_s] = loadEEG_da_s
% Output
% da_dat      : structure with /da/ EEG data and subj_uni IDs

load da_dat_s.mat

da_dat_s.F0amp_h1 = da_dat_s.F0amp_h1';
da_dat_s.F0amp_h2 = da_dat_s.F0amp_h2';
da_dat_s.Hamp_h1 = da_dat_s.Hamp_h1';
da_dat_s.Hamp_h2 = da_dat_s.Hamp_h2';

subj_uni = string(da_dat_s.subj_uni);


%% REMOVE V2 LABELS
for s=1:length(subj_uni)
    if contains(subj_uni{s},'v2')
        ID = extractBefore(subj_uni{s},'_v2_');
        uni = extractAfter(subj_uni{s},'_v2_');
        subj_uni(s) = strcat(ID,'_',uni); % '_v2' removed so that subj now matches the online screening
    end
end

da_dat_s.subj_uni = subj_uni;