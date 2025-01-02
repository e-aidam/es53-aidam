%% Header
% Fifth ES53 Lab: Fig. 1, Table 1, Table 2
% Author: Ethan Aidam
% Date: 10/31/2024

%% Figure 1

% Loading data
e = load('Lab5ex2_ethan.mat');
b = load('Lab5ex2_bianca.mat');
m = load('Lab5ex2_3_MARIELA.mat');

dt = 1/e.samplerate(1);

% Snipping Ethan Flow data
efrom = e.datastart(1,3) + e.com(1,3) + 39*e.samplerate(1);
eto = efrom + 40*e.samplerate(1);
esnip = e.data(efrom:eto);

% Snipping Ethan Volume data
efrom1 = e.datastart(2,3) + e.com(1,3) + 39*e.samplerate(1);
eto = efrom1 + 40*e.samplerate(1);
esnip1 = e.data(efrom1:eto);

% Snipping Bianca Flow data
bfrom = b.datastart(1,4) + b.com(1,3) + 36*b.samplerate(1);
bto = bfrom + 40*b.samplerate(1);
bsnip = b.data(bfrom:bto);

% Snipping Bianca Volume data
bfrom1 = b.datastart(2,4) + b.com(1,3) + 36*b.samplerate(1);
bto1 = bfrom1 + 40*b.samplerate(1);
bsnip1 = b.data(bfrom1:bto1);

% Snipping Mariela Flow data
mfrom = m.datastart(1,4) + m.com(1,3) + 17*m.samplerate(1);
mto = mfrom + 40*m.samplerate(1);
msnip = m.data(mfrom:mto);

% Snipping Mariela Volume data
mfrom1 = m.datastart(2,4) + m.com(1,3) + 17*m.samplerate(1);
mto1 = mfrom1 + 40*m.samplerate(1);
msnip1 = m.data(mfrom1:mto1);


% Creating figure to plot data
figure(1), hold on

t = (0:length(esnip)-1) * dt ;

% Flow subplot
subplot(3,2,1); hold on;
plot(t,esnip);
xlabel('Time (s)');
ylabel('Flow (L/s)');
grid on;
hold off;

% Volume Subplot
subplot(3,2,2); hold on;
plot(t,esnip1); % Lab Chart Trace
plot(t,cumtrapz(t,esnip)); % Integrated Trace
xlabel('Time (s)');
ylabel('Volume (L)');
legend('Lab Chart Trace', 'Integrated Trace')
grid on;
hold off;

% Flow subplot
subplot(3,2,3); hold on;
plot(t,bsnip);
xlabel('Time (s)');
ylabel('Flow (L/s)');
grid on;
hold off;

% Volume Subplot
subplot(3,2,4); hold on;
plot(t,bsnip1); % Lab Chart Trace
plot(t,cumtrapz(t,bsnip)); % Integrated Trace
xlabel('Time (s)');
ylabel('Volume (L)');
legend('Lab Chart Trace', 'Integrated Trace')
grid on;
hold off;

% Flow subplot
subplot(3,2,5); hold on;
plot(t,msnip);
xlabel('Time (s)');
ylabel('Flow (L/s)');
grid on;
hold off;

% Volume Subplot
subplot(3,2,6); hold on;
plot(t,msnip1); % Lab Chart Trace
plot(t,cumtrapz(t,msnip)); % Integrated Trace
xlabel('Time (s)');
ylabel('Volume (L)');
legend('Lab Chart Trace', 'Integrated Trace')
grid on;
hold off;

