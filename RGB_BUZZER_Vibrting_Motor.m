%vibrating motor, Design 4.   
%Components: RGB led, Buzzer, push btn,resistors...
%jump wires, vibrating motor. 

clear all;
global a
a = arduino();
pushbtn = 'A15'; %'A13'
buzzer= 'D11'; 

%motor pins 
motor='D4'; %PMW
motor2='D2';  

%RGB pins 
RGB1_RED = 'D8';
RGB3_BLUE='D9'; 
RGB4_GREEN='D13'; 

%changable variables 
count=0; 
time=0; 

%%Buzzer variables, State 4
configurePin(a, 'D11', 'Tone');
tune='eefggfedccdee dd';
beats= [1 1 1 1 1 1 1 1 1 1 1 1 1 0.5 0.5 2]; 
notes= {'c', 'd', 'e','f','g' ' '}; 
freqs=[262 294 330 349 392 0];

%%Buzzer variables, State 2
 tune1='efgec';
 beats1= [1 1 1 1 1 ]; 
 notes1= {'c', 'e','f','g' ' '}; 
 freqs1=[262 294 330 349 392 0]; 

%configurePin(a, 'A15', 'pullup'); %build in pull up resistor 

readVoltage(a, 'A13');
fprintf('Voltage at pin A13 is: %d\n',readVoltage(a, 'A13'));

 while 1
     val_s1 = readVoltage(a, 'A13'); %read voltage at pin A15, switch value        
     if val_s1 == 0 %pressed the button    
            count=count+1;  
     end 
      pause(0.5);
       disp(count);
       
     switch count            
        case 1             %*****************************************
     disp('OK');
     disp('count');
     writePWMDutyCycle(a,'D8',1);  %red RGB on
    
playTone(a, 'D11',174,1);% play tone 1 second  
pause(0.5);
playTone(a, 'D11',174,0); %% sound OFF
pause(0.5);    

% motor, 3v
writePWMVoltage(a, 'D2', 3);
pause(0.3);
writePWMVoltage(a, 'D2', 0);
% red RGb off
writePWMDutyCycle(a,'D8',0);  
  
                
        case 2 %Warning %***********************************************
          disp('Warning');              
    writePWMDutyCycle(a,'D9',1); %BLUE on 
    playTone(a, 'D11',396,2)
            pause(0.5);   
            playTone(a, 'D11',396,0);
    % motor 
    writePWMVoltage(a, 'D2', 3);
pause(0.3);
writePWMVoltage(a, 'D2', 0);
     writePWMDutyCycle(a,'D9',0); %BLUE off
   
                 case 3 %Busy ****************************
              disp('Busy');
%Buzzer music 
for ii=1:length(tune1)
    playTone(a,'D11', freqs1(strcmp(tune1(ii), notes1)), 0.2*beats1(ii))
    pause (0.1*beats1(ii))
   writePWMDutyCycle(a,'D9',1); %BLUE
   pause(0.05);
    writePWMDutyCycle(a,'D9',0); %BLUE off
   pause(0.05);  
end            
      %motor 
      writePWMVoltage(a, 'D2', 3);
pause(0.3);
writePWMVoltage(a, 'D2', 0);

         case 4 %*******************************  
          disp('Error'); 
   writePWMDutyCycle(a,'D13',1); %green on  
   playTone(a, 'D11',500,1);% play tone 1 second  
pause(0.5);
 writePWMDutyCycle(a,'D13',0); %green off
playTone(a, 'D11',174,0); %% sound OFF
pause(0.5);
   %motor 1 & motor 2 
  writePWMVoltage(a, 'D2', 3);
  writePWMVoltage(a, 'D4', 3);
pause(0.3);
writePWMVoltage(a, 'D2', 0);
writePWMVoltage(a, 'D4', 0);
   
              case 5 
               
              count=0;
            disp('Restart*********************************************');
 
            %mix all 3 colors at different intensity 
%             writePWMVoltage(a,'D13',1); %1 volt
%             writePWMVoltage(a,'D8',2); %2 volts 
%             writePWMVoltage(a,'D9',3); %3 volts 
            playTone(a, 'D11',639,1);
            pause(0.5);
            playTone(a, 'D11',174,0);
                 
  
     end 
 end 
     
    
% motor
%%

%motor, HIGH, LOW
%   writeDigitalPin(a, 'D2', 1);
%    pause(0.4);
%    writeDigitalPin(a, 'D2', 0);
%    pause(0.4);
% %%%%%
%   
% writePWMVoltage(a, 'D4', 3);
% pause(0.3);
% writePWMVoltage(a, 'D4', 0);
% %%
%  writeDigitalPin(a, 'D4', 1);
%    pause(0.4);
%    writeDigitalPin(a, 'D4', 0);
%    pause(0.4);

