%% Header
% Pset 7
% Author: Ethan Aidam
% Date: 11/12/2024

%% a) Graphing Exponential Decay

% Exponential Decay Function
t = linspace(0, 5); 
y = exp(-t);

figure(1), hold on

% Plotting the function
plot(t, y);

% Plotting asterisk
plot(1, exp(-1), 'r*', 'MarkerSize', 10);

xlabel('t');
ylabel('e^-t');
grid on
hold off

%% b) Graphing Exponential Growth

% Exponential Growth Function
t = linspace(0, 5); 
y = 1 - exp(-t);

figure(2), hold on

% Plotting the function
plot(t, y);

% Plotting asterisk
plot(1, 1 - exp(-1), 'r*', 'MarkerSize', 10);

xlabel('t');
ylabel('1 - e^-t');
grid on
hold off
%% d) Graphing Exponential Decay with Parameters

% Parameters
A_initial = 2;
tau = 3;

% Exponential Decay Function
t = linspace(0, 15); 
A = A_initial * exp(-t/tau);

figure(3), hold on

% Plotting the function
plot(t, A);

xlabel('t');
ylabel('A = A_initial * exp(-t/tau)');
grid on
hold off


