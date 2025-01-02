%% Given Code: ES53 Peak Finding ECG MatLab Help

function [pi_mean, pi_std, rate,mean_peak_amp,std_peak_amp, peak_interval] = peak_finder(data, time_arr,lower_threshold,upper_threshold)
    DATA = data; %make sure you use your own data file name here
    TIME = time_arr; %this will be your time vector
    Signal = DATA; % this is how we extract the first column from the DATA matrix
    figure(1);
%     tlim2 = 20; % we would like to plot the first 20 seconds, right?
%     xlim2 = length(find(TIME<tlim2)); % and these are the indexes for the elements in the first 20 seconds
    tt = TIME;
    segment = Signal; % this is out new data vector (again, for the first 20 seconds)
    de20 = diff(segment); %and the derivative of this vector
    plot(tt,segment);
    xlabel('Time (s)');
    
    

    % for those of you who are really hard-core MatLab users, here is the
    % clean way of finding the peaks.
    ind = find(((segment(2:end-1)>lower_threshold)&(de20(1:end-1)>0)&(de20(2:end)<0)& segment(2:end-1)<upper_threshold))+1; % the indices of all peaks in the first 20 second segment
    % A fringe case limitation is that this cannot find points when the slope
    % is zero at the peak

    hold on;
    plot(TIME(ind),segment(ind),'r.');

    % Calculating requested values in exercise 3 section 2
    peak_times = tt(ind); % Getting the times for the peaks
    peak_interval = diff(peak_times); % Calculating time between peaks
    pi_mean = mean(peak_interval); % Calculating the mean value of the interval between peaks
    pi_std = std(peak_interval); % Calculating the standard deviation value of the interval between peaks
    rate = 1./(pi_mean./60); % Calculating the rate using the formula f = 1/t
    
    % Calculating requested values in exercise 4 section 2
    mean_peak_amp = mean(Signal(ind)); % Getting the average amplitude of the peaks
    std_peak_amp = std(Signal(ind)); % Getting the standard deviation of the peaks
    
end

