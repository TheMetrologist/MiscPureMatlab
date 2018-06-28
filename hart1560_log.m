%function hart1560_log()

%% hart1560_log.m Notes
%   Authored by Michael Braine, Physical Science Technician, NIST, Gaithersburg, MD
%   PHONE: 301 975 8746
%   EMAIL: michael.braine@nist.gov
%   log and plot temperature data from Hart 1560
%
%% Inputs
%   - filename for saving log data
%
%% Outputs
%   - log data file
%
%% References
%   - none
%
%% Change Log from v1.01 to v1.02
%////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%   ver 1.02    - fixed error with outputting wrong estimated completion time
%
%////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

%% Disconnect instrument if improper end previously
if exist('hart1560_obj')
    hart1560_connect
end

%% Set up directory paths
user = getenv('USERNAME');
current_directory = pwd;                                                        %get current path of fringefinder directory
addpath([current_directory '\fringefinder\strang_functions'])                   %add strang_functions directory to search path for support functions

%% Set up channels to scan
scan_CH = [       %define channels to scan
    1
    2
    4
    5
    6
    7
    8
    9
    10
    ]';
pts_per_hr = 160; %number of points per hour for 10 channels
graph_time = 1; %length of time to graph into the past, hours
graph_pts = round(graph_time*pts_per_hr); %length of time in points to graph into past

%% Set up Legend names
Ch1 = 'Control 1';
Ch2 = 'Control 2';
%Ch3 = ' ';
Ch4 = 'A Left 1';
Ch5 = 'A Left 2';
Ch6 = 'B Back 1';
Ch7 = 'B Back 2';
Ch8 = 'C Right 1';
Ch9 = 'C Right 2';
Ch10 = 'D Front 1';

%% Logging parameters
t_limit = input('Length of time to record, hrs: ')*60*60;
t_delay = input('Delay to start, hrs: ')*60*60;
datafilename = input('Name of data file: ', 's');
graph_yn = input('Graph data? (y/n): ', 's');

if t_delay ~= 0
    fprintf('\nWaiting for delay to end...\n')
    pause(t_delay)
end

%% Connect to instrument
hart1560_connect

