% Plots time waveform of EEG data

function plotTimeWithBaseline(avgDat,baselineDat,SR,condition,site,isStim)
% avgDat   : row vector with EEG data averaged across epochs
% baselineDat : row vector with baseline EEG data averaged across epochs
% SR       : sampling rate 
% condition: string indicating "/da/" or "/mi3/"
% site     : string of the university site location
% isStim   : optional variable- include something here if plotting stimulus

baseline_xLabel = -1.*fliplr(1000*((1:(size(baselineDat,2)))/SR));
stim_xLabel = 1000*((1:(size(avgDat,2)))/SR);


X_Axis = [baseline_xLabel,stim_xLabel];
Y_Axis = [baselineDat, avgDat];
h = plot(X_Axis,Y_Axis,'k');
title(site)
xlabel('Time (ms)')


if exist('isStim','var')
    ylabel('Amplitude')
else
    ylabel(['Amplitude (',char(181),'V)'])
end


switch condition
    case '/da/'
         xlim([-40 213])
     
    case '/mi3/'
        %ylim([-.6 1])
end


end
