%% Header
% Third ES53 Lab: Fig. 1, 2, 3, & 4, Table 1 & 2
% Author: Ethan Aidam
% Date: 10/10/2024

%% Figure 1: Exercise 1 - Recognizing ECG Artifact
e = load('Lab3_SubA_Ex1.mat');
dt = 1/e.samplerate(1);

% loading Still ECG data
efrom = e.datastart(1,1);
eto = efrom + 10*e.samplerate(1);
esnip = e.data(efrom:eto);

% loading Jumping Jacks ECG data
efrom1 = e.datastart(1,1) + e.com(3,3);
eto1 = efrom1 + 10*e.samplerate(1);
esnip1 = e.data(efrom1:eto1);

% Plotting both overlayed in 1 Figure
figure(1), hold on

t = (0:length(esnip1)-1) * dt ; 

plot(t, esnip);
plot(t, esnip1);
xlabel("Time (s)");
ylabel("Voltage (V)");
legend("Still","Jumping Jacks");
%ylim([1*10^-4 1*10^-3])

hold off

%% Exercise 2 Figures
% Figure 2: Exercise 2 - Sitting

clear all
close all

% Loading all group members data
e = load("Lab3_SubA_Ex2.mat");
s = load("Lab3_SubB_Ex2.mat");
a = load("Lab3_SubC_Ex2.mat");
dt = 1/e.samplerate(1);


% Snipping group members data (Sitting)
efrom = e.datastart(1,1) + e.com(1,3);
eto = efrom + 10*e.samplerate(1);
esnip = e.data(efrom:eto);

sfrom = s.datastart(1,1) + s.com(1,3);
sto = sfrom + 10*s.samplerate(1);
ssnip = s.data(sfrom:sto);

afrom = a.datastart(1,1) + a.com(1,3);
ato = afrom + 10*a.samplerate(1);
asnip = a.data(afrom:ato);

% Plotting all group member data in 1 figure
figure(2), hold on

t = (0:length(esnip)-1) * dt ; 

plot(t, esnip);
plot(t, ssnip);
plot(t, asnip);
xlabel("Time (s)");
ylabel("Voltage (V)");
legend("Ethan","Sarah Rose","Andrea");

hold off

% Figure 3: Exercise 2 - Standing

% Snipping group members data over standing interval
efrom = e.datastart(1,2) + e.com(1,3);
eto = efrom + 10*e.samplerate(1);
esnip = e.data(efrom:eto);

sfrom = s.datastart(1,2) + s.com(1,3);
sto = sfrom + 10*s.samplerate(1);
ssnip = s.data(sfrom:sto);

afrom = a.datastart(1,2) + a.com(1,3);
ato = afrom + 10*a.samplerate(1);
asnip = a.data(afrom:ato);

% Plotting all group member standing data 
figure(3), hold on

t = (0:length(esnip)-1) * dt ; 

plot(t, esnip);
plot(t, ssnip);
plot(t, asnip);
xlabel("Time (s)");
ylabel("Voltage (V)");
legend("Ethan","Sarah Rose","Andrea");

hold off

% Figure 4: Ex. 2 - Sitting v. Standing v. Post-exercise
% Using Ethan's data

% Sitting
efrom1 = e.datastart(1,1) + e.com(1,3);
eto1 = efrom1 + 10*e.samplerate(1);
esnip1 = e.data(efrom1:eto1);

% Standing
efrom2 = e.datastart(1,2) + e.com(1,3);
eto2 = efrom2 + 10*e.samplerate(1);
esnip2 = e.data(efrom2:eto2);

% Post-Execise
efrom3 = e.datastart(1,3) + e.com(1,3);
eto3 = efrom3 + 10*e.samplerate(1);
esnip3 = e.data(efrom3:eto3);

% Plotting Andrea's ECG data in Figure 4
figure(4), hold on

t = (0:length(esnip)-1) * dt ; 

plot(t, esnip1);
plot(t, esnip2);
plot(t, esnip3);
xlabel("Time (s)");
ylabel("Voltage (V)");
legend("Sitting","Standing","Post-Exercise");

hold off

%% Exersise 2: Table 1  & Table 2 - Sitting/Standing  R-R Intervals

clear all
close all

% Ethan RR Interval and HR (Sitting)
% Loading Ethan's data
e = load("Lab3_SubA_Ex2.mat");
dt = 1/e.samplerate(1);

% Snipping Ethan data (Sitting)
efrom = e.datastart(1,1) + e.com(1,3);
eto = efrom + 10*e.samplerate(1);
esnip = e.data(efrom:eto);
te = (0:length(esnip)-1) * dt ; 

% I edited the "peak_finder.m" function to return the array of peak
% intervals under the "peak_interval" variable.
% Finding peaks for sitting data
[rrm_e, rrstd_e, hr_e, ~,~, peak_interval] = peak_finder(esnip,te, 0.0005, 0.001);
max_e = max(peak_interval);% Find Max R-R Interval
min_e = min(peak_interval);% Find Min R-R Interval
rrm_e % Ethan R-R Interval Mean: 1.3413 seconds
max_e % Ethan Max Interval: 1.3660 seconds
min_e % Ethan Min Interval: 1.3070 seconds
rrstd_e % Ethan R-R Interval S.D.: 0.0223 seconds
hr_e % Ethan Heart Rate: 44.7316 BPM

