%% Header
% Third ES53 Lab: Ex. 2 & 3
% Author: Ethan Aidam
% Date: 9/19/2024

%% Figure 1
b = load('Lab1_Ex2_EthanAidam.mat');
dt = 1/b.samplerate(1);
% loading bicep EMG data
bfrom = b.datastart(3,1) + b.com(2,3);
bto = bfrom + 13*b.samplerate(1);
bsnip = b.data(bfrom:bto);
% loading tricep EMG data
bfrom2 = b.datastart(4,1) + b.com(2,3);
bto2 = bfrom2 + 13*b.samplerate(1);
disp(['bfrom2: ', num2str(bfrom2)]);
disp(['bto2: ', num2str(bto2)]);
bsnip2 = b.data(bfrom2:bto2);
t = (0:length(bsnip)-1)*dt;
[up1, load1] = envelope(bsnip, 50, 'rms');
rmssmooth1 = smooth(up1, 10);
subplot(2,1,1), hold on
plot(t, bsnip)
plot(t, rmssmooth1, 'LineWidth',2)
ylabel("Bicep EMG or RMS Amplitude (mV)")
xlabel("Time (s)")
hold off
[up2, load2] = envelope(bsnip2, 50, 'rms');
rmssmooth2 = smooth(up2, 10);
subplot(2,1,2),  hold on
plot(t, bsnip2)
plot(t, rmssmooth2, 'LineWidth',2)
ylabel("Tricep EMG or RMS Amplitude (mV)")
xlabel("Time (s)")
hold off

