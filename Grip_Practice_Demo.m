%function []=Grip_Practice_Demo()
% inputs :  ScaleFactor,Number_of_runs,daq,Achan,Arange,MinCal,Practice_Images,downRect,stackH
% The function uses data from the 'daq', and show how hard does the subject
% is pressing by moving the image up and down.
% The function sets to each image a difficulty level - So that each image
% requires a different amount of power for moving it up toward the difficulty bar.


% Creating a variable containing the screen coordinates
BarW = ActiveRange/3;
% Set up effort bar
PenWidth = 3;

% unitH = ActiveRange/4;

% image start point The vector elements are [Left, Top, Right, Bottom]
downRect=  [ wWidth/2-(wHeight*0.25*1.3333333)/2 wHeight*.75 wWidth/2+(wHeight*0.25*1.3333333)/2 wHeight ];
stackH_train= wHeight*0.25;


% Placing the effort bar on the screen:
fromW = centerX - BarW;
toW = centerX + BarW;
% bottomBound = centerY + (ActiveRange/2.25); %/2+ (ActiveRange/10);
topBound = wHeight*0.05; %/2- (ActiveRange/4);


CalibDone = 0;
while ~CalibDone
    
    % The trial will begin only when the subject clicks the keyboard.
    demo_effort_levels = randperm(3);
    for tal=1:2
        % Loop of 5 repetes, for demo only.
        for l=1:3
            
            if l==1 && tal==1
                Screen('PutImage',Window,instrct_practice_demo);
                Screen(Window,'Flip');
                
                KbQueueCreate;
                KbQueueFlush;
                KbQueueStart;
                WaitSecs(0.5);
                wait4key
                
                
                
                
                iti_OnTime=GetSecs;
                while (GetSecs - iti_OnTime) <=  iti_length
                    v = DaqAIn(daq,Achan,Arange);
                    if  v >=0.2 && (GetSecs - iti_OnTime)>0.7
                        %if  v >=1.65
                        
                        Screen('PutImage',Window,instrunt_dontsqeez);
                        Screen(Window,'Flip');
                        WaitSecs(0.7);
                        iti_OnTime=GetSecs;
                        
                    else
                        CenterText(Window,'+', white,0,0);
                        
                    end
                end
                
                Screen('Flip',Window);
                EffortOnTime = GetSecs;
                % Setting the primary and changing lacation of the fractal on the screen.
                newdownRect = downRect;
                StartYVal = newdownRect(2); % Top edge .
                cnt=1;
                Val_vec=newdownRect(2);
                
                
                while newdownRect(2) > topBound
                    
                    % Converts measurement (V) to pixel using the grip calibration.
                    %v = 0.5; %for no dinamo
                    v = DaqAIn(daq,Achan,Arange);
                    vN = v - MinCal;
                    vN = vN*ScaleFactor*effort_req(tal,demo_effort_levels(l))  ;
                    NewYVal = (StartYVal - vN);
                    
                    %V_measure(counter) = v; %#################
                    %counter = counter + 1; %#################
                    
                    % Locates the fractal on the screen according to the measurement.
                    % If the measurment is higher the the yellow bar:
                    if NewYVal <= 0
                        newdownRect(2) = 0;
                        newdownRect(4) = newdownRect(2)+stackH_train;
                        % If the measurment is lower the the yellow bar:
                    elseif NewYVal > StartYVal
                        newdownRect = downRect;
                    else newdownRect(2) = NewYVal;
                        newdownRect(4) = newdownRect(2)+stackH_train;
                    end
                    
                    Screen('PutImage',Window, demo_Images{RAnd_demoFRACT(l)}, newdownRect); %RAndFRACT(l)
                    
                    
                    if newdownRect(2) <=topBound;
                        Screen('DrawLine',Window,[0 255 0],fromW,topBound,toW,topBound,PenWidth*2)
                        %goal_vec(counter) = 1; %#################
                    elseif newdownRect(2) > topBound && min(Val_vec)>topBound
                        % Placing the effort bar
                        Screen('DrawLine',Window,[255 0 0],fromW,topBound,toW,topBound,PenWidth*2)
                        %goal_vec(counter) = 0; %#################
                    else
                        Screen('DrawLine',Window,[ 0 255 0],fromW,topBound,toW,topBound,PenWidth*2)
                        
                    end
                    
                    % Placing the image according to the measurement:
                    %Screen('PutImage',Window, Images_practiceDemo{RAndFRACT(l)}, newdownRect); %RAndFRACT(l)
                    
                    Screen('Flip',Window,[],[],2);
                    
                    Val_vec(cnt)=newdownRect(2);
                    
                    cnt=cnt+1;
                end
                
                
                
            else
                % Setting the effort bar still
                % Screen('DrawLine',Window,[255 255 255],fromW,topBound,toW,topBound,PenWidth*2)
                %Screen('Flip',Window);
                %  7  WaitSecs(1);
                
                iti_OnTime=GetSecs;
                while (GetSecs - iti_OnTime) <=  iti_length
                    v = DaqAIn(daq,Achan,Arange);
                    if  v >=0.2% && l~=1 && tal~=1
                        %if  v >=1.65
                        
                        Screen('PutImage',Window,instrunt_dontsqeez);
                        iti_OnTime=GetSecs;
                        
                    else
                        CenterText(Window,'+', white,0,0);
                        
                    end
                    Screen(Window,'Flip');
                    
                end
                
                Screen('Flip',Window);
                
                
                %counter = 1; %#################
                
                EffortOnTime = GetSecs;
                % Setting the primary and changing lacation of the fractal on the screen.
                newdownRect = downRect;
                StartYVal = newdownRect(2); % Top edge .
                cnt=1;
                Val_vec=newdownRect(2);
                while (GetSecs - EffortOnTime) <= EffortDur
                    
                    % Converts measurement (V) to pixel using the grip calibration.
                    %v = 0.5; %for no dinamo
                    v = DaqAIn(daq,Achan,Arange);
                    vN = v - MinCal;
                    vN = vN*ScaleFactor*effort_req(tal,demo_effort_levels(l))  ;
                    NewYVal = (StartYVal - vN);
                    
                    %V_measure(counter) = v; %#################
                    %counter = counter + 1; %#################
                    
                    % Locates the fractal on the screen according to the measurement.
                    % If the measurment is higher the the yellow bar:
                    if NewYVal <= 0
                        newdownRect(2) = 0;
                        newdownRect(4) = newdownRect(2)+stackH_train;
                        % If the measurment is lower the the yellow bar:
                    elseif NewYVal > StartYVal
                        newdownRect = downRect;
                    else newdownRect(2) = NewYVal;
                        newdownRect(4) = newdownRect(2)+stackH_train;
                    end
                    
                    Screen('PutImage',Window, demo_Images{RAnd_demoFRACT(l)}, newdownRect); %RAndFRACT(l)
                    
                    
                    if newdownRect(2) <=topBound;
                        Screen('DrawLine',Window,[0 255 0],fromW,topBound,toW,topBound,PenWidth*2)
                        %goal_vec(counter) = 1; %#################
                    elseif newdownRect(2) > topBound && min(Val_vec)>topBound
                        % Placing the effort bar
                        Screen('DrawLine',Window,[255 0 0],fromW,topBound,toW,topBound,PenWidth*2)
                        %goal_vec(counter) = 0; %#################
                    else
                        Screen('DrawLine',Window,[ 0 255 0],fromW,topBound,toW,topBound,PenWidth*2)
                        
                    end
                    
                    % Placing the image according to the measurement:
                    %Screen('PutImage',Window, Images_practiceDemo{RAndFRACT(l)}, newdownRect); %RAndFRACT(l)
                    
                    Screen('Flip',Window,[],[],2);
                    
                    Val_vec(cnt)=newdownRect(2);
                    
                    cnt=cnt+1;
                end
                
            end
        end
    end
    CalibOutMsg = ['Do you want to proceed?' '\n if Yes press y'];
    DrawFormattedText(Window,CalibOutMsg,'center','center',TextColor);
    Screen('Flip',Window);
    %     %   FlushEvents; %#####
    %     %    KbQueueFlush;
    %     %    KbQueueStart;
    %     % Waits for keyboard input.
    %     wait4key
    %     %
    
    
    keyIsDown=0;
    
    KbQueueCreate()
    KbQueueStart();%%start listening
    KbQueueFlush();%%removes all keyboard presses
    
    while ~keyIsDown
        
        [keyIsDown,~,keyCode] = KbCheck(-1);
        Response = KbName(keyCode);
        
        
        if ismember(Response,['y','Y'])
            
            Screen('Flip',Window);
            CalibDone = 1;
        end
    end
end


