% This script is designed to be used to analyze the output of
% AnalyzeMinisProject (.mat file containing mini spike information

% There are two hard coded values that need to be considered:
    % values when performign a KW test
    % the length of each vector (changeVarLen is not be needed if noRA and
    % RA sample sizes are the same)

%%%%%%%%%%%% Frequency
% Make Boxplots
numCells = numel(dataList);
values = zeros(1, numCells);
labels = cell(1, numCells);
for n = 1:numCells
    values(n) = dataList(n).spikes.freq;
    labels{n} = dataList(n).Genotype;
end
fig = figure; ax = subplot(1,1,1, 'parent', fig);
boxplot(ax, values, labels, 'Notch','off')
ylabel ('frequency (Hz)')

% To do a KW test:
freq_noRA = values(:,1:9)';
freq_RA = values(:,10:end)';
freq_RA = changeVarLen(freq_noRA, freq_RA)
compareMat_freq = [freq_noRA freq_RA];
p_freq = kruskalwallis(compareMat_freq)

% Not appropriate for distribution (see KS test)
[h,p] = ttest(freq_noRA, freq_RA)

% KS test:
h = kstest(values(:,10:end))

% Plotting:
burstBoxplots(compareMat_freq, 2, 'median mini frequency (Hz)', {'no RA', 'RA'}, [1 2], 'rb')
title ('L3 only short sample set')

%%%%%%%%%%%% Amplitude
% Make Boxplots
numCells = numel(dataList);
values = zeros(1, numCells);
labels = cell(1, numCells);
for n = 1:numCells
    values(n) = dataList(n).spikes.freq;
    values(n) = median(dataList(n).spikes.height);
end
fig = figure; ax = subplot(1,1,1, 'parent', fig);
boxplot(ax, values, labels, 'Notch','off')
ylabel ('amplitude (mV)')

% To do a KW test:
amp_noRA = values(:,1:9)';
amp_RA = values(:,10:end)';
amp_RA = changeVarLen(amp_noRA, amp_RA)
compareMat_amp = [amp_noRA amp_RA];
p_amp = kruskalwallis(compareMat_amp)

% Not appropriate for distribution (see KS test)
[h,p] = ttest(amp_noRA, amp_RA)

% KS test:
h = kstest(values(:,10:end))

% Plotting:
burstBoxplots(compareMat_amp, 2, 'median mini amplitude (mV)', {'no RA', 'RA'}, [1 2], 'rb')
title ('L3 only short sample set')