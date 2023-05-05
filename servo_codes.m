%servo codes 
%design 6 plan:
%
%
clear all;
clear a s;
global a
 
a = arduino('COM3', 'Mega2560', 'Libraries', 'Servo');
angle=0;  
servo_pin='D4'; 
flex_sensor_pin='A0'; 
%Create a Servo object.
s = servo(a, 'D4', 'MinPulseDuration', 5.44e-04, 'MaxPulseDuration', 2.40e-03);

%led
led='D5'; 
pinMode = configurePin(a,'D5');
configurePin(a,'D5','DigitalOutput')
configurePin(a, 'A0', 'AnalogInput');  
 
%Sensor value
 %**************************************************************
% value_sensor=readVoltage(a, 'A0');
% fprintf('Sensor pin value is %d volts \n',value_sensor);
% configurePin(a,'D2','DigitalOutput')
 

  for i=1:100
     value_sensor=readVoltage(a, 'A0');
     fprintf('Sensor pin value is %d volts \n',value_sensor);
     pause(0.2);
     
 
  end   
 
 
 %give this A0 vaue to the led 
%  writePWMVoltage(a,'D44',value_sensor) 
%  pause(0.1); 

% % % convert the flex sensor value to proportional servo motor angle.
% min_flex_val= 0.1;  % 
% max_flex_val= 5; % 
% flex_value = readVoltage(a, 'A0');
% angle= ((flex_value - min_flex_val)/(max_flex_val-min_flex_val))*180;
% %angle=(y*180); %angle value will be in the range 0 to 180
% fprintf('Angle is %d deg \n',angle);
% %angle=angle/1000; 
% disp(angle); 

%range 0-1 
% min=0; %0 deg 
% max=1; %180 deg 
% writePosition(s, min); %set motor posotion to 0 deg 
% % 
% %state 1 
% writePosition(s, angle);
%   pause(0.5)
% %state 2 
%   writePosition(s, 0.3555);
%   pause(0.5)
% %state 3
%   writePosition(s, 0.8111);
%   pause(0.5)
%   %state 4 
% writePosition(s, 0.99);
%   pause(0.5)
% %writePosition(s, max);
% pause(0.5),
% writePosition(s, min);
% pause(0.5);
% 
% % 
% % clear s 
% 
% %  
% %  for count1=1:5
% %      for angle=0:0.1:1 %from 0 to 180 degrees 
% %          writePosition(s, angle);
% %          pause(0.1);
% %      end 
% %      pause(0.5)
% %      
% %      for angle=1:-0.1:0
% %          writePosition(s, angle)
% %          pause(0.1);
% %      end   
% %  end 
% 
% %script Mathworks video
% % Min_pos=0;  angle= [0 0.3 0.5 0.8 0.99]
% % Max_pos=1;
% % writePosition(s,Min_pos)
% % pause(0.3)
% % writePosition(s,Max_pos)
%  
% 
% %min 0deg ==>0, max- 180==> 1 in matlab 
% %Write and read Servo position
% % for angle = 0:0.2:1
% %     writePosition(s, angle);
% %     current_pos = readPosition(s);
% %     current_pos = current_pos*180;
% %     fprintf('Current motor position is %d degrees\n', current_pos);
% %     pause(2);
% % end
% 
% %move 
% 
% % 
% % position=readPosition(s);
% % disp(position);  
% % position_deg=position*180;
% % fprintf('Right now motor position is %d degrees\n', position_deg);
% 
%  
% %  pause (0.5) ;
% %  writePosition(s, 0.3);
% % pause (0.2);
% %  writePosition(s, 0.6); 
% %   pause (0.5)
% %  writePosition(s, 0.89); 
% %  pause(0.2)
% %  writePosition(s, 1);
% %  clear s
% 
%  
%  
%  
%  