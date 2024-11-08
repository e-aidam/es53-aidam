%% Header
% ES53 Pset 3
% Author: Ethan Aidam
% Date: 9/19/2024

%% Question 1 
% 1a. Plotting Vmem, conducatnces, and gate probabilities at 100 uA/cm2
[t, y] = run_hh_model(8, 100, 0.1);

figure(1); hold on 

% First subplot: Vmem
subplot(3,1,1); 
plot(t, y(:,1));
title('Membrane Potential');
ylabel('Membrane Potential (mV)');
grid on;

% Second subplot: gNA & gK
subplot(3,1,2); hold on
gNa = y(:,2).^3 .* y(:,3) .* 120;
gK = y(:,4).^4 .* 36;
plot(t, gNa);
plot(t, gK);
title('Sodium & Potassium Conductances');
ylabel('Ionic Conductance (mS cm^2)');
legend('gNa','gK')
grid on;
hold off

% Third subplot: m, h, & n probabilities
subplot(3,1,3), hold on
plot(t, y(:,2));
plot(t, y(:,3));
plot(t, y(:,4));
title('m-gate, h-gate, & n-gate Open Probabilities');
xlabel('Time (ms)');
ylabel('Gate Probability');
legend('m-gate','h-gate','n-gate')
grid on;
hold off

hold off

%1b. Plottting Vmem from 0 to 100 uA/cm2

figure(2); hold on
title('Action Potentials at Amplitudes from 0 to 100 uA/cm2');
ylabel('Membrane Potential (mV)');
xlabel('Time (ms)')
grid on;

% Loop starting at 0 uA/cm2 and ending at 100 uA/cm2
for i = 0:100
    [t1, y1] = run_hh_model(8, i, 0.1);
    %  Plot membrane potential
    plot(t1, y1(:,1));
end

hold off

%1c. Plottting Peak Vmem vs. Pulse magnitude from 0 to 100 uA/cm2

figure(3); hold on
title('Maximum Membrane Voltage at Amplitudes from 0 to 100 uA/cm2');
ylabel('Membrane Potential (mV)');
xlabel('Stimulating Pulse Magnitude (uA/cm2)')
grid on;

for i = 0:100
    [t2, y2] = run_hh_model(8, i, 0.1);
    vMem = y2(:,1);
    
    % Find peaks in the membrane potential
    peaks = max(vMem); 
    
    % Plot the peaks
    plot(i, peaks, 'ro'); 
end

hold off

%1d. Plotting barely-suprathreshold and above threshold action potentials

figure(4); hold on
title('Action Potentials at 16 and 100 uA/cm2');
ylabel('Membrane Potential (mV)');
xlabel('Time (ms)')
grid on;

% Plot action potential at 16 uA/cm2
[t3, y3] = run_hh_model(20, 16, 0.1);
plot(t3, y3(:,1));

% Plot action potential at 100 uA/cm2
[t4, y4] = run_hh_model(20, 100, 0.1);
plot(t4, y4(:,1));
legend("16 uA/cm2","100 uA/cm2")
hold off

%% Question 2

% tetany.m - simulates the summation of muscle twitches to reach tetany
% For ES 53, designed by L. Moyer
% Last modified 9/16/22

% Students – please add comments to show that you understand 
% what is going on in each line of this code
 
clear all
close all

dt = 30;             % time period between twitches in ms
frequency = 1/dt;    % twitch frequency
numtwitches = 20;    % number of twitches to initiate
x = [0:0.1:40]; % Time vector from 0 to 40 with periods of 0.1
twamp = zeros(1,2001); % Empty vector for fast twitch amplitudes
twamps = zeros(1,2001); % Empty vetor for slow twitch amplitudes


 
% Generate time delayed twitches and sum
for i= 1:numtwitches;
y(i,:) = gampdf(x,3,1); %approximates a fast twitch response
start = round((i-1)*dt)+1; % calculate the start of the twitch based on time period btwn twitches
twamp(i,start:(start+length(x)-1)) = y(i,:); % Place the twitch into the empty matrix
end
tetf = sum(twamp,1); % sum all twitches to represent twitch response/tetany
 
figure(5) % create a figure to plot twitches
subplot(211) % declare plot as 1st of 2 subplots
plot(tetf,'r') % plot the twitches in the color red
axis([0 500 0 1.1*max(max(tetf))]) % scale the axis according to the max twitch magnitude
xlabel('Time (ms)') 
ylabel('Twitch Force (a.u.)')
legend('Fast Twitch','location','southeast')
 
 
% Now you generate time delayed slow twitches and sum them.
% Write your own code (or modify below) and plot your results in subplot(212)in blue
for j= 1:numtwitches;
y2(j,:) = gampdf(x,3,2); %approximates a slow twitch response
star = round((j-1)*dt)+1;
twamps(j,star:(star+length(x)-1)) = y2(j,:);
end
tets = sum(twamps,1);
  
subplot(212)
plot(tets,'b')
axis([0 500 0 1.1*max(max(tets))])
xlabel('Time (ms)')
ylabel('Twitch Force (a.u.)')
legend('Slow Twitch','location','southeast')

%% Question 3
%3a. Force Velocity Relationship plot by Hill's Equation

% Constants
a = 50; % Newtons
b = 0.1; % m/s
T_max = 150; % Newtons

% Tension vector
T = linspace(0, T_max, 100);

% Hill's equation for velocity as a function of tension
v = b * ((T_max - T) ./ (T + a));

% Plot the force-velocity relationship
figure(6);
hold on
plot(T, v);
xlabel('Force (Tension) (N)');
ylabel('Velocity (m/s)');
title("Hill's Force-Velocity Relationship");
grid on; 

% Plot the force-velocity relationship
figure(6);
plot(T, v.*T, 'b');
hold off

%3b. Plotting the Force Velocity Relationship whil varying a
figure(7); hold on

for a = 5:5:30 % 5 N to 30 N in steps of 5 N
    b = a / T_max; % vary b in accordance to vmax = 1 m/s
    v = b * ((T_max - T) ./ (T + a));
    plot(T,v);
end
xlabel('Force (Tension) (N)');
ylabel('Velocity (m/s)');
title("Hill's Force-Velocity Relationship (a = 5N to 30N)");
grid on
hold off
