% =========================================================================
% Binary chioce probe  % BB_probe
% =========================================================================
%% pre run


runNUMs=num2str(runNUM);
block=runNUM;

if runNUM==1;
    
    numBlocks = 2; % Define how many blocks for the probe session. Each block includes all comparisons, one time each.
    numRunsPerBlock = 1; % Define the required number of runs per block
    
    
    % Run blocks. Before each block, stimuli need to be organized in a list and
    % divided to the required number of runs
    for ind = 1:numBlocks
        %block = (sessionNum-1)*2 + ind;
        % Organize the stimuli for the probe
        % ===================================
        [trialsPerRun] = organizeProbe_Israel(subjectID, order, ind, numRunsPerBlock);
    end
    
end
%==============================================
% 'Read in data'
%==============================================

file = dir([pwd '/Output/' subjectID '_stopGoList_allstim_order*.txt']);
fid = fopen([pwd '/Output/' sprintf(file(length(file)).name)]);
stopGoList_allstim_order_data = textscan(fid, '%s %f %f %f %f') ;% these contain everything from the sortbdm
stimName = stopGoList_allstim_order_data{1};
bidIndex = stopGoList_allstim_order_data{3};
bidValue = stopGoList_allstim_order_data{4};
fclose(fid);
Images = cell(1,length(stimName));
for i = 1:length(stimName)
    Images{i}=imread([pwd,'/Stim/',stimName{i}]);
end


%   'read in organized list of stimuli for this run'
% - - - - - - - - - - - - - - - - - - - - - - - - - -
fid = fopen([outputPath '/' sprintf('%s_stimuliForProbe_order%d_block_%d_run%d.txt',subjectID,order,block,1)]);
stimuli = textscan(fid, '%d %d %d %d %s %s') ;% these contain everything from the organizedProbe
stimnum1 = stimuli{1};
stimnum2 = stimuli{2};
leftGo = stimuli{3};
pairType = stimuli{4};
leftname = stimuli{5};
rightname = stimuli{6};
fclose(fid);

%==============================================
% constants
%==============================================
%   'set phase times'
runNETLength=405;
maxtime = 1.5;      % 1.5 second limit on each selection
baseline_fixation_dur = 2; % Need to modify based on if first few volumes are saved or not
afterrunfixation = 1;

% Define Colors
% - - - - - - - - - - - - - - -
black = BlackIndex(Window); % Should equal 0.
white = WhiteIndex(Window); % Should equal 255.
green = [0 255 0];

theFont = 'Arial';
Screen('TextFont',Window,theFont);

% Define image scale - Change according to your stimuli
% - - - - - - - - - - - - - - -
stackH= size(Practice_Images{1},1);
stackW= size(Practice_Images{1},2);

% stackW = 576;
% stackH = 432;
[wWidth, wHeight]=Screen('WindowSize', Window);
xcenter=wWidth/2;
ycenter=wHeight/2;
xDist = wWidth/8; %300; % distance from center in the x axis. can be changed to adjust to smaller screens
leftRect=[xcenter-stackW-xDist ycenter-stackH/2 xcenter-xDist ycenter+stackH/2]; % left stack location
rightRect=[xcenter+xDist ycenter-stackH/2 xcenter+stackW+xDist ycenter+stackH/2]; % right stack location

penWidth = 10;

% 'ASSIGN response keys'
% - - - - - - - - - - - - - - -
leftstack = 'u';
rightstack = 'i';
badresp = 'x';

% 'Write output file header'
%-----------------------------------------------------------------
TIMEstamp
fid1 = fopen([outputPath '/' subjectID sprintf('_probe_block_%02d_run_%02d_', block, runNUM) timestamp '.txt'], 'a');
fprintf(fid1,'subjectID\tscanner\torder\tblock\trun\ttrial\tonsettime\tImageLeft\tImageRight\tbidIndexLeft\tbidIndexRight\tIsleftGo\tResponse\tPairType\tOutcome\tRT\tbidLeft\tbidRight\n'); %write the header line


TIMEstamp

HideCursor;

% if runNUM == 1  % If this is the first run of the first or third block, show instructions
Screen('PutImage',Window,instrct_probe);
Screen('Flip',Window);
wait4key
% end % end if numRun == 1 && block ==1

%% run
runStart= GetSecs;
msg=['probe_run_' runNUMs '_starttime_' num2str(GetSecs)];
Eyelinkmsg
CenterText(Window,'+', white,0,0);
Screen(Window,'Flip');



%==============================================
% 'Run Trials'
%==============================================