%% Record data
fprintf('\nEstimated end of data logging is %s\nRecording data...\n', datestr( now() + t_limit/60/60/24 ))
i = 1; t = 0;
tic
CH.Temp_raw=[];
CH.Temp=[];
CH.time=clock;
while t < t_limit
    CH_temp = hart1560_measure(hart1560_obj, scan_CH);
    CH(1).Temp_raw(i,1) = CH_temp(1).Temp_raw;
    CH(1).Temp(i,1) = CH_temp(1).Temp;
    CH(1).time(i,:) = CH_temp(1).time;
    CH(2).Temp_raw(i,1) = CH_temp(2).Temp_raw;
    CH(2).Temp(i,1) = CH_temp(2).Temp;
    CH(2).time(i,:) = CH_temp(2).time;
    CH(4).Temp_raw(i,1) = CH_temp(4).Temp_raw;
    CH(4).Temp(i,1) = CH_temp(4).Temp;
    CH(4).time(i,:) = CH_temp(4).time;
    CH(5).Temp_raw(i,1) = CH_temp(5).Temp_raw;
    CH(5).Temp(i,1) = CH_temp(5).Temp;
    CH(5).time(i,:) = CH_temp(5).time;
    CH(6).Temp_raw(i,1) = CH_temp(6).Temp_raw;
    CH(6).Temp(i,1) = CH_temp(6).Temp;
    CH(6).time(i,:) = CH_temp(6).time;
    CH(7).Temp_raw(i,1) = CH_temp(7).Temp_raw;
    CH(7).Temp(i,1) = CH_temp(7).Temp;
    CH(7).time(i,:) = CH_temp(7).time;
    CH(8).Temp_raw(i,1) = CH_temp(8).Temp_raw;
    CH(8).Temp(i,1) = CH_temp(8).Temp;
    CH(8).time(i,:) = CH_temp(8).time;
    CH(9).Temp_raw(i,1) = CH_temp(9).Temp_raw;
    CH(9).Temp(i,1) = CH_temp(9).Temp;
    CH(9).time(i,:) = CH_temp(9).time;
    CH(10).Temp_raw(i,1) = CH_temp(10).Temp_raw;
    CH(10).Temp(i,1) = CH_temp(10).Temp;
    CH(10).time(i,:) = CH_temp(10).time;
    if strcmp(graph_yn,'y')
        f_hand = 3;
        if length(CH(1).Temp_raw) <= graph_pts
            figure(f_hand)
                hold on
                plot(1:length(CH(1).Temp), CH(1).Temp, 'r-o', 'LineWidth', 2, 'MarkerFaceColor', 'w')
            figure(f_hand)
                hold on
                plot(1:length(CH(1).Temp), CH(2).Temp, 'g-o', 'LineWidth', 2, 'MarkerFaceColor', 'w')
            figure(f_hand)
                hold on
                plot(1:length(CH(1).Temp), CH(4).Temp, 'b-o', 'LineWidth', 2, 'MarkerFaceColor', 'w')
            figure(f_hand)
                hold on
                plot(1:length(CH(1).Temp), CH(5).Temp, 'c-o', 'LineWidth', 2, 'MarkerFaceColor', 'w')
            figure(f_hand)
                hold on
                plot(1:length(CH(1).Temp), CH(6).Temp, 'm-o', 'LineWidth', 2, 'MarkerFaceColor', 'w')
            figure(f_hand)
                hold on
                plot(1:length(CH(1).Temp), CH(7).Temp, 'k-o', 'LineWidth', 2, 'MarkerFaceColor', 'w')
            figure(f_hand)
                hold on
                plot(1:length(CH(1).Temp), CH(8).Temp, 'r-*', 'LineWidth', 2)
            figure(f_hand)
                hold on
                plot(1:length(CH(1).Temp), CH(9).Temp, 'g-*', 'LineWidth', 2)
            figure(f_hand)
                hold on
                plot(1:length(CH(1).Temp), CH(10).Temp, 'b-*', 'LineWidth', 2)

            mintemp = min([CH(1).Temp; CH(2).Temp; CH(4).Temp; ...
                CH(5).Temp; CH(6).Temp; CH(7).Temp; CH(8).Temp; CH(9).Temp; CH(10).Temp]);
            maxtemp = max([CH(1).Temp; CH(2).Temp; CH(4).Temp; ...
                CH(5).Temp; CH(6).Temp; CH(7).Temp; CH(8).Temp; CH(9).Temp; CH(10).Temp]);

            figure(f_hand)
                legend(Ch1, Ch2, Ch4, Ch5, Ch6, Ch7, Ch8, Ch9, Ch10, 'Location', 'EastOutside')
                axis([1 length(CH(1).Temp)+0.001 (mintemp-0.05) (maxtemp+0.05)])
                set(gca, 'XTick', linspace(0,length(CH(1).Temp),15), 'XTickLabel', round(linspace(t/60,0,15)*10)/10)
                xlabel('Time in past, minutes')
                ylabel('Temperature, deg. C')

            pause(0.001)
        else
            cla(f_hand)
            figure(f_hand)
                hold on
                plot(1:graph_pts, CH(1).Temp(end-graph_pts+1:end), 'r-o', 'LineWidth', 2, 'MarkerFaceColor', 'w')
            figure(f_hand)
                hold on
                plot(1:graph_pts, CH(2).Temp(end-graph_pts+1:end), 'g-o', 'LineWidth', 2, 'MarkerFaceColor', 'w')
            figure(f_hand)
                hold on
                plot(1:graph_pts, CH(4).Temp(end-graph_pts+1:end), 'b-o', 'LineWidth', 2, 'MarkerFaceColor', 'w')
            figure(f_hand)
                hold on
                plot(1:graph_pts, CH(5).Temp(end-graph_pts+1:end), 'c-o', 'LineWidth', 2, 'MarkerFaceColor', 'w')
            figure(f_hand)
                hold on
                plot(1:graph_pts, CH(6).Temp(end-graph_pts+1:end), 'm-o', 'LineWidth', 2, 'MarkerFaceColor', 'w')
            figure(f_hand)
                hold on
                plot(1:graph_pts, CH(7).Temp(end-graph_pts+1:end), 'k-o', 'LineWidth', 2, 'MarkerFaceColor', 'w')
            figure(f_hand)
                hold on
                plot(1:graph_pts, CH(8).Temp(end-graph_pts+1:end), 'r-*', 'LineWidth', 2)
            figure(f_hand)
                hold on
                plot(1:graph_pts, CH(9).Temp(end-graph_pts+1:end), 'g-*', 'LineWidth', 2)
            figure(f_hand)
                hold on
                plot(1:graph_pts, CH(10).Temp(end-graph_pts+1:end), 'b-*', 'LineWidth', 2)

            mintemp = min([CH(1).Temp(end-graph_pts+1:end);...
                CH(2).Temp(end-graph_pts+1:end); CH(4).Temp(end-graph_pts+1:end); ...
                CH(5).Temp(end-graph_pts+1:end); CH(6).Temp(end-graph_pts+1:end); ...
                CH(7).Temp(end-graph_pts+1:end); CH(8).Temp(end-graph_pts+1:end); ...
                CH(9).Temp(end-graph_pts+1:end); CH(10).Temp(end-graph_pts+1:end)]);
            maxtemp = max([CH(1).Temp(end-graph_pts+1:end);...
                CH(2).Temp(end-graph_pts+1:end); CH(4).Temp(end-graph_pts+1:end); ...
                CH(5).Temp(end-graph_pts+1:end); CH(6).Temp(end-graph_pts+1:end); ...
                CH(7).Temp(end-graph_pts+1:end); CH(8).Temp(end-graph_pts+1:end); ...
                CH(9).Temp(end-graph_pts+1:end); CH(10).Temp(end-graph_pts+1:end)]);

            figure(f_hand)
                legend(Ch1, Ch2, Ch4, Ch5, Ch6, Ch7, Ch8, Ch9, Ch10, 'Location', 'EastOutside')
                set(gca, 'XTick', linspace(0,graph_pts,15), 'XTickLabel', round(linspace(graph_time*60,0,15)*10)/10)
                axis([1 graph_pts (mintemp-0.05) (maxtemp+0.05)])
                xlabel('Time in past, minutes')
                ylabel('Temperature, deg. C')

            pause(0.001)
        end
        hold off
    end
    t = toc;
    i = i+1;
end
fprintf('\nData logging has ended.\n')

%% Disconnect from instrument
hart1560_connect
fprintf('Hart 1560 disconnected.\n')

%% Save data
save(datafilename, 'CH')
fprintf('Data saved to file: %s.mat in directory %s\n', datafilename, current_directory)