%% Table 1: Calculating the Ratio of EMG RMS amplitude of intended vs. non inteded muscle
% Loading exercise data
e = load('Lab1_Ex2_EthanAidam.mat');
m = load('Lab1_Ex2_MichelleYang.mat');
v = load('Lab1_Ex2_VictoriaZambrano.mat');
% Intended Bicep contraction data
%bicep rms
ebstart = e.datastart(1,1) + e.com(2,3);
ebend = e.datastart(1,1) + e.com(2,3) + 10 * e.samplerate;
%tricep rms
ebstart2 = e.datastart(2,1) + e.com(2,3);
ebend2 = e.datastart(2,1) + e.com(2,3) + 10 * e.samplerate;
%bicep rms
mbstart = m.datastart(1,1) + m.com(2,3) + 4 * m.samplerate;
mbend = m.datastart(1,1) + m.com(2,3) + 20 * m.samplerate;
%tricep rms
mbstart2 = m.datastart(2,1) + m.com(2,3) + 4 * m.samplerate;
mbend2 = m.datastart(2,1) + m.com(2,3) + 20 * m.samplerate;
%bicp rms
vbstart = v.datastart(1,1) + v.com(2,3);
vbend = v.datastart(1,1) + v.com(2,3) + 10 * v.samplerate;
%tricep rms
vbstart2 = v.datastart(2,1) + v.com(2,3);
vbend2 = v.datastart(2,1) + v.com(2,3) + 10 * v.samplerate;
% Intended Tricep contraction data
%tricep rms
etstart = e.datastart(2,1) + e.com(2,3) + 4 * e.samplerate;
etend = e.datastart(2,1) + e.com(2,3) + 10 * e.samplerate;
%bicep rms
etstart2 = e.datastart(1,1) + e.com(2,3) + 4 * e.samplerate;
etend2 = e.datastart(1,1) + e.com(2,3) + 10 * e.samplerate;
%tricep rms
mtstart = m.datastart(2,1) + m.com(2,3) + 8 * m.samplerate;
mtend = m.datastart(2,1) + m.com(2,3) + 24 * m.samplerate;
%bicep rms
mtstart2 = m.datastart(1,1) + m.com(2,3) + 8 * m.samplerate;
mtend2 = m.datastart(1,1) + m.com(2,3) + 24 * m.samplerate;
%tricep rms
vtstart = v.datastart(2,1) + v.com(2,3) + 4 * v.samplerate;
vtend  = v.datastart(2,1) + v.com(2,3) + 14 * v.samplerate;
%bicep rms
vtstart2 = v.datastart(1,1) + v.com(2,3) + 4 * v.samplerate;
vtend2  = v.datastart(1,1) + v.com(2,3) + 14 * v.samplerate;
% Active Bicep Contraction: RMS/Peaks
%ethan
ethan_abiceprms = e.data(ebstart : ebend);
ethan_abiceppeak = findpeaks(ethan_abiceprms);
ethan_triceprms = e.data(ebstart2 : ebend2);
ethan_triceppeak = findpeaks(ethan_triceprms);
%michelle
michelle_abiceprms = m.data(mbstart : mbend);
michelle_abiceppeak = findpeaks(michelle_abiceprms);
michelle_triceprms = m.data(mbstart2 : mbend2);
michelle_triceppeak = findpeaks(michelle_triceprms);
%victoria
victoria_abiceprms = v.data(vbstart : vbend);
victoria_abiceppeak = findpeaks(victoria_abiceprms);
victoria_triceprms = e.data(vbstart2 : vbend2);
victoria_triceppeak = findpeaks(victoria_triceprms);
% Active Bicep Contraction: RMS Mean Values
%ethan
eab_mean = mean(ethan_abiceppeak);
et_mean = mean(ethan_triceppeak);
%michelle
mab_mean = mean(michelle_abiceppeak);
mt_mean = mean(michelle_triceppeak);
%victoria
vab_mean = mean(victoria_abiceppeak);
vt_mean = mean(victoria_triceppeak);
% Active Tricep: RMS/Peak
%ethan
ethan_atriceprms = e.data(etstart : etend);
ethan_atriceppeak = findpeaks(ethan_atriceprms);
ethan_biceprms = e.data(etstart2 : etend2);
ethan_biceppeak = findpeaks(ethan_biceprms);
%michelle
michelle_atriceprms = m.data(mtstart : mtend);
michelle_atriceppeak = findpeaks(michelle_atriceprms);
michelle_biceprms = m.data(mtstart2 : mtend2);
michelle_biceppeak = findpeaks(michelle_biceprms);
%victoria
victoria_atriceprms = v.data(vtstart : vtend);
victoria_atriceppeak = findpeaks(victoria_atriceprms);
victoria_biceprms = v.data(vtstart2 : vtend2);
victoria_biceppeak = findpeaks(victoria_biceprms);
% Tricep: RMS Mean Value
%ethan
eat_mean = mean(ethan_atriceppeak);
eb_mean = mean(ethan_biceppeak);
%michelle
mat_mean = mean(michelle_atriceppeak);
mb_mean = mean(michelle_biceppeak);
%victoria
vat_mean = mean(victoria_atriceppeak);
vb_mean = mean(victoria_biceppeak);
% Show Table
T = table( ...
   [eab_mean;et_mean],[eb_mean;eat_mean], ...
   [mab_mean;mt_mean],[mb_mean;mat_mean], ...
   [mab_mean;et_mean],[mb_mean;eat_mean]);
disp(T) 

%% Figure 2: Coactivation of muscles as measured by the RMS of the EMG from biceps and triceps.
% Ratio: Active Bicep Contraction Ratio
eab_ratio = eab_mean / et_mean;
mab_ratio = mab_mean / mt_mean;
vab_ratio = vab_mean / vt_mean;
active_bicep_ratio = mean([eab_ratio, mab_ratio, vab_ratio]);
active_bicep_stdev = std([eab_ratio, mab_ratio, vab_ratio], 1);
% Ratio: Active Tricep Contraction Ratio
eat_ratio = eat_mean / eb_mean;
mat_ratio = mat_mean / mb_mean;
vat_ratio = vat_mean / vb_mean;
active_tricep_ratio = mean([eat_ratio, mat_ratio, vat_ratio]);
active_tricep_stdev = std([eat_ratio, mat_ratio, vat_ratio]);
% Plotting Bar Graph
data = [active_bicep_ratio, active_tricep_ratio];
stdev = [active_bicep_stdev, active_tricep_stdev];
labels = categorical({'Biceps', 'Triceps'});
figure;
bar(labels, data);
hold on;   
errorbar(data , stdev, 'k', 'linestyle', 'none')
xlabel('Contracting Muscle');
ylabel('Ratio (RMS amplitude of contracting vs non- contracting muscle)');
hold off;