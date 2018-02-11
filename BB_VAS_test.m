% =========================================================================
% rate items difficulty  % BB_VAS
% =========================================================================
%% pre run

runNUMs=num2str(runNUM);
TIMEstamp
fid_vas = fopen([outputPath '/' subjectID '_vas_' runNUMs '_' timestamp '.txt'],'a');
fprintf(fid_vas,'Image_num\t Effort_level\t Effort_rate\t VAS_res_time\n');

%RAndFRACT=randperm(length(f)); %length(Practice_Images)); %effort_stim_num

runNETLength=135;
trialDur = 2;      %
baseline_fixation_dur = 2; % Need to modify based on if first few volumes are saved or not
afterrunfixation = 6;

penWidth=3;
%______________________________________________________________________
% sizes

VasstackH= size(Image_example,1)*0.7; % Setting image hight.
VasstackW= size(Image_example,2)*0.7; % Setting image width.
VASdownRect=[xcenter-VasstackW/2 ycenter-VasstackH/2 xcenter+VasstackW/2 ycenter+VasstackH/2];



Vas_scale_stackH= size(instrct_vas_scale,1); % Setting scale hight.
Vas_scale_stackW= size(instrct_vas_scale,2); % Setting scale width.

SCALEdownRect=[xcenter-Vas_scale_stackW/2 ycenter+VasstackH/2 xcenter+Vas_scale_stackW/2 ycenter+Vas_scale_stackH+VasstackH/2];

% DEMO

if runNUM==1 % for Demo
    vas_Demo
else
    
    
    Screen('PutImage',Window,instrct_vas_recog);
    Screen(Window,'Flip');
    wait4key
end
%% run

        Screen('PutImage',Window,instrct_vas_recog);
        Screen(Window,'Flip');
        KbQueueCreate;
        KbQueueFlush;
        KbQueueStart;
        WaitSecs(0.5);
        wait4key
        
        Screen('Flip',Window); 
        
VASrec_start= GetSecs;
runStart= GetSecs;

CenterText(Window,'+', white,0,0);

Screen(Window,'Flip');


vas_input=zeros(1,length(Practice_Images));
RAndFRACT=randperm(length(Practice_Images)); %length(Practice_Images)); %effort_stim_num

msg=['VAS_run_' runNUMs '_starttime_' num2str(GetSecs)];
Eyelinkmsg
% Loop of 10 repetes, one for each fractal.
for l=1:length(Practice_Images) %(effort_stim_num) %(effort_stim_num)
    %insert VAS part here
    name(l) = RAndFRACT(l); %#################
    level(l) = inv(effort_req(RAndFRACT(l))); %#################

    
    Screen('PutImage',Window,Practice_Images{RAndFRACT(l)}, VASdownRect);
    Screen('PutImage',Window,instrct_vas_scale,SCALEdownRect);
    Screen(Window,'Flip',VAS_onST_vec(runNUM,l)+runStart);
    
    
    KbName('UnifyKeyNames');
    
    Starttime = GetSecs; % get the current time
    % just to load KbCheck once cos it's slow first time.
    while KbCheck;
    end % Wait until all keys are released.
    
    
      keyIsDown=0;
    while keyIsDown ~=1 && GetSecs-runStart-VAS_onST_vec(runNUM,l)<trialDur
        [keyIsDown, secs, keycode] = KbCheck;
        vas_input_str = KbName(keycode); % get the key
        matchkey2num
        if ismember(vas_input(l), (1:4))==0
            keyIsDown=0;
        end
    end
    
    vas_resptime(l) = secs - Starttime; % calculate the response time
    
    Screen('PutImage',Window,Practice_Images{RAndFRACT(l)}, VASdownRect);
    Screen('PutImage',Window,instrct_vas_scale,SCALEdownRect);
    
    switch vas_input(l)
        case 1
            Screen('FrameRect', Window, [255 255 255],[xcenter-Vas_scale_stackW/2-20 ycenter+VasstackH/2 xcenter-Vas_scale_stackW/4-20 ycenter+Vas_scale_stackH+VasstackH/2], penWidth);
        case 2
            Screen('FrameRect', Window, [255 255 255],[xcenter-Vas_scale_stackW/4-20 ycenter+VasstackH/2 xcenter ycenter+Vas_scale_stackH+VasstackH/2], penWidth);
        case 3
            Screen('FrameRect', Window, [255 255 255],[xcenter ycenter+VasstackH/2 xcenter+Vas_scale_stackW/4-20 ycenter+Vas_scale_stackH+VasstackH/2], penWidth);
        case 4
            Screen('FrameRect', Window, [255 255 255],[xcenter+Vas_scale_stackW/4+20 ycenter+VasstackH/2 xcenter+Vas_scale_stackW/2+20 ycenter+Vas_scale_stackH+VasstackH/2], penWidth);
    end
    Screen(Window,'Flip')
    
    while KbCheck; end
    
    CenterText(Window,'+', white,0,0);
    
    Screen(Window,'Flip',VAS_onST_vec(runNUM,l)+runStart+trialDur);
    

    
    fprintf(fid_vas,'%d\t %d\t %d\t %d\n', name(l), level(l),vas_input(l), vas_resptime(l)); %#################
    
    
    
