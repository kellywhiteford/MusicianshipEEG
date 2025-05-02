function [corrMat] = plotWithinSubjFFRs(da_SumAvg_p)

% da_SumAvg_p indexes UMN2 before UMN
siteNames = {'BU','CMU','PU','UMN2','UMN','UR','UWO'}; 

corrMat = zeros(length(siteNames),length(siteNames));

figure('units','inch','position',[0,0,3.47,8]);
for s = 1:length(siteNames)
    
    switch siteNames{s}
        case {'UMN','UMN2'}
            if strcmp(siteNames{s},'UMN') % UMN2 indexes before UMN- subplot locations hardcoded
                subplot(7,2,7) 
                plotTimeWithBaseline(da_SumAvg_p.Cz(s,:),da_SumAvg_p.CzBaseline(s,:),da_SumAvg_p.Fs(s),'/da/',siteNames{s})
                ylim([-1 1.5])
                
                subplot(7,2,8)
                dataFFT(da_SumAvg_p.Cz(s,:),da_SumAvg_p.Fs(s),siteNames{s},1);
                
            else
                subplot(7,2,9)
                plotTimeWithBaseline(da_SumAvg_p.Cz(s,:),da_SumAvg_p.CzBaseline(s,:),da_SumAvg_p.Fs(s),'/da/',siteNames{s})
                ylim([-1 1.5])
                
                subplot(7,2,10)
                dataFFT(da_SumAvg_p.Cz(s,:),da_SumAvg_p.Fs(s),siteNames{s},1);
                
            end
        case {'BU','CMU','PU','UR','UWO'}
            subplot(7,2,s*1 + s-1)
            plotTimeWithBaseline(da_SumAvg_p.Cz(s,:),da_SumAvg_p.CzBaseline(s,:),da_SumAvg_p.Fs(s),'/da/',siteNames{s})
            ylim([-1 1.5])
            hold on
            
            subplot(7,2,s*2)
            dataFFT(da_SumAvg_p.Cz(s,:),da_SumAvg_p.Fs(s),siteNames{s},1);
            
    end
    ylim([0 .53])
    
    for uni = 1:length(siteNames)
        rs = xcorr(da_SumAvg_p.Cz(s,:),da_SumAvg_p.Cz(uni,:),'coeff'); % Cross-correlations for all lag times
        best_corr = round(max(rs),3);
        corrMat(s,uni) = best_corr;
    end
end

print('../../results/SupFig17','-dpng') 
