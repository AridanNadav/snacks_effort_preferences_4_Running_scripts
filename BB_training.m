% =========================================================================
% BB_training
% =========================================================================
%% pre run


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

Screen('PutImage',Window,instrct_practice);
Screen(Window,'Flip');
WaitSecs(1);
wait4key

%% run

% wait4t
runStart= GetSecs;
HideCursor

CenterText(Window,'+', white,0,0);
Screen(Window,'Flip');

msg=['EffortLearning_run_' runNUMs '_starttime_' num2str(GetSecs)];
Eyelinkmsg

onsetind=1;
for trainPerRun=1:2
    RAndFRACT=randperm(length(Practice_Images)); %length(Practice_Images)); %effort_stim_num

    for l=1:length(Practice_Images) %(effort_stim_num)
        counter = 1; %for entering dyno data
        newdownRect = downRect;
        StartYVal = newdownRect(2); % Top edge of the fractal.
        barcnt=1;%for traking goal made
        Val_vec=newdownRect(2);
        goal_time(l)=0;
        
        trialStart = GetSecs;
        realonset=GetSecs-runStart;
        
        
        msg=['EffortLearning_run_' runNUMs '_image_' num2str(RAndFRACT(l)) '_onset_' num2str(realonset)];
        Eyelinkmsg;% ---------------------------
        
        while (GetSecs - trialStart) <= EffortDur
            
            % Converts measurement (V) to pixel using the grip calibration.
            v = DaqAIn(daq,Achan,Arange);
            vN = v - MinCal;
            vN = vN*ScaleFactor*effort_req(RAndFRACT(l))  ;
            NewYVal = (StartYVal - vN);
            V_measure(counter) = v; %#################
            counter = counter + 1; %#################
            
            % Locates the image on the screen according to the measurement.
            
            % If the measurment is higher the the  bar:
            if NewYVal <= 0
                newdownRect(2) = 0;
                newdownRect(4) = newdownRect(2)+stackH_train;
                
                % If the measurment is lower the the yellow bar:
            elseif NewYVal > StartYVal
                newdownRect = downRect;
            else newdownRect(2) = NewYVal;
                newdownRect(4) = newdownRect(2)+stackH_train;
            end
            
            Screen('PutImage',Window,Practice_Images{RAndFRACT(l)}, newdownRect); %RAndFRACT(l)
            
            if newdownRect(2) <=topBound ;
                Screen('DrawLine',Window,[0 255 0],fromW,topBound,toW,topBound,PenWidth*2)
                goal_vec(counter) = 1; %#################
                if goal_time(l)==0
                    goal_time(l) =GetSecs - trialStart;
                    
                    msg=['EffortLearning_run_' runNUMs '_image_' num2str(RAndFRACT(l)) '_goaltime_' num2str(GetSecs-runStart)];
                    Eyelinkmsg;% ---------------------------


                else
                end
                
            elseif newdownRect(2) > topBound && min(Val_vec)>topBound
                % Placing the effort bar
                Screen('DrawLine',Window,[255 0 0],fromW,topBound,toW,topBound,PenWidth*2)
                goal_vec(counter) = 0; %#################
            else
                Screen('DrawLine',Window,[ 0 255 0],fromW,topBound,toW,topBound,PenWidth*2)
                
            end
            
            % Placing the image according to the measurement:
            Val_vec(barcnt)=newdownRect(2);
            barcnt=barcnt+1;
            
            Screen(Window,'Flip');

        end
        
        msg=['EffortLearning_run_' runNUMs '_image_' num2str(RAndFRACT(l)) '_offset_' num2str(GetSecs-runStart)];
        Eyelinkmsg;% ---------------------------        

        % trial data
        name(l) = RAndFRACT(l); %#################
        level(l) = inv(effort_req(RAndFRACT(l))); %#################
        if any(goal_vec)
            goal(l) = 1;
        else
            goal(l) = 0;
        end
        grip_measure = num2str(V_measure); %#################
        fprintf(fidtraining,'%d\t %d\t %d\t %d\t %s\n', name(l), level(l),  goal(l),goal_time(l), grip_measure); %#################
        
        
        fixstart=GetSecs;
        while  GetSecs < runStart+Training_onST_vec(runNUM,onsetind)+trialDur;    %= trialStart+trialDur+ITIvec(trialNum)

            v = DaqAIn(daq,Achan,Arange);
            %   if v >=1.65
            if v >=0.2 && (GetSecs - fixstart)>0.7
                
                Screen('PutImage',Window,instrunt_dontsqeez);
                
            else
                CenterText(Window,'+', white,0,0);
                
            end
            Screen(Window,'Flip');
            
        end
onsetind=onsetind+1;

    end   
end

msg=['EffortLearning_run_' runNUMs '_image_' num2str(RAndFRACT(l)) '_offset_' num2str(GetSecs-runStart)];
Eyelinkmsg;% ---------------------------
%% post run
CenterText(Window,'+', white,0,0);
while GetSecs< runStart+baseline_fixation_dur+runNETLength % net run + prebaseline (2)
end  

CenterText(Window,'+', white,0,0);
Screen(Window,'Flip');
WaitSecs(afterrunfixation)


    
fclose(fidtraining);
AllrunsDur.training_runTime(runNUM)=GetSecs-runStart;