% Add row titles
text(-1.57, 3.35, 'Ethan', 'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'center');
text(-1.57, 1.9, 'Bianca', 'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'center');
text(-1.57, 0.5, 'Mariela', 'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'center');




%% Table 1 
% Row 1: Respiratory Rate

close all
% Loading data
e = load('Lab5ex2_ethan.mat');

dt = 1/e.samplerate(1);

% Snipping 1 minute of Tidal Breathing Data
efrom = e.datastart(2,3);
eto = efrom + 60*e.samplerate(1);
esnip = e.data(efrom:eto);

% Finding peaks
[epeaks, elocs] = findpeaks(esnip, 'MinPeakHeight',0.1,'MinPeakDistance',1.1 * e.samplerate(1));
% Plotting Peaks to check
t = (0:length(esnip)-1) * dt ;
figure(1), hold on
plot(t,esnip)
plot(t(elocs), epeaks, 'gs','MarkerFaceColor','g');
hold off

% Calculating Respiratory Rate During Tidal Breathing
rr_e = length(epeaks); % 15 Breaths per minute

% Table 1: Row 3 Tidal Volume
% Snipping 1 Tidal Breath
efrom = e.datastart(1,3) + 22 * e.samplerate(1);
eto = efrom + 5 * e.samplerate(1);
esnip = e.data(efrom:eto);

% Plotting to check
t = (0:length(esnip)-1) * dt;
figure(2), hold on
plot(t, esnip)
hold off

% Extracting only the positive portion of esnip
positive_esnip = esnip;
positive_esnip(positive_esnip < 0) = 0; % Set all negative values to zero

% Calculating the integral of the positive portion
tidal_volume_e = trapz(t, positive_esnip); % 1.1848 L

% Table 1: Row 2 Expired Minute Volume
emv_e = tidal_volume_e * rr_e; % 17.7714 L

% Table 1: Row 4 Inspiratory Reserve Volume
% Snipping Ethan data
efrom = e.datastart(2,3) + 60 * e.samplerate(1);
eto = efrom + 12*e.samplerate(1);
esnip = e.data(efrom:eto);

[epeaks, elocs] = findpeaks(esnip,'NPeaks',2,'MinPeakHeight',0.4, 'MinPeakDistance',3* e.samplerate(1));

% Plotting Peaks to check
t = (0:length(esnip)-1) * dt ;
figure(3), hold on

plot(t,esnip)
plot(t(elocs), epeaks, 'gs','MarkerFaceColor','g');

hold off

% Finding Difference btwn Inhalation Peak and Tidal Peak
irv_e = epeaks(1,1) - epeaks (1,2); % 2.0197 L

% Table 1: Row 5 Inspiratory Capacity
ic_e  = tidal_volume_e + irv_e; % 3.2045 L

% Table 1: Row 6 Expiraotory Reserve Volume

% Snipping Ethan data
efrom = e.datastart(2,3) + 60 * e.samplerate(1);
eto = efrom + 20*e.samplerate(1);
esnip = e.data(efrom:eto);

% Inverting data to find minima as peaks
esnip_inv = -esnip;

% Finding minima by locating peaks in the inverted data
[epeaks, elocs] = findpeaks(esnip_inv, 'NPeaks', 2, 'MinPeakDistance', 5 * e.samplerate(1),'MinPeakHeight',-0.1);


% Reverting back to actual minima values
emins = -epeaks;

% Plotting Minima to check
t = (0:length(esnip)-1) * dt;
figure(4), hold on

plot(t, esnip)
plot(t(elocs), emins, 'rs', 'MarkerFaceColor', 'r');

hold off

% Calculating Expiratory Reserve Volume
erv_e = -(emins(1,1) - emins(1,2)); % 1.0661 L

% Table 1 Row 7: Expiratory Capacity
ec_e = erv_e + tidal_volume_e; % 2.2508 L

% Table 1 Row 8: Predicted Vital Capacity (From Table)
pvc_e = 5.568;

% Table 1 Row 9: Vital Capacity
vc_e = irv_e + erv_e + tidal_volume_e; % 4.2706 L

% Table 1 Row 10: Residual Volume
rv_e = pvc_e * 0.25; % 1.392 L

% Table 1 Row 11: Total Lung Capacity
tlc_e = vc_e + rv_e; % 5.6626 L

% Table 1 Row 12: Funcitonal Residual Capacity
frc_e = erv_e + rv_e; % 2.4581 L

%% Table 2: Row 1 Peak Insipratory Flows 
% Finding peaks
% Loading data
e = load('Lab5ex2_ethan.mat');

dt = 1/e.samplerate(1);

% Snipping Ethan data
efrom = e.datastart(1,4);
eto = efrom + 130*e.samplerate(1);
esnip = e.data(efrom:eto);


[epeaks, elocs] = findpeaks(esnip,'NPeaks',3,'MinPeakHeight',2, 'MinPeakDistance',30* e.samplerate(1));

% Plotting Peaks to check
t = (0:length(esnip)-1) * dt ;
figure(1), hold on

plot(t,esnip)
plot(t(elocs), epeaks, 'gs','MarkerFaceColor','g');

hold off

% Peak Inspiratory Flows
epeaks; % 2.4912, 2.6492, 2.0608 (L/min)

% Snipping Ethan data
efrom = e.datastart(1,4);
eto = efrom + 130*e.samplerate(1);
esnip = e.data(efrom:eto);


% Inverting data to find minima as peaks
esnip_inv = -esnip;

% Finding minima by locating peaks in the inverted data
[epeaks, elocs] = findpeaks(esnip_inv, 'NPeaks', 3, 'MinPeakDistance', 30 * e.samplerate(1), 'MinPeakHeight',1.5);


% Reverting back to actual minima values
emins = -epeaks;

% Plotting Minima to check
t = (0:length(esnip)-1) * dt;
figure(1), hold on

plot(t, esnip)
plot(t(elocs), emins, 'rs', 'MarkerFaceColor', 'r');

hold off

% Peak Expiratory Flows
emins; % -2.6309, -2.4455, -1.6974 (L/min)


%% Table 1 Bianca
% Row 1: Respiratory Rate

close all
% Loading data
e = load('Lab5ex2_bianca.mat');

dt = 1/e.samplerate(1);

% Snipping 1 minute of Tidal Breathing Data
efrom = e.datastart(2,3);
eto = efrom + 60*e.samplerate(1);
esnip = e.data(efrom:eto);

% Finding peaks
[epeaks, elocs] = findpeaks(esnip, 'MinPeakHeight',0.1,'MinPeakDistance',1.1 * e.samplerate(1));
% Plotting Peaks to check
t = (0:length(esnip)-1) * dt ;
figure(1), hold on
plot(t,esnip)
plot(t(elocs), epeaks, 'gs','MarkerFaceColor','g');
hold off

% Calculating Respiratory Rate During Tidal Breathing
rr_e = length(epeaks); % 19 Breaths per minute

% Table 1: Row 3 Tidal Volume

% Snipping 1 Tidal Breath
efrom = e.datastart(1,3) + 28 * e.samplerate(1);
eto = efrom + 4 * e.samplerate(1);
esnip = e.data(efrom:eto);

% Plotting to check
t = (0:length(esnip)-1) * dt;
figure(2), hold on
plot(t, esnip)
hold off

% Extracting only the positive portion of esnip
positive_esnip = esnip;
positive_esnip(positive_esnip < 0) = 0; % Set all negative values to zero

% Calculating the integral of the positive portion
tidal_volume_e = trapz(t, positive_esnip); 

% Table 1: Row 2 Expired Minute Volume
emv_e = tidal_volume_e * rr_e; 

% Table 1: Row 4 Inspiratory Reserve Volume
% Snipping Ethan data
efrom = e.datastart(2,3) + 60 * e.samplerate(1);
eto = efrom + 20*e.samplerate(1);
esnip = e.data(efrom:eto);

[epeaks, elocs] = findpeaks(esnip,'NPeaks',2,'MinPeakHeight',0.4, 'MinPeakDistance',6* e.samplerate(1));

% Plotting Peaks to check
t = (0:length(esnip)-1) * dt ;
figure(3), hold on

plot(t,esnip)
plot(t(elocs), epeaks, 'gs','MarkerFaceColor','g');

hold off

% Finding Difference btwn Inhalation Peak and Tidal Peak
irv_e = epeaks(1,1) - epeaks (1,2); 

% Table 1: Row 5 Inspiratory Capacity
ic_e  = tidal_volume_e + irv_e; 

% Table 1: Row 6 Expiraotory Reserve Volume

% Snipping Ethan data
efrom = e.datastart(2,3) + 65 * e.samplerate(1);
eto = efrom + 20*e.samplerate(1);
esnip = e.data(efrom:eto);

% Inverting data to find minima as peaks
esnip_inv = -esnip;

% Finding minima by locating peaks in the inverted data
[epeaks, elocs] = findpeaks(esnip_inv, 'NPeaks', 2, 'MinPeakDistance', 3 * e.samplerate(1),'MinPeakHeight',-0.1);


% Reverting back to actual minima values
emins = -epeaks;

% Plotting Minima to check
t = (0:length(esnip)-1) * dt;
figure(4), hold on

plot(t, esnip)
plot(t(elocs), emins, 'rs', 'MarkerFaceColor', 'r');

hold off

% Calculating Expiratory Reserve Volume
erv_e = -(emins(1,1) - emins(1,2)); %

% Table 1 Row 7: Expiratory Capacity
ec_e = erv_e + tidal_volume_e;

% Table 1 Row 8: Predicted Vital Capacity (From Table)
pvc_e = 3.861;

% Table 1 Row 9: Vital Capacity
vc_e = irv_e + erv_e + tidal_volume_e;

% Table 1 Row 10: Residual Volume
rv_e = pvc_e * 0.25; 

% Table 1 Row 11: Total Lung Capacity
tlc_e = vc_e + rv_e;

% Table 1 Row 12: Funcitonal Residual Capacity
frc_e = erv_e + rv_e; 
%% Calculating Mean +/- S.D.
values = [0.36
0.59
0.77

];
val_mean = mean(values)
val_stdev = std(values)

