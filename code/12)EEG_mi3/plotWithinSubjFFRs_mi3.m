function [corrMat] = plotWithinSubjFFRs_mi3(mi3_SumAvg_p,stim)

% mi3_SumAvg_p indexes UMN2 before UMN
siteNames = {'BU','CMU','PU','UMN2','UMN','UR','UWO'}; 

all_f0Max = zeros(length(siteNames),238);
f0_stimToResp = zeros(1,length(siteNames));

corrMat = zeros(length(siteNames),length(siteNames));

figure('units','inch','position',[0,0,3.47,8]);
for s = 1:length(siteNames)
    
    switch siteNames{s}
        case {'UMN','UMN2'}
            if strcmp(siteNames{s},'UMN') % UMN2 indexes before UMN- subplot locations hardcoded
                subplot(7,2,7)
                plotTimeWithBaseline(mi3_SumAvg_p.Cz(s,:),mi3_SumAvg_p.CzBaseline(s,:),mi3_SumAvg_p.Fs(s),'/mi3/',siteNames{s})
                xlim([-45 296])
                
                subplot(7,2,8)
                f0Max_stim = slidingFFT_mi3(stim,0.*mi3_SumAvg_p.CzBaseline(s,:),mi3_SumAvg_p.Fs(s),0,'yes','yes'); % sliding FFT on stimulus
                hold on
                f0Max = slidingFFT_mi3(mi3_SumAvg_p.Cz(s,:),mi3_SumAvg_p.CzBaseline(s,:),mi3_SumAvg_p.Fs(s),mi3_SumAvg_p.FixedDelay_ms(s),'no','yes'); % sliding FFT on EEG response
                
                
            else
                subplot(7,2,9)
                plotTimeWithBaseline(mi3_SumAvg_p.Cz(s,:),mi3_SumAvg_p.CzBaseline(s,:),mi3_SumAvg_p.Fs(s),'/mi3/',siteNames{s})
                xlim([-45 296])
                
                subplot(7,2,10)
                f0Max_stim = slidingFFT_mi3(stim,0.*mi3_SumAvg_p.CzBaseline(s,:),mi3_SumAvg_p.Fs(s),0,'yes','yes'); % sliding FFT on stimulus
                hold on
                f0Max = slidingFFT_mi3(mi3_SumAvg_p.Cz(s,:),mi3_SumAvg_p.CzBaseline(s,:),mi3_SumAvg_p.Fs(s),mi3_SumAvg_p.FixedDelay_ms(s),'no','yes'); % sliding FFT on EEG response
                
            end
        case {'BU','CMU','PU','UR','UWO'}
            subplot(7,2,s*1 + s-1)
            plotTimeWithBaseline(mi3_SumAvg_p.Cz(s,:),mi3_SumAvg_p.CzBaseline(s,:),mi3_SumAvg_p.Fs(s),'/mi3/',siteNames{s})
            xlim([-45 296])
            hold on
            
            subplot(7,2,s*2)
            f0Max_stim = slidingFFT_mi3(stim,0.*mi3_SumAvg_p.CzBaseline(s,:),mi3_SumAvg_p.Fs(s),0,'yes','yes'); % sliding FFT on stimulus
            hold on
            f0Max = slidingFFT_mi3(mi3_SumAvg_p.Cz(s,:),mi3_SumAvg_p.CzBaseline(s,:),mi3_SumAvg_p.Fs(s),mi3_SumAvg_p.FixedDelay_ms(s),'no','yes'); % sliding FFT on EEG response
            
    end
    title(siteNames{s})
    
    all_f0Max(s,:) = f0Max; % store F0max for all sites
    
    f0_stimToResp(s) = round(corr(f0Max',f0Max_stim'),3); % F0 tracking stimulus-to-response correlation
    
    for uni = 1:length(siteNames)
        rs = xcorr(mi3_SumAvg_p.Cz(s,:),mi3_SumAvg_p.Cz(uni,:),'coeff'); % Cross-correlations for all lag times
        best_corr = round(max(rs),3);
        corrMat(s,uni) = best_corr;
    end
end

print('../../results/SupFig18','-dpng') 
