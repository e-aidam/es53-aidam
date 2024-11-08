%% Header
% Pset 6
% Author: Ethan Aidam
% Date: 10/29/2024

%% Question 5d: Plotting ECG

% Loading ECG data
data = load("ECGar.mat");

t = [4:4:14400];

% Plotting ECG
figure, hold on
plot(t, data.ECGar);
xlabel('Time (ms)');
ylabel('ECG Amplitude');

% Finding peaks in ECG data
[peaks, locs] = findpeaks(data.ECGar, 'MinPeakHeight', 150);

% Plotting "R" Peaks with Green Squares
plot(t(locs), peaks, 'gs','MarkerFaceColor','g','MarkerSize',10);
hold off

% Question 5e: Calculating Heart Rate
hr = ((length(locs) + 1) / (length(data.ECGar) / 250 / 60)); % 66.67 BPM

