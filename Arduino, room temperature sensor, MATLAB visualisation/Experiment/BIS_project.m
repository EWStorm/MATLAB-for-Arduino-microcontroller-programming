%BIS, UX, project. 
% read series of analog voltages from the arduino and store them in a Matlab
% variable. 
%Components: HW: Arduino mega 2650, TMP36- temeperatur sensor, jump wires, 
% 1 sensor, led-2.  

clear all;
clear a s;
global a 
a = arduino('COM3', 'Mega2560', 'Libraries', 'Servo');
%a = arduino('COM3', 'Mega2560', 'Libraries', 'Pololu/LSM303');

red_led='D9'; 
blue_led='D10';
green_led='D11';

 limit1=20;
 limit2=25; 
limit3=30; 
limit4=15; 




% Temp. sensor 
t_sensor= 'A0'; 
 value_sensor=readVoltage(a, 'A0');
 fprintf('Sensor pin value is %d volts \n',value_sensor);
 
 %% take 500 temp. measuremetns 
 value_sensor=zeros(500,1); %matrix 500 rows, 1 column 
 t=seconds(value_sensor); %pre-allocation of time variable, array of "seconds". 
 
 t0=datetime('now'); % initial time 
 for i=1:500
     value_sensor(i)=readVoltage(a, 'A0');
     t(i)=datetime('now')-t0; % array of "times", which is a difference from the array and initial value
 end 
 
  %%
 %convert to Celcius (data sheet formular), and to Kalven, FAHRENHEIT 
 TempC=(value_sensor-0.5)*100;
 disp(TempC);

 %TempF
 TempF=TempC*9/5+32;
 disp(TempF);
 
 %% sampling frequency 
 mean(diff(t)); %avarage time (sec) difference between measurements.   
 f=1/seconds(mean(diff(t))); %samples per second 
 disp(f);
 
 %% do extra staff with plot name and so on. 
 plot(t, TempC);
 hold on
 plot(t, TempF); 
 %% save as matlab file 
 save('Temperature.mat','TempC','TempF', 't');
 save('Temp.text','TempC','TempF', 't');
 %%
 
red_led='D9'; 
blue_led='D10';
green_led='D11';

 limit1=20;
 limit2=25; 
limit3=30; 
 limit4=15; 

TempC=10;

while true 
if TempC <= limit1
    writeDigitalPin(a,'D10',1) %blue blink 
    pause( 0.3);
    writeDigitalPin(a,'D10',0)
    pause(0.3);
writeDigitalPin(a,'D11',0)
writeDigitalPin(a,'D9',0)

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
pause(0.3);
writeDigitalPin(a,'D11',0); 
pause(0.3)

%writeDigitalPin(a,'D10',0)
%writeDigitalPin(a,'D9',0)

elseif TempC>limit3
    writeDigitalPin(a,'D9',1); %red on 
    writeDigitalPin(a,'D10',0)
    writeDigitalPin(a,'D11',0)
end 

TempC=TempC+1;
disp(TempC); 

 end 





 
 
 
 
 