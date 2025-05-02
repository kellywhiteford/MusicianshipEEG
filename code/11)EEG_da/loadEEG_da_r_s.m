% Loads /da/ EEG stimulus-to-response correlations for Musicianship study.

function rA_dat_s = loadEEG_da_r_s
% Output
% r_dat      : structure with /da/ EEG stimulus-to-response correlations

load stim2resp_adjusted_s.mat

rA_dat_s.r_h1 = stim2resp_adjusted_s.r_h1';
rA_dat_s.z_h1 = stim2resp_adjusted_s.z_h1';
rA_dat_s.r_lim_h1 = stim2resp_adjusted_s.r_lim_h1';
rA_dat_s.z_lim_h1 = stim2resp_adjusted_s.z_lim_h1';

rA_dat_s.r_h2 = stim2resp_adjusted_s.r_h2';
rA_dat_s.z_h2 = stim2resp_adjusted_s.z_h2';
rA_dat_s.r_lim_h2 = stim2resp_adjusted_s.r_lim_h2';
rA_dat_s.z_lim_h2 = stim2resp_adjusted_s.z_lim_h2';

subj_uni_rA = string(stim2resp_adjusted_s.subj_uni);

%% REMOVE V2 LABELS FROM ADJUSTED STIM2RESP
for s=1:length(subj_uni_rA)
    if contains(subj_uni_rA{s},'v2')
        ID = extractBefore(subj_uni_rA{s},'_v2_');
        uni = extractAfter(subj_uni_rA{s},'_v2_');
        subj_uni_rA(s) = strcat(ID,'_',uni); % '_v2' removed so that subj now matches the online screening
    end
end

rA_dat_s.subj_uni = subj_uni_rA;