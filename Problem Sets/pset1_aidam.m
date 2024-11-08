%% Header
% First ES53 Pset
% Author: Ethan Aidam
% Date: 9/16/2024

%% Question 4
% a-e

% Time vector from 0 to 8 ms
t = linspace(0,8,201);

% Gate probabilities
nInitial = 0.32;
nFinal = 0.95;
tauN= 1.2;
nProb = nFinal - (nFinal - nInitial) .* exp(-t/tauN);

mInitial = 0.05;
mFinal = 0.99;
tauM= 0.15;
mProb = mFinal - (mFinal - mInitial) .* exp(-t/tauM);

hInitial = 0.6;
hFinal = 0;
tauH = 1;
hProb = hFinal - (hFinal - hInitial) .* exp(-t/tauH);

% Conductance
naMax = 120; 
kMax = 36;
gNa = naMax * (mProb.^3) .* hProb;  
gK = kMax * (nProb.^4);

% Plotting conductance
figure(1), hold on
plot(t, gK, "r", 'LineWidth',2)
plot(t, gNa, "y", 'LineWidth',2)
legend("gK","gNa")
xlabel("Time (ms)")
ylabel("Ionic Conductance (mS cm^-2)")
title("Sodium and Potassium Conductance over Time")
hold off

% Nernst Potentials
eNa = 50;
eK = -77;
eL = -54.4; % leak potential
gL = 0.3; % leak conductanve

% Vmem by chord conductance equations
Vmem = (gNa*eNa + gK*eK + gL * eL) ./ (gNa + gK + gL);

% Plotting Vmem
figure(2), hold on
plot(t, Vmem, "bl", 'LineWidth',2)
legend("Vmem")
xlabel("Time (ms)")
ylabel("Membrane Potential (mV)")
title("Membrane Potential over Time")
hold off


%% Question 5

% Time vector
t = -30:.001:30;

% Figure 5a, sinc
figure(3), hold on, grid on
y = sinc(t);
plot(t,y,'k')
xlabel("Time (s)")
ylabel("Sinc(t) (a.u)")
title("Sinc Function (Fig. 5a)")
hold off

% Figure 5b, derivative of sinc
figure(4), hold on, grid on
dydt = gradient(y,t);

plot(t,dydt,'k')
xlabel("Time (s)")
ylabel("Sinc(t)/dt (a.u)")
title("Derivative of Sinc Function (Fig. 5b)")
hold off

% Figure 5c, derivative, positive green, negative red, zero-crossing yellow squares
figure(5), hold on, grid on

% Identifying positive and negative areas
dydtPositive = dydt;
dydtNegative = dydt;

dydtPositive(sign(dydtPositive) <= 0) = NaN;
dydtNegative(sign(dydtNegative) >= 0) = NaN;

%Identifying zero crossings
zeroCrossings = find(diff(sign(dydt)) ~= 0);

plot(t,dydtPositive,'g')
plot(t,dydtNegative,'r')
plot(t(zeroCrossings),dydt(zeroCrossings),'ys', 'MarkerFaceColor', 'y')

xlabel("Time (s)")
ylabel("Sin(t)/dt (a.u)")
title("Colored Derivative of Sinc Function (Fig. 5c)")
hold off

% Figure5d, original sinc function colored
figure(6), hold on, grid on

% Identifying positive and negative slopes
yPositive = y;
yNegative = y;

yPositive(sign(dydt) <= 0) = NaN;
yNegative(sign(dydt) >= 0) = NaN;

% Identifying zero crossings for derivative of sinc
zeroCrossings = find(diff(sign(dydt)) ~= 0);

plot(t,yPositive,'g')
plot(t,yNegative,'r')
plot(t(zeroCrossings),y(zeroCrossings),'ys', 'MarkerFaceColor', 'y')
xlabel("Time (s)")
ylabel("Sinc(t) (a.u)")
title("Colored Sinc Function (Fig. 5d)")
hold off

