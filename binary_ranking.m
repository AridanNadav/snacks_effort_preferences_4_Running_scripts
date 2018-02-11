
%function binary_ranking()
%load ('exp_parameters')

% Ranking using a set of binary choices.
% This function was written based on the probe code. It is used to rank 27
% different items, based on subject's selection. In each trial two images
% will appear on screen, and the subject is asked to choose one, using the
% 'u' and 'i' keys. Each stimulus will be presented exactly 10 times, each
% time in a different comparison, for a total number of 351 unique
% comparisons.
% Finally, Colley ranking code is run on the subject's choices to create a
% ranking list of all 27 item.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % % ---------------- FUNCTIONS REQUIRED TO RUN PROPERLY: ----------------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % %   'random_stimlist_generator'
% % %   'colley'


% set phase times
% - - - - - - - - - - - - - - - - -
maxtime=2;      % 2.5 second limit on each selection
baseline_fixation_dur=0.5; % Need to modify based on if first few volumes are saved or not
afterrunfixation=0.5;
TotalTrialDuration = maxtime + baseline_fixation_dur + afterrunfixation;
tic

% essential for randomization
rng shuffle

black=BlackIndex(Window); % Should equal 0.
white=WhiteIndex(Window); % Should equal 255.
green=[0 255 0];

Screen('FillRect', Window, black);  % NB: only need to do this once!
Screen('Flip', Window);


% text stuffs
% - - - - - - - - - - - - - - -
theFont='Arial';
Screen('TextFont',Window,theFont);
Screen('TextSize',Window, 40);

% Define image scale - Change according to your stimuli
% - - - - - - - - - - - - - - -
stackH= size(Practice_Images{1},1);
stackW= size(Practice_Images{1},2);

%stackW = 576;
%stackH = 432;

% Frame and stack properties
% - - - - - - - - - - - - - - -
[wWidth, wHeight]=Screen('WindowSize', Window);
xcenter=wWidth/2;
ycenter=wHeight/2;
xDist = wWidth/8; %300; % distance from center in the x axis. can be changed to adjust to smaller screens
leftRect=[xcenter-stackW-xDist ycenter-stackH/2 xcenter-xDist ycenter+stackH/2]; % left stack location
rightRect=[xcenter+xDist ycenter-stackH/2 xcenter+stackW+xDist ycenter+stackH/2]; % right stack location
penWidth=10; % frame width

HideCursor;

%==============================================
%% 'ASSIGN response keys'
% %==============================================

leftstack='u';
rightstack= 'i';
badresp='x';

%==============================================
%%   'PRE-TRIAL DATA ORGANIZATION'
%==============================================
% Stimuli lists
% - - - - - - - - - - - - - - -
number_of_stimuli=length(IMGnames); % number of stimuli

number_of_trials=351; % desired number of trials (number of unique comparisons)

% Define onsets
% - - - - - - - - - - - - - - -
onsetlist=0:TotalTrialDuration:TotalTrialDuration*number_of_trials;

% IMPORTANT NOTE: every stimulus will be presented exactly 2*number_of_trials/n times. Therefore, number_of_trials should be a multiple of n/2. e.g if n=60, number_of_trials can be 30,60,90,120....
% ==============                                                                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%[shuffle_stimlist1_2nd,shuffle_stimlist2_2nd]=random_stimlist_generator(number_of_stimuli,number_of_trials);
BRallCOMB

% Colley's ranking analysis variables
% - - - - - - - - - - - - - - -
N=zeros(number_of_stimuli,3); %create the N matrix of (win,loses,total) for each stimulus (each row represent a specific stimulus). To be used in Colley's ranking
T=zeros(number_of_stimuli,number_of_stimuli); %create the T symetric matrix of "competitions"  (each row represent a specific stimulus). T(a,b)=T(b,a)=-1 means a "competition" had taken place between stimuli a&b. To be used in Colley's ranking
for stimulus=1:number_of_stimuli
    T(stimulus,shuffle_stimlist1(shuffle_stimlist2==stimulus))=-1;
    T(shuffle_stimlist1(shuffle_stimlist2==stimulus),stimulus)=-1;
    T(stimulus,shuffle_stimlist2(shuffle_stimlist1==stimulus))=-1;
    T(shuffle_stimlist2(shuffle_stimlist1==stimulus),stimulus)=-1;
    N(stimulus,3)=(sum(shuffle_stimlist1==stimulus)+sum(shuffle_stimlist2==stimulus));
end

%-----------------------------------------------------------------
%% 'Write output file header'
%-----------------------------------------------------------------

fid9=fopen([pwd '/Output/' subjectID '_binary_ranking_' timestamp '.txt'], 'a');
fprintf(fid9,'subjectID\truntrial\tonsettime\tImageLeft\tImageRight\tStimNumLeft\tStimNumRight\tResponse\tOutcome\tRT\n');

%==============================================
%% 'Display Main Instructions'
%==============================================
KbQueueCreate;

