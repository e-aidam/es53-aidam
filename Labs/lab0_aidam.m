%% Header
% lab0_aidam.m
% Ethan Aidam
% 9/5/2024
% First ES53 Lab Assignment

%% Vector and Matrix Declaration and Operation

mat1 = [1 2 3 4 5];
mat2 = [11:15; 21:25];
disp(mat1 + mat2)
disp(mat1 - mat2)
disp(mat1 .* mat2)

%% Conditionals

% Less than or greater than 10
num = input("Enter a number: ");
if num < 10
    disp(0)
elseif num > 10
    disp(1)
else
    disp(2)
end

% Comparing A and B
A = input("Enter A: ");
B = input("Enter B: ");

if A == B
    disp("A is Equal to B")
elseif A > B
    disp("A is greater than B")
else
    disp("A is less than B")
end

%% Loops

% Odd numbers sum
oddSum = 0;
for num = 1:3553
    if mod(num,2) == 1 
        oddSum = oddSum + num;
    end
end

disp(oddSum)

% Even sumbers sum
evenSum = 0;
m = 0;
while evenSum <= 3553
    evenSum = evenSum + m;
    m = m + 2;
end

disp(evenSum)

 
%% Searching/Indexing

% 100x100 matrix search
a = 100*rand(100);
b = zeros(100);

for i = 1:100
    for j = 1:100
        if a(i,j) < 53 && a(i,j) > 33
        b(i,j) = a(i,j);
        end
    end
end

disp(b)

% Indexing
c = 10 * rand(1,100);
c = c .* c;
indices = find(c > 50);
e = c(indices);
disp(e)
disp(size(e))

%% Functions

% Using greaterThan function
xs = 1:100;
ys = 10 * rand(1,100);
[indAboveFive, aboveFive] = greaterThan(xs, ys, 5);
disp(aboveFive)

neg_ys = ys * -1;
[indUnderFive, underFive] = greaterThan(xs,neg_ys, -5);
underFive = -1 * underFive;
disp(underFive)
% lessThan function
function [newXs, newYs] = lessThan(xs, ys, threshold)
    lessThanInd = find(ys < threshold);
    newXs = xs(lessThanInd);
    newYs = ys(lessThanInd);
end

[indUnderFifty, underFifty] = lessThan(xs,ys, 50);
disp(underFifty)

%% Using Built-In Functions and Documentation

% Plotting analytic envelope of chirp
t = 0:1/4000:3-1/4000;
q = chirp(t-2,4,1/2,6,'quadratic',100,'convex').*exp(-4*(t-1).^2);
plot(t,q)
[up,lo] = envelope(q);
hold on
plot(t, up, 'r', 'LineWidth', 4); 
plot(t, lo, 'b', 'LineWidth', 2);
legend('Signal','up','lo')
hold off

%% Snipping Data

% Collecting inteded data
triRMS = load('SnippingDataExample.mat');

bn = 2; %block number
chn = 2; %channel number
triFrom = triRMS.datastart(chn,bn);
triTo = triRMS.dataend(chn,bn);
triExtract = triRMS.data(triFrom:triTo);
triStartIndex = 0 *triRMS.samplerate(200);
triStopIndex = 10 * triRMS.samplerate(200);
triSnip = triExtract(triStartIndex:triStopIndex);
dt = 1/triRMS.samplerate(1);
triTime = (triStartIndex:triStopIndex)*dt;

% Plotting data
plot(triTime,triSnip)
xlabel('Time (s)')
ylabel('Force (V)')
title('RMS Tricep Data')
