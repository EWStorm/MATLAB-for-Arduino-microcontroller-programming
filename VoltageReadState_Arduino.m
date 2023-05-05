%4 states, switch-case statements, ReadVoltage function 
%BIS; AU Herning, 2022. Design 1. 
%
clear all;
global a
a = arduino();

pushbtn = 'A15';
led = 'D13';
count=0;
pin_value_save=0;

%configurePin(a, 'A15', 'pullup'); %build in pull up resistor 
%readDigitalPin(a, 'D12');

readVoltage(a, 'A15');
fprintf('Voltage at pin A15 is: %d\n',readVoltage(a, 'A15'));

 while 1
     btn_status = readVoltage(a, 'A15'); %read voltage at pin A15
    if btn_status == 0 %==button pressed 
       pin_value_save = btn_status;  
       count = count+1;  
    end 
pause(0.3); 
disp(count);
% if btn_status ~= pin_value_save % When the value of the pin changes
%         pin_value_save = btn_status; 
%         count = count + 1; % start the counter 
%            
%     end 
%    pause(0.5)
     
    switch count 
        case 1
            disp('State: OK');
      writeDigitalPin(a, 'D13', 1);
      pause(0.2);
      writeDigitalPin(a, 'D13', 0);
      pause(0.2);
                    
        case 2
            disp('State: Busy');
   writeDigitalPin(a, 'D13', 1);
   pause(0.4);
   writeDigitalPin(a, 'D13', 0);
   pause(0.4);
   
        case 3
            disp('State: Warning');
      writeDigitalPin(a, 'D13', 0);
      pause(0.5);
      writeDigitalPin(a, 'D13', 1);
      pause(0.5);      
         
        case 4
            disp('State: Error');
    writeDigitalPin(a, 'D13', 1);
   pause(0.1);
   writeDigitalPin(a, 'D13', 0);
   pause(0.1);
      
        case 5 %put all changable variables to original value =0; 
            count=0;
            pin_value_save=0;
            disp('restart');
           end 
    end  
    
  