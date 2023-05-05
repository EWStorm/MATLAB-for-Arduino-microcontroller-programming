%4 states, IR sensor, leds, buzzer. 
clear all;
global a
a = arduino();

pushbtn = 'D6'; %IR sensor 

red_led='D9'; 
blue_led='D10';
green_led='D11';

%buzzer 
buzzer='D13'; 
count=0;


%%Buzzer variables 
configurePin(a, 'D13', 'Tone');
tune='eefggfedccdee dd';
beats= [1 1 1 1 1 1 1 1 1 1 1 1 1 0.5 0.5 2]; 
notes= {'c', 'd', 'e','f','g' ' '}; 
freqs=[262 294 330 349 392 0];

%configurePin(a, 'A15', 'pullup'); %build in pull up resistor 
%readVoltage(a, 'A15');
IR_status = readDigitalPin(a, 'D6');
fprintf('IR status:  %d \n',readDigitalPin(a, 'D6'));
%fprintf('status of a sensor pin is: %d\n',readVoltage(a, 'D6'));
prev_state=1; 

 while 1
     %btn_status = readVoltage(a, 'A15'); %read voltage at pin A15
     
%     if btn_status == 0 %==button pressed 
%        pin_value_save = btn_status;  
%        count = count+1;  
%     end 

current_state=readDigitalPin(a, 'D6');

if prev_state~= current_state %if there is change in input
%elseif current_state == 0 % If input only changes from HIGH to LOW
    count=count+1; 
end 
     
%disp(count);
disp(count);

pause(0.5); 
     
    switch count 
        case 1
            disp('State: OK');
      writeDigitalPin(a, 'D11', 1); %led is ON
      playTone(a, 'D13',440,1);% play tone 1 second     
           pause(0.2);
      writeDigitalPin(a, 'D11', 0); %led is ON     
      playTone(a, 'D13',440,0); %% sound OFF
           pause(0.2);
             
        case 2
            disp('State: Busy');
   writeDigitalPin(a, 'D10', 1);
   playTone(a, 'D13',340,1); %plays 1 sec
   pause(0.5);
   writeDigitalPin(a, 'D10', 0);
   playTone(a, 'D13',340,0);
   pause(0.5);
   
        case 3
            disp('State: Warning');
      writeDigitalPin(a, 'D9', 1); %led ON
      pause(0.5);
      
      %//State 5/ buzzer: playTone(a,pin,frequency,duration);
ff=[262, 220, 240, 220, 390, 300, 220, 260, 290, 260, 392, 349, 440];
%duration of note
dd=[1, 1, 2, 0.5, 1, 1, 1, 1.5, 1, 1, 1, 2, 1];
 for i=1:13
    playTone(a,'D13',ff(i),dd(i));
 end
    writeDigitalPin(a, 'D9', 0); %led OFF
      pause(0.5);      
      
        case 4
            disp('State: Error');
%     writeDigitalPin(a, 'D13', 1);
%    pause(0.1);
%    writeDigitalPin(a, 'D13', 0);
%    pause(0.1);  
   
   %%buzzer music 
for i=1:length(tune)
    playTone(a,'D13', freqs(strcmp(tune(i), notes)), 0.2*beats(i))
    pause (0.2*beats(i))
   writeDigitalPin(a, 'D9', 1);
   pause(0.05);
   writeDigitalPin(a, 'D9', 0);
   pause(0.05);  
end  %%Matworks 
   %%
  
        case 5 %all changable variables set to 0
            if count>4
           count=0;
          prev_state=1;
            disp('restart');
            playTone(a, 'D13',1340,2);
writeDigitalPin(a, 'D9',1)
writeDigitalPin(a, 'D10',1)
writeDigitalPin(a, 'D11',1)


            end 
           end 
    end  
    
  