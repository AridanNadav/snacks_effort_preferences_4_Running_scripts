% MRI_Grip_Calibration
runNUMs=num2str(runNUM);

TIMEstamp
fidtraining = fopen([outputPath '/' subjectID '_training_run' runNUMs '_' timestamp  '.txt'],'a');
fprintf(fidtraining,'Image_num\t Effort_level\t Goal\t time2Goal\t V_vector\n');


% times
runNETLength=243;
trialDur = 1.5;      %
baseline_fixation_dur = 2; %
afterrunfixation = 6;

ActiveRange = wHeight*0.7; 
% Creating a variable containing the screen coordinates
BarW = ActiveRange/3; 
% Set up effort bar
PenWidth = 3;    


% image start point The vector elements are [Left, Top, Right, Bottom]
downRect=  [ wWidth/2-(wHeight*0.25*1.3333333)/2 wHeight*.75 wWidth/2+(wHeight*0.25*1.3333333)/2 wHeight ];

stackH_train= wHeight*0.25;
% Placing the effort bar on the screen:
fromW = centerX - BarW; 
toW = centerX + BarW;
% bottomBound = centerY + (ActiveRange/2.25); %/2+ (ActiveRange/10);
topBound = wHeight*0.05; %/2- (ActiveRange/4);



CalibDur = 2;
Calibration_start = GetSecs;

% Show Instructions
Screen('PutImage',Window,instrct_calibration);
Screen(Window,'Flip');
%KbQueueFlush;
%KbQueueStart;
WaitSecs(0.5);
wait4key
% ###
daq=DaqDeviceIndex;
devices=PsychHID('Devices');
Achan = 8; Arange = 1;

CalibDone = 0;
while ~CalibDone
    
    vcal=cell(4,1);
    
    % first relax baseline
    OK_relax = 0;
    while ~OK_relax
        
        ctr1 = 1;
        
        Screen('PutImage',Window,instrct_dont_squeez);
        Screen(Window,'Flip');
        %    CurrMsg = CalibMsg{1};
        %   DrawFormattedText(Window,CurrMsg,'center','center',CalibColor{1});
        
        
        CalOnTime = GetSecs; % Get the current cloack's seconds.
        
        while (GetSecs - CalOnTime) <= CalibDur
            
            % Creates a vector containing the voltage at each sumple -
            % According to a prefixed sumpling rate.
            measure1(ctr1) = DaqAIn(daq,Achan,Arange);
            ctr1 = ctr1 + 1;
            vcal{1}=measure1;
        end
        % To make sure the subject doesnt squeeze during the relax phase.
        
        
        % if max(measure1)>=1.65
        if max(measure1)>=0.2
            Screen('PutImage',Window,instrunt_recalib);
            Screen(Window,'Flip');
            WaitSecs(2)
        else OK_relax=1;
        end
    end
    
    
    for i=2:4
        
        Screen('PutImage',Window,instrct_squeez);
        Screen(Window,'Flip');
        % CurrMsg = CalibMsg{2};
        %  DrawFormattedText(Window,CurrMsg,'center','center',CalibColor{2});
        
        ctr = 1;
        
        CalOnTime = GetSecs; % Get the current cloack's seconds.
        measure=[];
        while (GetSecs - CalOnTime) <= CalibDur
            
            % Creates a vector containing the voltage at each sumple -
            % According to a prefixed sumpling rate.
            measure(ctr) = DaqAIn(daq,Achan,Arange);
            ctr = ctr + 1;
            vcal{i}=measure;
        end
        
        CalOnTime = GetSecs; % Get the current cloack's seconds.
        Screen('PutImage',Window,instrct_dont_squeez);
        Screen(Window,'Flip');
        while (GetSecs - CalOnTime) <= CalibDur
        end
        
    end
    
    Screen('Flip',Window);
    maxs=  [max(vcal{2}),max(vcal{3}),max(vcal{4})];
    MaxCal = mean(maxs);
    MinCal = max(vcal{1});
    %save to file
    max1=char(num2str(vcal{2}));
    max2=char(num2str(vcal{3}));
    max3=char(num2str(vcal{4}));
    
    max_vec = [max1,'  ',max2,'  ',max3];
    
    % fix num2str(vcal{2:end});
    
    % SelfPower is the max grip of the subject minus the noise.
    SelfPower=(MaxCal-MinCal);
    % ScaleFactor divides the dynamic part of the screen to subject's grip
    % range units.
    ScaleFactor =ActiveRange/SelfPower;
    
    fid4 = fopen([outputPath '/' subjectID '_grip_cal' timestamp '.txt'],'a'); %#################
    fprintf(fid4,'Min\t Max_Vec\t max\t Self_Power\n'); %#################
    fprintf(fid4,'%d\t %s\t %d\t %d\n', MinCal, max_vec, MaxCal, SelfPower); %#################
    fclose(fid4); %#################
    
    CalibOutMsg = ['Max grip: ' num2str(SelfPower)];
    %     DrawFormattedText(Window,CalibOutMsg,'center','center',TextColor);
    %     Screen('Flip',Window);
    %     %    FlushEvents; %#####
    %     %    KbQueueFlush;
    %     %    KbQueueStart;
    %     % Waits for keyboard input.
    %     wait4key
    
    DrawFormattedText(Window,CalibOutMsg,'center','center',TextColor);
    Screen('Flip',Window);
    
    KbQueueCreate()
    KbQueueStart();%%start listening
    KbQueueFlush();%%removes all keyboard presses
    [secs, keyCode, deltaSecs] = KbWait();
    Response = KbName(keyCode);
    %Response = Response(1);
    while     ~ismember(Response,['y','Y','n','N'])
        KbQueueCreate()
        KbQueueStart();%%start listening
        KbQueueFlush();%%removes all keyboard presses
        [secs, keyCode, deltaSecs] = KbWait();
        Response = KbName(keyCode);
        
    end
    if ismember(Response,['y','Y'])
        CalibDone = 1;
    end
    
    Screen('Flip',Window);
    
    Calibration_time = (GetSecs - Calibration_start);
    
end
Screen('Flip',Window);
save ([pwd '/Output/' subjectID '_calib_parameters'])


