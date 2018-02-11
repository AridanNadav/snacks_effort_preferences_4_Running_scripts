% function disp_probeResolve(subjectID, sessionNum, outputPath,numRunsPerBlock)
% function disp_probeResolve(subjectID, sessionNum, outputPath, numBlocks)

% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
% == Created based on the previous boost codes and Nadav's modifications ==
% ================== by Rotem Botvinik Nezer march 2016 ===================
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

% This function chooses one of the two probe sessions (normal or reversed).
% then, it chooses a random trial from the chosen probe and computes the item
% the participant chose (or did not choose if it is the recersed probe) on that trial. This is the item the experimenter
% should give to the participant.

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % % --------- Exterior files needed for task to run correctly: ----------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%   ''probe_block_' block '_*.txt'' --> created in the probe session


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % % ------------------- Creates the following files: --------------------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%   ''probe_resolve_session_' num2str(sessionNum) '.txt''


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % ------------------- dummy info for testing purposes -------------------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% subjectID = 'Brev_snacks_999';
% sessionNum = 1;
% order = 1;
% mainPath = pwd;
% outputPath = [mainPath '/Output'];

rng shuffle


% Define block number
% whichBlock = Shuffle(1:numBlocks);
% if sessionNum == 1
%     block = whichBlock(1);
% elseif sessionNum == 2
%     block = 2 + whichBlock(1);
% elseif sessionNum == 3
%     block = 4 + whichBlock(1);
% end

% define which probe
whichProbe = Shuffle(1:numRunsPerBlock);
whichProbe = whichProbe(1);

tmp = dir([outputPath '/' subjectID '_probe_block_01_run_0' sprintf('%d',whichProbe) '_*.txt']);   
fid = fopen([outputPath '/' tmp(length(tmp)).name]); %tmp(length(tmp)).name
probe = textscan(fid, '%s %d %d %d %d %d %d %s %s %d %d %d %s %d %d %.2f %d %d', 'Headerlines',1);
fclose(fid);
total_num_trials = length(probe{1});

% Choose a random trial
%trial_choice = ceil(rand*total_num_trials);
trial_choice = Shuffle(1:total_num_trials);
trial_choice = trial_choice(1);

% Check which items were presented and which one of them was selected
option1 = probe{8}(trial_choice);
option1 = option1{1}(1:end-4);
option2 = probe{9}(trial_choice);
option2 = option2{1}(1:end-4);
if strcmp(probe{13}(trial_choice),'u')
    chosenItem = option1;
    notChosenItem = option2;
    
else
    notChosenItem = option1;
    chosenItem = option2;
end

% load images
stimuli=dir([pwd '/stim/*.bmp' ]);
stimname=struct2cell(rmfield(stimuli,{'date','bytes','isdir','datenum'}));
Images=cell(length(stimname),1);
for i=1:length(stimname)
    Images{i}=imread([ pwd '/stim/' stimname{i}]);
end
total_num_items = length(Images);

% save results of probeResolve_Israel
fid2 = fopen([outputPath '/' subjectID '_probe_resolve_session_' num2str(1) '.txt'],'a');
fprintf(fid2,'In the choice between %s and %s, you chose to get %s. You recieve this item.\n', option1, option2, chosenItem);    
fclose(fid2);

BackColor = 0; % Black back color
TextColor = 255; % White Text color

% open screen
% keepTrying = 1;
% PresentScreen = max(Screen('Screens'));
% while keepTrying < 10
%     try
%         Screen('Preference', 'SkipSyncTests', 2)
% 
%         Window = Screen('OpenWindow', PresentScreen ,BackColor); % Opens the screen with the chosen backcolor
%         Screen ('fillRect',Window,BackColor);
%         Screen ('flip',Window);
%         Screen('TextSize',Window,28);
%         Screen('TextFont',Window,'Arial');
%         keepTrying = 10;
%     catch
%         sca;
%         keepTrying = keepTrying + 1;
%         disp('CODE HAD CRASHED - cant open screen!');
%     end
% end


