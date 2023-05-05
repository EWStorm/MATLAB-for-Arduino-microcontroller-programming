%4 states, switch- case statements, ReadVoltage function, buzzer, RGB led.   
%BIS; AU Herning, 2022. Design 3. 
%Olga, Ekaterina 
clear all;
global a
a = arduino();
pushbtn = 'A15';
buzzer= 'D11'; 

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
readVoltage(a, 'A15');
fprintf('Voltage at pin A15 is: %d\n',readVoltage(a, 'A15'));
val_s1 = readVoltage(a, 'A15');
if val_s1==0
    pause(0.5);
    readVoltage(a, 'A15');
fprintf('New Voltage at pin A15 is: %d\n',readVoltage(a, 'A15'));
end 
 while 1
     val_s1 = readVoltage(a, 'A15'); %read voltage at pin A15, switch value        
     if val_s1 == 0 %pressed the button    
            count=count+1;  
     end 
      pause(0.5);
     switch count            
        case 1             
     disp('OK');
     writePWMDutyCycle(a,'D8',0);  %%Specify a duty cycle for an LED attached 
% %to digital pin 8 on Arduino hardware. RED- off  
playTone(a, 'D11',174,1);% play tone 1 second  
pause(0.5);
playTone(a, 'D11',174,0); %% sound OFF
pause(0.5);    
         case 2
             disp('delay 2');
             pause(0.2); %delay      
                
        case 3 %Warning 
          disp('Warning');              
    for v=[0:0.1:5 5:-0.1:0] %voltage goes from 0 to 5, and back from 5 to 0
    for i=1:2 %in 2 seconds duration 
writePWMVoltage(a,'D13',v); %GREEN
    end  
    playTone(a, 'D11',396,2)
            pause(0.5);      
    end 
    for v=[0:0.1:5 5:-0.1:0] %voltage goes from 0 to 5, and back from 5 to 0
    for ii=1:1.5 % deaming in 1.5 seconds 
         playTone(a, 'D11',432,1)
           pause(0.5)
writePWMVoltage(a,'D9',v); %BLUE
playTone(a, 'D11',432,0); %sound off 
    end  
    end     
   
                 case 4 %Busy ****************************
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
                 
         case 5  %*******************************  
          disp('Error'); 
   %%buzzer music +Green 
for i=1:length(tune)
    playTone(a,'D11', freqs(strcmp(tune(i), notes)), 0.2*beats(i));
    pause (0.1*beats(i));
 writePWMDutyCycle(a,'D13',0.3); %green 
   pause(0.05);
 writePWMDutyCycle(a,'D13',0) ;
   pause(0.05);  
end  %%Mathworks   
  
              case 6 
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
     
    
