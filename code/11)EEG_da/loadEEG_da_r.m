% Loads /da/ EEG stimulus-to-response correlations for Musicianship study.

function [r_dat, rA_dat] = loadEEG_da_r
% Output
% r_dat      : structure with /da/ EEG stimulus-to-response correlations

load stim2resp.mat

r_dat.r = stim2resp.r';
r_dat.z = stim2resp.z';

subj_uni = string(stim2resp.subj_uni);

load stim2resp_adjusted.mat

rA_dat.r = stim2resp_adjusted.r';
rA_dat.z = stim2resp_adjusted.z';
rA_dat.r_lim = stim2resp_adjusted.r_lim';
rA_dat.z_lim = stim2resp_adjusted.z_lim';

subj_uni_rA = string(stim2resp_adjusted.subj_uni);

%% REMOVE V2 LABELS FROM ORIGINAL STIM2RESP
for s=1:length(subj_uni)
    if contains(subj_uni{s},'v2')
        ID = extractBefore(subj_uni{s},'_v2_');
        uni = extractAfter(subj_uni{s},'_v2_');
        subj_uni(s) = strcat(ID,'_',uni); % '_v2' removed so that subj now matches the online screening
    end
end

r_dat.subj_uni = subj_uni;

%% REMOVE V2 LABELS FROM ADJUSTED STIM2RESP
for s=1:length(subj_uni_rA)
    if contains(subj_uni_rA{s},'v2')
        ID = extractBefore(subj_uni_rA{s},'_v2_');
        uni = extractAfter(subj_uni_rA{s},'_v2_');
        subj_uni_rA(s) = strcat(ID,'_',uni); % '_v2' removed so that subj now matches the online screening
    end
end

rA_dat.subj_uni = subj_uni_rA;