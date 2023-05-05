%push button code for buzzer 
clear;
clc;

%% was D12- btn, D13-led. 
a=arduino();

configurePin(a, 'D12', 'pullup'); %build in pull aup resistor 
   time = 1000;
   while time > 0
      btn_status = readDigitalPin(a, 'D12'); %btn status 
      if btn_status == 0
          
   %Arduino_Warning 
   for i = 1:100
      writeDigitalPin(a, 'D13', 1);
      disp('LED ON');
      pause(0.1);
      writeDigitalPin(a, 'D13', 0);
      disp('LED OFF');
      pause(0.1);
   end
   
      end 
       
     time = time - 1;
    % pause(0.1);
      end 
   
  

   
   
   
   

% ard=arduino(); 
% 
% pushbtn = 'D3';
% led = 'D13';
% 
% ard = arduino();
% 
% configurePin(ard, pushbtn, 'DigitalInput');
% 
% disp('press Ctr-C to exit');    
% 
% while 1
%     btnstate = readDigitalPin(ard,pushbtn);
%     writeDigitalPin(ard,led,~btnstate);
% end

