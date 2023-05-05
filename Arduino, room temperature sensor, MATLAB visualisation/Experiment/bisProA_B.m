%bis project, A) B) parts integrated
% Kalvin, celsius, fahrenheit.

clear all; 
global a 
a = arduino('COM3', 'Mega2560', 'Libraries', 'Servo');

% Temp. sensor 
t_sensor= 'A0'; 
push_btn='D4'; 
buzzer='D13'; 
%led 
red_led='D9'; 
blue_led='D10';
green_led='D11';
limit1=20;
limit2=25; 
limit3=30; 
limit4=15; 

 %%
 value_sensor=readVoltage(a, 'A0');
 btn_status = readDigitalPin(a,'A15');
 fprintf('Sensor pin value is %d volts \n',value_sensor);

 
TempC = (value_sensor- 0.4)*100;
TempF = 9/5*TempC + 32;
TempK=TempC+273.15;
fprintf('Temperature Reading:\n  %.1f °C\n  %.1f °F\n   %.1f K\n',  TempC,TempF, TempK); 
 
%% Record and plot 10 seconds of temperature data
ii = 0;
TempF = zeros(1e4,1);
TempK= zeros(1e4,1);
t = zeros(1e4,1);

tic
while toc < 0
    ii = ii + 1;
    % Read current voltage value
    v = readVoltage(a,'A0');
    % Calculate temperature from voltage (based on data sheet)
    TempC = (v - 0.5)*100;
    TempK(ii)=TempC+273.15;
    TempF(ii) = 9/5*TempC + 32;
    % Get time since starting
    t(ii) = toc;
end 

%% Acquire and display live data
figure
h=animatedline('Color', 'm','LineWidth',3); % F
h1= animatedline('Color', 'b', 'LineWidth',3); % Celsius 
h2=animatedline('Color', 'g', 'LineWidth',3); % Kelvin 

ax = gca;
ax.YGrid = 'on';
ax.YLim = [-15 350];
legend( {'Fahrenheit', 'Celsius', 'Kalvin'}); 

startTime = datetime('now');
%t=seconds(value_sensor); %pre-allocation of time variable, array of "seconds". 
tic 
while toc<30 %record data for 20 seconds 
    % Read current voltage value
    value_sensor = readVoltage(a,'A0');
    % Calculate temperature from voltage (based on data sheet)
    TempC = (value_sensor - 0.4)*100;
    TempF = 9/5*TempC + 32;    
    TempK=TempC+273.15;
    % Get current time
    t =  datetime('now') - startTime; 
    % Add points to animation
    addpoints(h,datenum(t),TempF)
    addpoints(h1,datenum(t),TempC)
    addpoints(h2,datenum(t),TempK)
    % Update axes
    ax.XLim = datenum([t-seconds(15) t]);
    datetick('x','keeplimits')
    drawnow

%leds & buzzer code 
if TempC <= limit1
    writeDigitalPin(a,'D10',1) %blue blink
    pause(0.1)
    writeDigitalPin(a,'D10',0) %blue blink 
writeDigitalPin(a,'D11',0)
writeDigitalPin(a,'D9',0)
playTone(a, 'D13',174,1);% play tone 1 second  
pause(0.1);
playTone(a, 'D13',174,0)

elseif TempC< limit4 
    writeDigitalPin(a,'D10',1); %blue on 
writeDigitalPin(a,'D11',0)
writeDigitalPin(a,'D9',0)

elseif (TempC>limit1) && (TempC< limit2)
writeDigitalPin(a,'D11',1); % green on 
writeDigitalPin(a,'D10',0)
writeDigitalPin(a,'D9',0)

elseif (TempC>limit2) && (TempC<limit3)
writeDigitalPin(a,'D11',1); %green blink 
pause(0.1);
writeDigitalPin(a,'D11',0); 

%writeDigitalPin(a,'D10',0)
%writeDigitalPin(a,'D9',0)

elseif TempC>limit3
    writeDigitalPin(a,'D9',1); %red on 
    writeDigitalPin(a,'D10',0)
    writeDigitalPin(a,'D11',0)
    playTone(a, 'D13',174,1);% play tone 1 second  
pause(0.1);
playTone(a, 'D13',174,0)

end 
 

end 


%% Plot the recorded data

[timeLogs,tempLogs] = getpoints(h);
[timeLogs,tempLogs1] = getpoints(h1);
[timeLogs,tempLogs2] = getpoints(h2);
timeSecs = (timeLogs-timeLogs(1))*24*3600;
% figure
% plot(timeSecs,tempLogs) % plot fahrenheit.
% xlabel('Elapsed time (sec)')
% ylabel('Temperature (Fahrenheit)')

figure
plot(timeSecs,tempLogs1) % plot Celsius 
xlabel('Elapsed time (sec)')
ylabel('Temperature (Celsius)')


%% Save results to a file
T = table(timeSecs',tempLogs', tempLogs1',tempLogs2','VariableNames',{'Time_sec','Temp_F','Temp_C','Temp_K'});
filename = 'Temperature_Data.xlsx';
% Write table to file 
writetable(T,filename)
% Print confirmation to command line
fprintf('Results table with %g temperature measurements saved to file %s\n',...
    length(timeSecs),filename);
%%
fig = uifigure('Position',[300 400 760 360]);
uit = uitable(fig);
uit.Position = [20 20 720 320];
    uit.Data = T;
    uit.ColumnSortable = true;
    uit.ColumnEditable = [false false true];
    uit.Position(3) = 290;
    uit.RowName = 'numbered';
    uit.ColumnWidth = {'auto',75,'auto','auto','auto',100};
    uit.BackgroundColor = [1 1 .9; .9 .95 1;1 .5 .5];

    uit.DisplayDataChangedFcn = @updatePlot;
%% Get All Table Properties
%To see all the properties of the table, use the get command.

%get(uit);

%%clear all 
 