% Snipping Ethan data (Standing)
efrom1 = e.datastart(1,2) + e.com(1,3);
eto1 = efrom1 + 10*e.samplerate(1);
esnip1 = e.data(efrom1:eto1);
te1 = (0:length(esnip1)-1) * dt ; 

% Finding peaks for standing data
[rrm_e1, rrstd_e1, hr_e1, ~,~, peak_interval1] = peak_finder(esnip1,te1, 0.0003, 0.0005);
max_e1 = max(peak_interval1);% Find Max R-R Interval
min_e1 = min(peak_interval1);% Find Min R-R Interval
rrm_e1 % Ethan R-R Interval Mean: 0.9603 seconds
max_e1 % Ethan Max Interval: 1.0010 seconds
min_e1 % Ethan Min Interval: 0.9180 seconds
rrstd_e1 % Ethan R-R Interval S.D.: 0.0272 seconds
hr_e1 % Ethan Heart Rate: 62.4783 BPM


%% Sarah RR Intervals and HR

clear all
close all

% Loading Sarah's data
s = load("Lab3_SubB_Ex2.mat");
dt = 1/s.samplerate(1);

% Snipping Sarah's data (Sitting)
sfrom = s.datastart(1,1) + s.com(1,3);
sto = sfrom + 10*s.samplerate(1);
ssnip = s.data(sfrom:sto);
ts = (0:length(ssnip)-1) * dt ; 

% Finding peaks of Sitting data
[rrm_s, rrstd_s, hr_s, ~,~, peak_interval1] = peak_finder(ssnip,ts, 0.0005, 0.001);
max_s = max(peak_interval1);% Find Max R-R Interval
min_s = min(peak_interval1);% Find Min R-R Interval
rrm_s % Sarah R-R Interval Mean: 1.2217 seconds
max_s % Sarah Max Interval: 1.3510 seconds
min_s % Sarah Min Interval: 1.1070 seconds
rrstd_s % Sarah R-R Interval S.D.: 0.0865 seconds
hr_s % Sarah Heart Rate: 49.1113 BPM

% Snipping Sarah's data (Standing)
sfrom1 = s.datastart(1,2) + s.com(1,3);
sto1 = sfrom1 + 10*s.samplerate(1);
ssnip1 = s.data(sfrom1:sto1);
ts1 = (0:length(ssnip1)-1) * dt ; 

% Finding peaks of Standing data
[rrm_s1, rrstd_s1, hr_s1, ~,~, peak_interval1] = peak_finder(ssnip1,ts1, 0.0004, 0.0006);
max_s1 = max(peak_interval1);% Find Max R-R Interval
min_s1 = min(peak_interval1);% Find Min R-R Interval
rrm_s1 % Sarah R-R Interval Mean: 0.7514 seconds
max_s1 % Sarah Max Interval: 1.0180 seconds
min_s1 % Sarah Min Interval: 0.6880 seconds
rrstd_s1 % Sarah R-R Interval S.D.: 0.1028 seconds
hr_s1 % Sarah Heart Rate: 79.8492 BPM
%% Andrea RR Intervals and HR

clear all
close all

a = load("Lab3_SubC_Ex2.mat");
dt = 1/a.samplerate(1);

% Snipping Andrea's data (Sitting)
afrom = a.datastart(1,1);
ato = afrom + 10*a.samplerate(1);
asnip = a.data(afrom:ato);
ta = (0:length(asnip)-1) * dt ; 

% Finding Peaks of Sitting data
[rrm_a, rrstd_a, hr_a, ~,~, peak_interval1] = peak_finder(asnip,ta, 0.0003, 0.0005);
max_a = max(peak_interval1);% Find Max R-R Interval
min_a = min(peak_interval1);% Find Min R-R Interval
rrm_a % Andrea R-R Interval Mean: 0.9821 seconds
max_a % Andrea Max Interval: 5.5890 seconds
min_a % Andrea Min Interval: 0.2180 seconds
rrstd_a % Andrea R-R Interval S.D.: 1.7399 seconds
hr_a % Andrea Heart Rate: 61.0929 BPM

% Snipping Andrea's data for Standing Interval
afrom1 = a.datastart(1,2);
ato1 = afrom1 + 10*a.samplerate(1);
asnip1 = a.data(afrom1:ato1);
ta1 = (0:length(asnip1)-1) * dt ; 

% Finding peaks for Standing data
[rrm_a1, rrstd_a1, hr_a1, ~,~, peak_interval1] = peak_finder(asnip1,ta1, 0.0003, 0.0005);
max_a1 = max(peak_interval1);% Find Max R-R Interval
min_a1 = min(peak_interval1);% Find Min R-R Interval
rrm_a1 % Andrea R-R Interval Mean: 0.7028 seconds
max_a1 % Andrea Max Interval: 0.7650 seconds
min_a1 % Andrea Min Interval: 0.6500 seconds
rrstd_a1 % Andrea R-R Interval S.D.: 0.0430 seconds
hr_a1 % Andrea Heart Rate: 85.3672 BPM
