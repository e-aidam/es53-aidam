%% Header
% Fourth ES53 Lab: Fig. 4, 9, Table 4
% Author: Ethan Aidam
% Date: 10/23/2024

%% Figure 4

% loading Exercise 2 data
a = load("Lab4_Ex2_Andrea2.mat");
s = load("Lab4_Ex2_SR1.mat");
e = load("Lab4_SubA_Ex1.mat");

dt = 1/a.samplerate(1);

% Snipping data where pressure is at or near 0 mmHG
afrom = a.datastart(2,1) + a.com(2,3);
ato = afrom + 10*a.samplerate(1);
asnip = a.data(afrom:ato);

sfrom = s.datastart(2,1) + s.com(2,3);
sto = sfrom + 10*s.samplerate(1);
ssnip = s.data(sfrom:sto);

efrom = e.datastart(2,1) + e.com(2,3) + 10*e.samplerate(1);
eto = efrom + 10*e.samplerate(1);
esnip = e.data(efrom:eto);

peaks = [peaks_a(1,1),peaks_s(1,1),peaks_e(1,1)];
mean_peaks = mean(peaks)
% Finding peaks
[peaks_a, locs_a] = findpeaks(asnip, "MinPeakDistance",0.5*a.samplerate(1));
[peaks_s, locs_s] = findpeaks(ssnip);
[peaks_e, locs_e] = findpeaks(esnip, "MinPeakDistance",0.5*e.samplerate(1));


% Creating Figure to plot data
figure(1), hold on

t = (0:length(asnip)-1) * dt ;

% Subplot for Andrea
subplot(3,1,1); hold on;
plot(t, asnip, 'LineWidth',2);
plot(t(locs_a), peaks_a, '*');
xlabel('Time (seconds)');
ylabel('Pulse Wave Magnitude');
title("Andrea")
grid on;
hold off;

% Subplot for Sarah Rose
subplot(3,1,2); hold on;
plot(t, ssnip, 'LineWidth',2);
plot(t(locs_s), peaks_s, '*');
xlabel('Time (seconds)');
ylabel('Pulse Wave Magnitude');
title("Sarah Rose")
grid on;
hold off;

% Subplot for Ethan
subplot(3,1,3); hold on;
plot(t, esnip, 'LineWidth',2);
plot(t(locs_e), peaks_e, '*');
xlabel('Time (seconds)');
ylabel('Pulse Wave Magnitude');
title("Ethan")
grid on;
hold off;

hold off

%% Table 4, Calculating Cardiac Output and Stroke Volume

% Estimated CCA flows in ml/min
a_cca = 213.82;
s_cca = 200.28;
e_cca = 206.70;

% Multiplying by 2 to account for both CCAs
a_cca = a_cca * 2;
s_cca = s_cca * 2;
e_cca = e_cca * 2;

% Calculating CO (Both CCAs account for 10% of Cardiac Output)
% 1/0.1 = 10
co_factor = 10;
a_co = a_cca * co_factor; % 4276.4 ml/min
s_co = s_cca * co_factor; % 4005.6 ml/min
e_co = e_cca * co_factor; % 4134 ml/min

co_values = [a_co, s_co, e_co];
mean_co = mean(co_values); % 4138.7 ml/min
std_co = std(co_values); % 135.4603 ml/min

% Calculating SV (SV = CO/HR)
% Heart rates
a_hr = 85.71;
s_hr = 75;
e_hr = 75;

% Stroke Volumes
a_sv = a_co / a_hr; % 49.8938 ml
s_sv = s_co / s_hr; % 53.4080 ml
e_sv = e_co / e_hr; % 55.1200 ml

sv_values = [a_sv, s_sv, e_sv];
mean_sv = mean(sv_values); % 52.8073 ml
std_sv = std(sv_values); % 2.6644 ml

% Figure 9
close all

% Calculating Stroke Work (SW = SV * MAP)
% MAP = 2/3 sys + 1/3 dias
a_sys = 110;
a_dias = 72;
a_map = (2/3)*a_sys + (1/3)*a_dias;

s_sys = 115;
s_dias = 75;
s_map = (2/3)*s_sys + (1/3)*s_dias;

e_sys = 116;
e_dias = 80;
e_map = (2/3)*e_sys + (1/3)*e_dias;

ex_sys = 120;
ex_dias = 80;
ex_map = (2/3)*ex_sys + (1/3)*ex_dias;


% Convert from mmHg to Pa
a_map = a_map * 133;
s_map = s_map * 133;
e_map = e_map * 133;
ex_map = ex_map * 133;

% Convert from ml to cubic meters
a_sv = a_sv * 1e-6;
s_sv = s_sv * 1e-6;
e_sv = e_sv * 1e-6;
ex_sv = 80; %expected stroke volume = 80 ml 
ex_sv = ex_sv * 1e-6;

% Group Members' Stroke Works
a_sw = a_sv * a_map;
s_sw = s_sv * s_map;
e_sw = e_sv * e_map;
ex_sw = ex_sv * ex_map;
% Data for the bars
y = [ex_sw, a_sw, s_sw, e_sw]; 
mean_w = mean(y)
barlabels = {'Expected','Andrea','Sarah Rose','Ethan'};

% Create the bar plot
figure;
bar(barlabels, y);

% Add labels
xlabel('Subject');
ylabel('Stroke Work (Joules)');

grid on;
