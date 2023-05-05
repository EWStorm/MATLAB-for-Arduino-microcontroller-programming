%BIS project, temperature (WEBINAR)
%BIS, UX, project. 
% read series of analog voltages from the arduino and store them in a Matlab
% variable. 
%Components: HW: Arduino mega 2650, TMP36- temeperatur sensor, jump wires, 
% 1 sensor, led-2.  

clear all;
clear a ;
global a 
a = arduino('COM3', 'Mega2560', 'Libraries', 'Servo');
%a = arduino('COM3', 'Mega2560', 'Libraries', 'Pololu/LSM303');

% Temp. sensor 
t_sensor= 'A0'; 
push_btn='D12'; 
red_led='D9'; 
blue_led='D10';
green_led='D11';

 value_sensor=readVoltage(a, 'A0');
 fprintf('Sensor pin value is %d volts \n',value_sensor);
 
 %% live temperature plotting (webinar, Mathworks). 
 %record and plot for 10 sec 
 ii=0; 
 count=200e7;
 TempF=zeros(1e4,1);
t=zeros(1e4,1);
tic

while toc<10 
    ii=ii+1;
    %read current Voltage value 
    value_sensor=readVoltage(a, 'A0');
    %calculate temp.
    TempC=(value_sensor-0.5)*100; 
    TempF(ii)=9/5*TempC+32; 
    %get time since starting 
    t(ii)=toc;
 
end 

%%% Compute acquisition rate
timeBetweenDataPoints=diff(t);
AvarageTimePerDataPoint=mean(timeBetweenDataPoints); 
dataRateHz=1/AvarageTimePerDataPoint; 
fprintf(' 1 data point per %.3f seconds (%.f Hz) \n',AvarageTimePerDataPoint,dataRateHz); 
 
%% Post-process and plot the data. First remove any excess zeros on the
% logging variables.
TempF = TempF(1:ii);
t = t(1:ii);
% Plot temperature versus time
figure
plot(t,TempF,'-o')
xlabel('Elapsed time (sec)')
ylabel('Temperature (\circF)')
title('Ten Seconds of Temperature Data')
set(gca,'xlim',[t(1) t(ii)])

%
%% Acquire and display live data

figure
h=animatedline('Color', 'r');
h1= animatedline('Color', 'b');
%h2=
ax = gca;
ax.YGrid = 'on';
ax.YLim = [-5 35];

stop=false; 
startTime = datetime('now');

tic 
while toc<20
    % Read current voltage value
    value_sensor = readVoltage(a,'A0');
    % Calculate temperature from voltage (based on data sheet)
    TempC = (value_sensor - 0.5)*100;
    TempF = 9/5*TempC + 32;    
    % Get current time
    t =  datetime('now') - startTime;
    % Add points to animation
    addpoints(h,datenum(t),TempF)
    % Update axes
    ax.XLim = datenum([t-seconds(15) t]);
    datetick('x','keeplimits')
    drawnow
    
   % Check stop condition
    stop = readDigitalPin(a,'D12'); %push btn

end

% Plot the recorded data
 [timeLogs,tempLogs] = getpoints(h);
 timeSecs = (timeLogs-timeLogs(1))*24*3600;
% figure
% plot(timeSecs,tempLogs)
% xlabel('Elapsed time (sec)')
% ylabel('Temperature (\circF)')
% hold on 
% plot

%%
% Smooth out readings with moving average filter

% smoothedTemp = smooth(tempLogs,25);
% tempMax = smoothedTemp + 2*9/5;
% tempMin = smoothedTemp - 2*9/5;
% 
% figure
% plot(timeSecs,tempLogs, timeSecs,tempMax,'r--',timeSecs,tempMin,'r--')
% xlabel('Elapsed time (sec)')
% ylabel('Temperature (\circF)')
% hold on 


%%Plot the original and the smoothed temperature signal, and illustrate the uncertainty.

%plot(timeSecs,smoothedTemp,'r')

% Save results to a file

T = table(timeSecs',tempLogs','VariableNames',{'Time_sec','Temp_F'});
filename = 'Temperature_Data.xlsx';
% Write table to file 
writetable(T,filename)
% Print confirmation to command line
fprintf('Results table with %g temperature measurements saved to file %s\n',...
    length(timeSecs),filename)


 
 