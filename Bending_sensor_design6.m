%flex sensor as a push btn, Design 6.   
%BIS; AU Herning, 2022. 
% Ekaterina, Verner, Olga, Jesper.  
%Components: RGB led, Buzzer,resistors...
%jump wires, servo motor, flex sensor.  

clear all;
clear a s;
global a 
a = arduino('COM3', 'Mega2560', 'Libraries', 'Servo');

pushbtn = 'A13'; %'A15'
buzzer= 'D11'; 

% %motor pins , Vibrating motors 
% motor1='D2';  %pepperoni 
% motor2='D6';  %broccoli

%Servo motor
Servopin='D4';

%RGB pins 
RGB1_RED = 'D8';
RGB3_BLUE='D9'; 
RGB4_GREEN='D13'; 

% bending sensor 
b_sensor= 'A0'; 

%changable variables 
count=0; 
time=0; 
angle=0; 

%%Buzzer variables, State 2
 tune1='efgec';
 beats1= [1 1 1 1 1 ]; 
 notes1= {'c', 'e','f','g' ' '}; 
 freqs1=[262 294 330 349 392 0]; 

 %Create a Servo object.
s = servo(a, 'D4', 'MinPulseDuration', 5.44e-04, 'MaxPulseDuration', 2.40e-03);
position=readPosition(s);
disp(position);  
position_deg=position*180;
disp(position_deg); 
fprintf('Right now motor position is %d degrees\n', position_deg);

% set motor posotion to 0 deg  
min_pos=0; %0 deg 
max_pos=1; %180 deg 
writePosition(s, min_pos); 

%Sensor value
 %**************************************************************
 value_sensor=readVoltage(a, 'A0');
 fprintf('Sensor pin value is %d volts \n',value_sensor);
 
 

%configurePin(a, 'A15', 'pullup'); %build in pull up resistor 
readVoltage(a, 'A13');
fprintf('Voltage at pin A13 is: %d\n',readVoltage(a, 'A13'));

 while 1
     val_s1 = readVoltage(a, 'A13'); %read voltage at pin A13, switch value        
     if val_s1 == 0 % equal to pressed button    
            count=count+1;  
     end 
      pause(0.5);
       disp(count);
       
     switch count            
        case 1             %*****************************************
     disp('OK');
     disp('count');
     %servo move, state 1.  
     writePosition(s, 0.1888); %moves the pointer to the state 1
     pause(0.2); 
     writePWMDutyCycle(a,'D8',1);  %red RGB is on
    
playTone(a, 'D11',174,1);% play tone 1 second  
pause(0.5);
playTone(a, 'D11',174,0); %% sound OFF
pause(0.5);    

% motor1, 3v, pepperoni
  writeDigitalPin(a, 'D2', 1);
  pause(0.5);
  writeDigitalPin(a, 'D2', 0);

% red RGb off
writePWMDutyCycle(a,'D8',0);  
           
        case 2 %Warning %***********************************************
          disp('Warning');  
          %servo move
          writePosition(s, 0.3555);
          pause(0.2);
    writePWMDutyCycle(a,'D9',1); %BLUE on 
    playTone(a, 'D11',396,2) %buzzer on
            pause(0.5);   
            playTone(a, 'D11',396,0); %buzzer off 
    % motor 1+ motor 2 
%     writePWMVoltage(a, 'D2', 3); %pepperoni
%     writePMWVoltage(a,'D6',3); %broccoli
% pause(0.3);
% writePWMVoltage(a, 'D2', 0); %peperroni
% writePMWVoltage(a,'D6',0); %broccoli
  writeDigitalPin(a, 'D6', 1);
  writeDigitalPin(a, 'D2',1);
   pause(0.5);
   writeDigitalPin(a, 'D6', 0);
  writeDigitalPin(a, 'D2',0);
 writePWMDutyCycle(a,'D9',0); %BLUE off
   
                 case 3 %Busy ****************************
              disp('Busy');
              %servo move 
              writePosition(s, 0.8111); %moves pointer to 3
              pause(0.2); 
%Buzzer music 
for ii=1:length(tune1)
    playTone(a,'D11', freqs1(strcmp(tune1(ii), notes1)), 0.2*beats1(ii))
    pause (0.1*beats1(ii))
   writePWMDutyCycle(a,'D9',1); %BLUE
   pause(0.05);
    writePWMDutyCycle(a,'D9',0); %BLUE off
   pause(0.05);  
end            
      %motor 2, broccoli
    writeDigitalPin(a, 'D6', 1);
    pause(0.4);
  writeDigitalPin(a, 'D6', 0);

         case 4 %*******************************  
          disp('Error'); %Margharita
          %servo move 
          writePosition(s, 0.999);
          pause(0.2); 
   writePWMDutyCycle(a,'D13',1); %green on  
   playTone(a, 'D11',500,1);% play tone 1 second  
pause(0.5);
 writePWMDutyCycle(a,'D13',0); %green off
playTone(a, 'D11',174,0); %% sound OFF
pause(0.5);
%    %motor 1 & motor 2 
%   writePWMVoltage(a, 'D2', 3);
%   writePWMVoltage(a, 'D4', 3);
% pause(0.3);
% writePWMVoltage(a, 'D2', 0);
% writePWMVoltage(a, 'D4', 0);
   
              case 5 
               
            count=0;
            disp('Restart*********************************************');
 %servo move 
 writePosition(s, min_pos);
         
            playTone(a, 'D11',639,1);
            pause(0.5);
            playTone(a, 'D11',174,0);
                 
  
     end 
 end 