Screen('PutImage',Window,instrct_binary_ranking);

Screen(Window,'Flip');
WaitSecs(1);
wait4key

% baseline fixation cross
% - - - - - - - - - - - - -
prebaseline = GetSecs;
% baseline fixation - currently 10 seconds = 4*Volumes (2.5 TR)
while GetSecs < prebaseline+baseline_fixation_dur
    %    Screen(w,'Flip', anchor);
    CenterText(Window,'+', white,0,-60);
    Screen(Window,'Flip');
end
postbaseline = GetSecs;
baseline_fixation = postbaseline - prebaseline;

%==============================================
%% 'Run Trials'
%==============================================
runtrial=1;
runStart=GetSecs;

for trial=1:number_of_trials
    
    chose_rand=rand; % randomly chose left/right location od stimuli
    if chose_rand<=0.5
        leftname=IMGnames{shuffle_stimlist1(trial)};
        rightname=IMGnames{shuffle_stimlist2(trial)};
    else
        leftname=IMGnames{shuffle_stimlist2(trial)};
        rightname=IMGnames{shuffle_stimlist1(trial)};
    end
    
    out=999;
    
    %------------------------ -----------------------------------------
    % display images
    %-----------------------------------------------------------------
    if chose_rand<=0.5
        Screen('PutImage',Window,Practice_Images{shuffle_stimlist1(trial)}, leftRect);
        Screen('PutImage',Window,Practice_Images{shuffle_stimlist2(trial)}, rightRect);
    else
        Screen('PutImage',Window,Practice_Images{shuffle_stimlist2(trial)}, leftRect);
        Screen('PutImage',Window,Practice_Images{shuffle_stimlist1(trial)}, rightRect);
    end
    CenterText(Window,'+', white,0,-60);
    StimOnset=Screen(Window,'Flip', runStart+onsetlist(runtrial)+baseline_fixation);
    
    %-----------------------------------------------------------------
    % get response
    %-----------------------------------------------------------------
    KbQueueFlush;
    KbQueueStart;
    noresp=1;
    goodresp=0;
    while noresp
        
        % check for response
        [keyIsDown, firstPress] = KbQueueCheck;
        
        if keyIsDown && noresp
            keyPressed=KbName(firstPress);
            
            if ischar(keyPressed)==0 % if 2 keys are hit at once, they become a cell, not a char. we need keyPressed to be a char, so this converts it and takes the first key pressed
                keyPressed=char(keyPressed);
                keyPressed=keyPressed(1);
            end
            
            switch keyPressed
                case leftstack
                    respTime=firstPress(KbName(leftstack))-StimOnset;
                    noresp=0;
                    goodresp=1;
                case rightstack
                    respTime=firstPress(KbName(rightstack))-StimOnset;
                    noresp=0;
                    goodresp=1;
            end
        end
        
        % check for reaching time limit
        if noresp && GetSecs-runStart >= onsetlist(runtrial)+baseline_fixation+maxtime
            noresp=0;
            keyPressed=badresp;
            respTime=maxtime;
        end
    end
    
    %-----------------------------------------------------------------
    % determine what bid to highlight
    %-----------------------------------------------------------------
    
    switch keyPressed
        case leftstack
            if shuffle_stimlist2(trial)==0
                out=1;
            else
                out=0;
            end
        case rightstack
            if shuffle_stimlist2(trial)==1
                out=1;
            else
                out=0;
            end
    end
    
    if goodresp==1 % if responded: add green rectangle around selected image
        if chose_rand<=0.5
            Screen('PutImage',Window,Practice_Images{shuffle_stimlist1(trial)}, leftRect);
            Screen('PutImage',Window,Practice_Images{shuffle_stimlist2(trial)}, rightRect);
        else
            Screen('PutImage',Window,Practice_Images{shuffle_stimlist2(trial)}, leftRect);
            Screen('PutImage',Window,Practice_Images{shuffle_stimlist1(trial)}, rightRect);
        end
        
        if keyPressed==leftstack
            Screen('FrameRect', Window, green, leftRect, penWidth);
        elseif keyPressed==rightstack
            Screen('FrameRect', Window, green, rightRect, penWidth);
        end
        
        CenterText(Window,'+', white,0,-60);
        Screen(Window,'Flip',runStart+onsetlist(trial)+respTime+baseline_fixation);
        
    else % if did not respond: show text 'You must respond faster!'
        CenterText(Window,sprintf('You must respond faster!') ,white,0,0);
        %         Screen('DrawText', w, 'You must respond faster!', xcenter-450, ycenter, white);
        Screen(Window,'Flip',runStart+onsetlist(runtrial)+respTime+baseline_fixation);
    end
    
    %-----------------------------------------------------------------
    % show fixation ITI
    %-----------------------------------------------------------------
    
    CenterText(Window,'+', white,0,-60);
    Screen(Window,'Flip',runStart+onsetlist(runtrial)+respTime+.5+baseline_fixation);
    
    if goodresp ~= 1
        respTime=999;
        % Colley ranking input - remove ties (no choices) from calculation.
        T(shuffle_stimlist1(trial),shuffle_stimlist2(trial))=0;
        T(shuffle_stimlist2(trial),shuffle_stimlist1(trial))=0;
        N(shuffle_stimlist1(trial),3)=N(shuffle_stimlist1(trial),3)-1;
        N(shuffle_stimlist2(trial),3)=N(shuffle_stimlist2(trial),3)-1;
        
    end
    
    %-----------------------------------------------------------------
    % write to output file
    %-----------------------------------------------------------------
    
    
    if chose_rand<=0.5
        fprintf(fid9,'%s\t%d\t%d\t%s\t%s\t%d\t%d\t%s\t%d\t%d\n', subjectID, runtrial, StimOnset-runStart, char(leftname), char(rightname), shuffle_stimlist1(trial), shuffle_stimlist2(trial), keyPressed, out, respTime*1000);
    else
        fprintf(fid9,'%s\t%d\t%d\t%s\t%s\t%d\t%d\t%s\t%d\t%d\n', subjectID, runtrial, StimOnset-runStart, char(leftname), char(rightname), shuffle_stimlist2(trial), shuffle_stimlist1(trial), keyPressed,  out, respTime*1000);
    end
    
    % add trial info to the Colley ranking mats
    if chose_rand<=0.5
        if keyPressed==leftstack
            N(shuffle_stimlist1(trial),1)=N(shuffle_stimlist1(trial),1)+1;
            N(shuffle_stimlist2(trial),2)=N(shuffle_stimlist2(trial),2)+1;
        elseif keyPressed==rightstack
            N(shuffle_stimlist2(trial),1)=N(shuffle_stimlist2(trial),1)+1;
            N(shuffle_stimlist1(trial),2)=N(shuffle_stimlist1(trial),2)+1;
        end
    else
        if keyPressed==rightstack
            N(shuffle_stimlist1(trial),1)=N(shuffle_stimlist1(trial),1)+1;
            N(shuffle_stimlist2(trial),2)=N(shuffle_stimlist2(trial),2)+1;
        elseif keyPressed==leftstack
            N(shuffle_stimlist2(trial),1)=N(shuffle_stimlist2(trial),1)+1;
            N(shuffle_stimlist1(trial),2)=N(shuffle_stimlist1(trial),2)+1;
        end
    end
    
    % end of current trial
    runtrial=runtrial+1;
    KbQueueFlush;
    
    if trial == 135
        pauseStart = GetSecs;
        CenterText(Window,sprintf('This is a short break'), white, 0,-300);
        CenterText(Window,sprintf('Press any key to continue') ,white,0,-100);
        Screen('Flip',Window);
        
        noresp = 1;
        while noresp,
            [keyIsDown,~,~] = KbCheck;
            if keyIsDown && noresp,
                noresp = 0;
            end;
        end;
        WaitSecs(0.5);
        
        CenterText(Window,'Choose the picture you like using i (right) and u (left) keys.',white,0,-300);
        CenterText(Window,'Please choose quickly.',white,0,-100);
        Screen('Flip',Window);
        
        noresp=1;
        while noresp,
            [keyIsDown,~,~] = KbCheck;
            if keyIsDown && noresp,
                noresp=0;
            end;
        end;
        WaitSecs(0.5);
        pauseDone = GetSecs;
        pauseTime = pauseDone - pauseStart;
        onsetlist(runtrial:end)= onsetlist(runtrial:end) + pauseTime;
        %runStart = runStart - pauseTime;
    end