%     keyIsDown=0;
%     
%     
%     while keyIsDown ~=1 && GetSecs-runStart-VAS_onST_vec(runNUM,l)<trialDur
%         [keyIsDown, secs, keycode] = KbCheck;
%         
%         vas_input_str = KbName(keycode); % get the key
%         vas_resptime(l) = secs - Starttime; % calculate the response time
%         matchkey2num
%         
%         if ismember(vas_input(l), (1:4))==1
%             
%             switch vas_input(l)
%                 
%                 case 1
%                     Screen('PutImage',Window,Practice_Images{RAndFRACT(l)}, VASdownRect);
%                     Screen('PutImage',Window,instrct_vas_scale,SCALEdownRect);
%                     Screen('FrameRect', Window, [255 255 255],[xcenter-Vas_scale_stackW/2-20 ycenter+VasstackH/2 xcenter-Vas_scale_stackW/4-20 ycenter+Vas_scale_stackH+VasstackH/2], penWidth);
%                     Screen(Window,'Flip')
%                     
%                 case 2
%                     Screen('PutImage',Window,Practice_Images{RAndFRACT(l)}, VASdownRect);
%                     Screen('PutImage',Window,instrct_vas_scale,SCALEdownRect);
%                     Screen('FrameRect', Window, [255 255 255],[xcenter-Vas_scale_stackW/4-20 ycenter+VasstackH/2 xcenter ycenter+Vas_scale_stackH+VasstackH/2], penWidth);
%                     Screen(Window,'Flip')
%                 case 3
%                     Screen('PutImage',Window,Practice_Images{RAndFRACT(l)}, VASdownRect);
%                     Screen('PutImage',Window,instrct_vas_scale,SCALEdownRect);
%                     Screen('FrameRect', Window, [255 255 255],[xcenter ycenter+VasstackH/2 xcenter+Vas_scale_stackW/4-20 ycenter+Vas_scale_stackH+VasstackH/2], penWidth);
%                     Screen(Window,'Flip')
%                 case 4
%                     Screen('PutImage',Window,Practice_Images{RAndFRACT(l)}, VASdownRect);
%                     Screen('PutImage',Window,instrct_vas_scale,SCALEdownRect);
%                     Screen('FrameRect', Window, [255 255 255],[xcenter+Vas_scale_stackW/4+20 ycenter+VasstackH/2 xcenter+Vas_scale_stackW/2+20 ycenter+Vas_scale_stackH+VasstackH/2], penWidth);
%                     Screen(Window,'Flip')
%                     
%                     
%                     
%             end
%             
%         else keyIsDown=0;
%         end
%     end;
%     while KbCheck; end
%     
%     CenterText(Window,'+', white,0,0);
%     
%     Screen(Window,'Flip',VAS_onST_vec(runNUM,l)+runStart+trialDur);
% 
%     fprintf(fid_vas,'%d\t %d\t %d\t %d\n', name(l), level(l), vas_input(l), vas_resptime(l)); %#################
    
end



%% post run
while GetSecs< runStart+baseline_fixation_dur+runNETLength % net run + prebaseline (2)
end
 
CenterText(Window,'+', white,0,0);

Screen(Window,'Flip');
WaitSecs(afterrunfixation)

AllrunsDur.VAS(runNUM)=GetSecs-runStart;


fclose(fid_vas); %#################
save ([pwd '/Output/' subjectID '_exp_parameters'])


