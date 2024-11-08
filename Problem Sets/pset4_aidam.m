%% Header
% ES53 Pset 4
% Author: Ethan Aidam
% Date: 9/30/2024
%% Question 1
%3a. Force v. Velocity and Force v. Power

% Constants
a = 50; % Newtons
b = 0.1; % m/s
T_max = 150; % Newtons

% Tension vector
T = linspace(0, T_max, 100);

% Hill's equation for velocity as a function of tension
v = b * ((T_max - T) ./ (T + a));
% Hill's equation for power as a function of velocity and tension
P = v .* T;

% Plot the force-velocity relationship
figure(6);
hold on
plot(T, v);
xlabel('Force (Tension) (N)');
ylabel('Velocity (m/s)');
title("Force Velocity Curve");
grid on; 
hold off


% Plot the force-power relationship
figure(7);
hold on
plot(T, P, 'b');
xlabel('Force (Tension) (N)');
ylabel('Power (N * m/s)');
title("Force Power Curve");
grid on; 
hold off

%1e. 50N weight
velocity = b * ((T_max - 50) ./ (50 + a));
disp(velocity)