end % loop through trials


fclose(fid9);


Postexperiment=GetSecs;
while GetSecs < Postexperiment+afterrunfixation;
    CenterText(Window,'+', white,0,-60);
    
    Screen(Window,'Flip');
end



%---------------------------------------------------------------
% create a data structure with info about the run
%---------------------------------------------------------------

outfile=strcat(pwd,'/Output/', sprintf('%s_binary_ranking_%s',subjectID,timestamp),'.mat');

% create a data structure with info about the run
run_info.subject=subjectID;
run_info.date=date;
run_info.outfile=outfile;

% Run Colley's ranking
stimuli_ranking=colley(T,N);

fid2=fopen([pwd,'/Output/' subjectID '_ItemRankingResults_' timestamp '.txt'], 'a');
fprintf(fid2,'Subject\t StimName\t StimNum\t Rank\t Wins\t Loses\t Total\n');
for j=1:number_of_stimuli
    fprintf(fid2,'%s\t%s\t%d\t%d\t%d\t%d\t%d\n', subjectID, char(IMGnames{j}), j, stimuli_ranking(j), N(j,1), N(j,2), N(j,3));
end
fclose(fid2);

run_info.script_name=mfilename;
clear ('Images','Instructions_image');
save(outfile);

KbQueueFlush;



