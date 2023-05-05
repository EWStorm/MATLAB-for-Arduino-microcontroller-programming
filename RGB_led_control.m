%RGB led control, PWM.  color intensity 
%BIS; AU Herning, 2022. Design 2. 
clear all;
global a
a = arduino();

pushbtn = 'A15';
RGB1_RED = 'D8';
RGB3_BLUE='D9'; 
RGB4_GREEN='D13'; 

count=0;
pin_value_save=0;

%     playTone(a,'D11',100,1); 
%     pause(0.1);
%     playTone(a,'D11', 100,0);
   
    
   %changing colors BLUE
%     for v=[0:0.1:5 5:-0.1:0] %voltage goes from 0 to 5, and back from 5 to 0
%     for i=1:2
% writePWMVoltage(a,'D9',v);
%     end  
%     end 
    
%//State 3 %playTone(a,pin,frequency,duration);
%f=[262, 220, 240, 220, 390, 300, 220, 260, 290, 260, 392, 349, 440];
%duration of note
%d=[1, 1, 2, 0.5, 1, 1, 1, 1.5, 1, 1, 1, 2, 1];
% for i=1:13
%    playTone(a,'D11',f(i),d(i));
%     writePWMDutyCycle(a,'D8',0.33);
%pause(0.1);
%writePWMDutyCycle(a,'D8',0);

% end
    
    
     
writePWMDutyCycle(a,'D8',0.33); %%Specify a 0.33 duty cycle for an LED attached 
%to digital pin 8,9,13 on Arduino hardware.
writePWMDutyCycle(a,'D8',0); %OFF
 pause(0.2);
writePWMDutyCycle(a,'D9',0.3)
pause(0.2);
writePWMDutyCycle(a,'D9',0)
pause(0.2);
writePWMDutyCycle(a,'D13',0.2)
pause(0.2);
    

 
  