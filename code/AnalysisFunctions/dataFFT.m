% Plots FFT of steady-state EEG response (60-180 ms) to /da/ in babble
% Calculates the average amplitude of the EEG response (in microVolts) to
% 60-Hz wide frequency bins, linearly centered around harmonics 1-10.

function [h_avg, data, freq] = dataFFT(avgDat,Fs,site,makePlot) 
% Input
% avgDat   : row vector with EEG data averaged across epochs
% Fs       : sampling rate 
% site     : string of the university site location
% makePlot : value of 1 or 0, where 1 will make a plot and 0 will not

% Output
% h_avg   : Vector with average amplitude (in micorVolts) of the EEG response for each harmonic (1-10)
% freq    : The frequency values used for plotting the x-axis of figure

Lw = 1; % Line width

minTime = 60; % Time where steady-state portion begins (ms)
maxTime = 180; % Time where steady-state portion ends (ms)
minSamp = round(minTime * Fs/1000); % convert ms to samples
maxSamp = round(maxTime * Fs/1000); % convert ms to samples
steadyState = avgDat(1,minSamp:maxSamp); % just the steady-state response to /da/

L = length(steadyState);  % Length (in samples) of the steady-state portion of the /da/ response

x = 2; 
NFFT = 2^(nextpow2(L)+x); % Lots of zero-padding to smoothen fft plot

freq = Fs/2*linspace(0,1,NFFT/2+1);  % frequency values for plotting; length needs to be the same as data for plot
data = fft(steadyState,NFFT)/L;  % Because NFFT is greater than the length of steady-state, steady-state will be padded with zeros
data = 2*abs(data(1:NFFT/2+1)); % Just keep the positive values, and multiply them by 2 to account for that we're taking half the fft data

% Plot the data
if makePlot == 1
    h = plot(freq,data,'k');
    set(gca,'linewidth',Lw)
    h.LineWidth = Lw;
    xlim([0 1100]) % x-axis limits
    % ylim([0,.4]) % Hard-coded- change this to change y-axis limits
    title(site)
    ylabel(['Amplitude (',char(181),'V)'])
    xlabel('Frequency (Hz)')
end

% Data for analyses
f0 = 100; % stimulus F0
h_nums = 1:10; % harmonic numbers 
fs_h = f0*h_nums; % frequencies of harmonics

low = fs_h - 30; % cut-off for low frequency
high = fs_h + 30; % cut-off for high frequency

h_avg = zeros(1,10);
for h = 1:10
    inds_h = freq <= high(h); % indices for frequencies in bin #h that are <= high-frequency cutoff
    inds_l = freq >= low(h);
    inds_both = inds_h + inds_l; % indices for frequencies in bin #h
    inds = inds_both == 2;
    h_avg(h) = mean(data(inds)); % average amplitude (in microVolts) to EEG response for #h frequency bin
end





