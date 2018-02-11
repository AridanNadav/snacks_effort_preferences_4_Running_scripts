%% this checks to see if the dynomometer is working, plots 2s worth of data
% check to see if plot is qualitatively like squeeze delivered


% "channel" (0 to 15) selects any of various single-ended or differential
%     measurements.
%     "channel" Measurement
%      0        0-1 (differential)
%      1        2-3 (differential)
%      2        4-5 (differential)
%      3        6-7 (differential)
%      4        1-0 (differential)
%      5        3-2 (differential)
%      6        5-4 (differential)
%      7        7-6 (differential)
%      8          0 (single-ended)
%      9          1 (single-ended)
%     10          2 (single-ended)
%     11          3 (single-ended)
%     12          4 (single-ended)
%     13          5 (single-ended)
%     14          6 (single-ended)
%     15          7 (single-ended)

%% fuction
clear PsychHID;
clear PsychHIDDAQS;

daq=DaqFind;


disp('Daq is HID Device...');
disp(daq);

devices=PsychHID('Devices');
Achan = 8; Arange = 1;
% Calibrate max and min values
CalibMsg = {'Relax....','SQUEEZE as hard as you can!'};
for i=1:2
    counter = 1;
    CurrMsg = CalibMsg{i};
    disp(CurrMsg);
    CalOnTime = GetSecs;
    while (GetSecs - CalOnTime) <= 2
            voltagecalibration(counter) = DaqAIn(daq,Achan,Arange);
            % if you get an error it might be due to wrong daq number ->restart matlab
            counter = counter + 1; 
    end
    if i==2
        [maxval,l] = max(voltagecalibration);
        Calibration(i) = mean(voltagecalibration(l:end));
    else
        Calibration(i) = mean(voltagecalibration);
    end
end
MinCal = Calibration(1);
MaxCal = Calibration(2);
hold on

%{
if max(voltagecalibration) >= .5
    Beeper;
elseif max(voltagecalibration) >= .8
    Beeper(800);
end
%}
plot(voltagecalibration);
disp('number of time points collected...');
disp(length(voltagecalibration));
disp('maximum voltage level...');
disp(maxval);
disp('peak value at time point...');
disp(l)

shg

