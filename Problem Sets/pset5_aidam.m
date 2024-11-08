%% Header
% ES53 Pset 5
% Author: Ethan Aidam
% Date: 10/12/2024

%% Question 3 

% Plotting PV loop
p = load("PVloop.mat");

volume_initial = p.PVloop(1,:);
pressure_initial = p.PVloop(2,:);

volume_final = [volume_initial, volume_initial(1)];
pressure_final = [pressure_initial, pressure_initial(1)];


figure(1), hold on
plot(volume_final,pressure_final,"LineWidth",2);
ylabel("Pressure (mmHg)");
xlabel("Volume (mL)");
title("Pressure-Volume Loop");
xlim([0 150])
ylim([0 150])

hold off

% Calculating Stroke Work from Stroke Volume and Mean Arterial Pressure

% Stroke Volume (mL) 
sv = max(volume_initial) - min(volume_initial); % 80 mL

% Mean Arterial Pressure (mmHG)
sys_pressure = max(pressure_initial);
dias_pressure = 87.785; % From P-V Loop graph
map = (2/3) * dias_pressure + (1/3) * sys_pressure; % 105.19 mmHG
 

% Converting from mL to cubic meters
sv_meters = sv * 1e-6; % .00008 m^3 

% Converting from mmHG to Pascals
map_pascals = map * 133.322; % 1,4024 Pa

% Stroke Work (Joules)
sw = sv_meters * map_pascals; % 1.219 Joules

% Calculating Stroke Work from area of P-V Loop

% Close loop
volume_closed = [volume_initial, volume_initial(1)];
pressure_closed = [pressure_initial, pressure_initial(1)];

% Convert to cubic meters and Pascals
volume_closed = volume_closed * 1e-6; 
pressure_closed = pressure_closed * 133.332;

% Check if integral is negative or positive
if trapz(volume_closed, pressure_closed) < 0
    volume_closed = flip(volume_closed);
    pressure_closed = flip(pressure_closed);
end

% Calculating area by trapezoidal integration
stroke_work_int = trapz(volume_closed, pressure_closed); % 1.3006 Joules