for trial = 1:trialsPerRun
    
    
    % initial box outline colors
    % - - - - - - -
    out = 999;
    %-----------------------------------------------------------------
    % display images
    %-----------------------------------------------------------------
    if leftGo(trial) == 1
        Screen('PutImage',Window,Images{stimnum1(trial)}, leftRect);
        Screen('PutImage',Window,Images{stimnum2(trial)}, rightRect);
    else
        Screen('PutImage',Window,Images{stimnum2(trial)}, leftRect);
        Screen('PutImage',Window,Images{stimnum1(trial)}, rightRect);
    end
    %     CenterText(Window,'+', white,0,0);
    Screen(Window,'Flip',Probe_onST_vec(runNUM,trial)+runStart);
    onsetTime= GetSecs-runStart;
    msg=['probe_run_' runNUMs '_images_' num2str(stimnum1(trial)) '_and_' num2str(stimnum2(trial)) '_onset_ ' num2str(GetSecs-runStart)];
    Eyelinkmsg;% ---------------------------
    
    KbQueueFlush;
    KbQueueStart;
    
    %-----------------------------------------------------------------
    % get response
    %-----------------------------------------------------------------
    trialStartTime= GetSecs;
    
    noresp = 1;
    goodresp = 0;
    while noresp
        % check for response
        [keyIsDown, firstPress] = KbQueueCheck;
        
        if keyIsDown && noresp
            keyPressed = KbName(firstPress);
            if ischar(keyPressed) == 0 % if 2 keys are hit at once, they become a cell, not a char. we need keyPressed to be a char, so this converts it and takes the first key pressed
                keyPressed = char(keyPressed);
                keyPressed = keyPressed(1);
            end
            switch keyPressed
                case leftstack
                    respTime = firstPress(KbName(leftstack))-onsetTime;
                    noresp = 0;
                    goodresp = 1;
                case rightstack
                    respTime = firstPress(KbName(rightstack))-onsetTime;
                    noresp = 0;
                    goodresp = 1;
            end
            msg=['probe_run_' runNUMs '_images_' num2str(stimnum1(trial)) '_and_' num2str(stimnum2(trial)) '_RT_' num2str(GetSecs-runStart)];
            Eyelinkmsg;% ---------------------------
        end % end if keyIsDown && noresp
        
        % check for reaching time limit
        if noresp && GetSecs-trialStartTime > maxtime
            noresp = 0;
            keyPressed = badresp;
            respTime = maxtime;
            CenterText(Window,sprintf('You must respond faster!') ,white,0,0);
            Screen(Window,'Flip');
            WaitSecs(0.7)
        end
    end % end while noresp
    
    %-----------------------------------------------------------------
    % determine what bid to highlight
    %-----------------------------------------------------------------
    
    switch keyPressed
        case leftstack
            if leftGo(trial) == 0
                out = 0;
            else
                out = 1;
            end
        case rightstack
            if leftGo(trial) == 1
                out = 0;
            else
                out = 1;
            end
    end
    
    if goodresp==1
        if leftGo(trial)==1
            Screen('PutImage',Window,Images{stimnum1(trial)}, leftRect);
            Screen('PutImage',Window,Images{stimnum2(trial)}, rightRect);
        else
            Screen('PutImage',Window,Images{stimnum2(trial)}, leftRect);
            Screen('PutImage',Window,Images{stimnum1(trial)}, rightRect);
        end
        
        if keyPressed=='u'||keyPressed=='r'
            Screen('FrameRect', Window, green, leftRect, penWidth);
        elseif keyPressed=='i'||keyPressed=='g'
            Screen('FrameRect', Window, green, rightRect, penWidth);
        end
        
        
        Screen(Window,'Flip')
        msg=['probe_run_' runNUMs '_images_' num2str(stimnum1(trial)) '_and_' num2str(stimnum2(trial)) '_rect_ ' num2str(GetSecs-runStart)];
        Eyelinkmsg;% ---------------------------
        WaitSecs(0.5)
    end % end if goodresp==1
    
    %-----------------------------------------------------------------
    % show fixation ITI
    %-----------------------------------------------------------------
    
    CenterText(Window,'+', white,0,0);
    Screen(Window,'Flip');
    
    msg=['probe_run_' runNUMs '_images_' num2str(stimnum1(trial)) '_and_' num2str(stimnum2(trial)) '_offset_' num2str(GetSecs-runStart)];
    Eyelinkmsg;% ---------------------------
    
    if goodresp ~= 1
        respTime = 999;
    end
    
    %-----------------------------------------------------------------
    % 'Save data'
    %-----------------------------------------------------------------
    if leftGo(trial)==1
        fprintf(fid1,'%s\t%d\t%d\t%s\t%d\t%d\t%d\t%s\t%s\t%d\t%d\t%d\t%s\t%d\t%d\t%.2f\t%.2f\t%.2f\n', subjectID, 1, order, sprintf('%02d', block), runNUM, trial, onsetTime, char(leftname(trial)), char(rightname(trial)), stimnum1(trial), stimnum2(trial), leftGo(trial), keyPressed, pairType(trial), out, respTime*1000, bidValue(stimnum1(trial)), bidValue(stimnum2(trial)));
    else
        fprintf(fid1,'%s\t%d\t%d\t%s\t%d\t%d\t%d\t%s\t%s\t%d\t%d\t%d\t%s\t%d\t%d\t%.2f\t%.2f\t%.2f\n', subjectID, 1, order, sprintf('%02d', block), runNUM, trial, onsetTime, char(leftname(trial)), char(rightname(trial)), stimnum2(trial), stimnum1(trial), leftGo(trial), keyPressed, pairType(trial), out, respTime*1000, bidValue(stimnum2(trial)), bidValue(stimnum1(trial)));
    end
    
    
end % loop through trials
fclose(fid1);

msg=['probe_run_' runNUMs '_runend_' num2str(GetSecs)];
Eyelinkmsg;% ---------------------------
%% post run

while GetSecs-runStart < runNETLength+baseline_fixation_dur % net run + prebaseline (2)
end

CenterText(Window,'+', white,0,0);

Screen(Window,'Flip');
WaitSecs(afterrunfixation)

AllrunsDur.Probe(runNUM)= GetSecs- runStart;


Screen('FillRect', Window, black);


%---------------------------------------------------------------
% create a data structure with info about the run
%---------------------------------------------------------------
outfile = strcat(outputPath,'/', sprintf('%s_probe_block_%d_run_%d_%s.mat',subjectID,block,runNUM,timestamp));

% create a data structure with info about the run
run_info.subject=subjectID;
run_info.date=date;
run_info.outfile=outfile;

run_info.script_name=mfilename;
%clear ('Images','Instructions_image');
save(outfile);






save ([pwd '/Output/' subjectID '_AA_EVA4_Scan_exp_parameters'])



