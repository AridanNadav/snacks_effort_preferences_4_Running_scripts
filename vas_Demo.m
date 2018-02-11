
% vas_Demo

fid_vas_demo = fopen([outputPath '/' subjectID '_vas_' runNUMs '_' timestamp '.txt'],'a');
fprintf(fid_vas_demo,'Image_num\t Effort_level\t Effort_rate\t VAS_res_time\n');

DemoRAndFRACT= randperm(length(demo_Images));
Screen('PutImage',Window,instrct_vas_demo);
Screen(Window,'Flip');
wait4key

Screen('Flip',Window);


for l=1:3 %(effort_stim_num)
    %insert VAS part here
    name(l) = DemoRAndFRACT(l); %#################
    level(l) = inv(effort_req(DemoRAndFRACT(l))); %#################
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    Screen('PutImage',Window,demo_Images{DemoRAndFRACT(l)}, VASdownRect);
    Screen('PutImage',Window,instrct_vas_scale,SCALEdownRect);
    Screen('Flip',Window);
    
    
    KbName('UnifyKeyNames');
    
    Starttime = GetSecs; % get the current time
    % just to load KbCheck once cos it's slow first time.
    while KbCheck;
    end % Wait until all keys are released.
    keyIsDown=0;
    while keyIsDown ~=1
        [keyIsDown, secs, keycode] = KbCheck;
        
        vas_input_str = KbName(keycode); % get the key
        vas_resptime(l) = secs - Starttime; % calculate the response time
        matchkey2num
        if ismember(vas_input(l), (1:4))==1
            
            switch vas_input(l)
                
                case 1
                    Screen('PutImage',Window,demo_Images{DemoRAndFRACT(l)}, VASdownRect);
                    Screen('PutImage',Window,instrct_vas_scale,SCALEdownRect);
                    Screen('FrameRect', Window, [255 255 255],[xcenter-Vas_scale_stackW/2-20 ycenter+VasstackH/2 xcenter-Vas_scale_stackW/4-20 ycenter+Vas_scale_stackH+VasstackH/2], penWidth);
                    Screen(Window,'Flip')
                    
                case 2
                    Screen('PutImage',Window,demo_Images{DemoRAndFRACT(l)}, VASdownRect);
                    Screen('PutImage',Window,instrct_vas_scale,SCALEdownRect);
                    Screen('FrameRect', Window, [255 255 255],[xcenter-Vas_scale_stackW/4-20 ycenter+VasstackH/2 xcenter ycenter+Vas_scale_stackH+VasstackH/2], penWidth);
                    Screen(Window,'Flip')
                case 3
                    Screen('PutImage',Window,demo_Images{DemoRAndFRACT(l)}, VASdownRect);
                    Screen('PutImage',Window,instrct_vas_scale,SCALEdownRect);
                    Screen('FrameRect', Window, [255 255 255],[xcenter ycenter+VasstackH/2 xcenter+Vas_scale_stackW/4-20 ycenter+Vas_scale_stackH+VasstackH/2], penWidth);
                    Screen(Window,'Flip')
                case 4
                    Screen('PutImage',Window,demo_Images{DemoRAndFRACT(l)}, VASdownRect);
                    Screen('PutImage',Window,instrct_vas_scale,SCALEdownRect);
                    Screen('FrameRect', Window, [255 255 255],[xcenter+Vas_scale_stackW/4+20 ycenter+VasstackH/2 xcenter+Vas_scale_stackW/2+20 ycenter+Vas_scale_stackH+VasstackH/2], penWidth);
                    Screen(Window,'Flip')
                    
                    
                    
            end
            WaitSecs(0.7)
            
        else keyIsDown=0;
        end
    end;
    while KbCheck; end
    
    
    
    
    Screen('Flip', Window);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    fprintf(fid_vas_demo,'%d\t %d\t %d\t %d\n', name(l), level(l), vas_input(l), vas_resptime(l)); %#################
    
    ITI_demo=GetSecs;
    CenterText(Window,'+', white,0,0);
    Screen(Window,'Flip');
    while GetSecs < ITI_demo+2
    end
    
end