[wWidth, wHeight] = Screen('WindowSize', Window);
xcenter = wWidth/2;
ycenter = wHeight/2;

stackW = 576;
stackH = 432;

leftRect = [xcenter-stackW/2-150 ycenter/1.5-stackH/4 xcenter-150 ycenter/1.5+stackH/4];
rightRect = [xcenter+150 ycenter/1.5-stackH/4 xcenter+stackW/2+150 ycenter/1.5+stackH/4];
chosenRect = [xcenter-stackW/2 ycenter+100 xcenter+stackW/2 ycenter+100+stackH];

option1_image = imread([ pwd '/stim/' option1 '.bmp']);
option2_image = imread([ pwd '/stim/' option2 '.bmp']);
chosenItem_image = imread([ pwd '/stim/' chosenItem '.bmp']);
notChosenItem_image = imread([ pwd '/stim/' notChosenItem '.bmp']);




taim= GetSecs;
while (GetSecs - taim) <= 2,
    randomOrder = Shuffle(1:total_num_items);
    item_ind1 = randomOrder(1);
        item_ind2 = randomOrder(2);

    % show the snack chosen
DrawFormattedText(Window,'In the choice between these two options:','center',100,TextColor);
    
Screen('PutImage',Window,Images{item_ind1}, leftRect);
Screen('PutImage',Window,Images{item_ind2}, rightRect);

    
%     Screen('PutImage',Window, Images{item_ind} );
    %  "your bid was:"
     
    Screen('Flip',Window);
    WaitSecs(0.025)
end;

Screen('Flip',Window);


DrawFormattedText(Window,'In the choice between these two options:','center',100,TextColor);
Screen('PutImage',Window,option1_image, leftRect);
Screen('PutImage',Window,option2_image, rightRect);

Screen(Window,'Flip');
WaitSecs(2);


Screen('PutImage',Window,option1_image, leftRect);
Screen('PutImage',Window,option2_image, rightRect);


DrawFormattedText(Window,'You chose to get:','center',ycenter+50,TextColor);
DrawFormattedText(Window,'In the choice between these two options:','center',100,TextColor);

Screen(Window,'Flip');
WaitSecs(1);


DrawFormattedText(Window,'You chose to get:','center',ycenter+50,TextColor);
DrawFormattedText(Window,'In the choice between these two options:','center',100,TextColor);


Screen('PutImage',Window,option1_image, leftRect);
Screen('PutImage',Window,option2_image, rightRect);
Screen('PutImage',Window,chosenItem_image,chosenRect);
Screen(Window,'Flip');
WaitSecs(4);

%%
% % instruct: "the snack you will win is"
% DrawFormattedText(Window,'the snack you will win is:','center',150,TextColor);
% % Screen('PutImage',Window,instrct_snack);
% Screen(Window,'Flip');
% 
% WaitSecs(2);
% %% Choose a random item
% 
% % instruct: "the snack you will win is"
% DrawFormattedText(Window,'the snack you will win is:','center',150,TextColor);
% % Screen('PutImage',Window,instrct_snack);
% 
% 
% 
% %%
% 
% % instruct: "the snack you will win is"
% DrawFormattedText(Window,'the snack you will win is:','center',150,TextColor);
% % Screen('PutImage',Window,instrct_snack);
% 
% % show the snack chosen
% Screen('PutImage',Window,chosenItem_image);
DrawFormattedText(Window,'Thank you and goodbye :) ','center',980,TextColor);
Screen(Window,'Flip');
WaitSecs(2);

% noresp=1;
% while noresp,
%     [keyIsDown,~,~] = KbCheck;
%     if keyIsDown && noresp,
%         noresp=0;
%     end;
% end;
Screen('CloseAll');
ShowCursor;

% end % end function    