function [trialsPerRun] = organizeProbe_Israel(subjectID, order, block, numRunsPerBlock)

% function [trialsPerRun] = organizeProbe_Israel(subjectID, order, pwd, block, numRunsPerBlock)
%
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
% =============== Created based on the previous boost codes ===============
% ==================== by Rotem Botvinik December 2014 ====================
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

% This function organizes the matrices for each block of the probe session of the boost
% (cue-approach) task, divided to number of runs as requested (1 or 2 or 4 would
% work. Pay attention that number of runs should be a divisor of number of
% comparisons.

% This function is for the version where only 40 items are being trained,
% and the sanity checks are only on the NOGO items


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % % --------- Exterior files needed for task to run correctly: ----------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%   'stopGoList_allstim_order*.txt'' --> created by sortBDM_Israel


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % % ------------------- Creates the following files: --------------------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%   'stimuliForProbe_order%d_block_%d_run%d.txt'


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % ------------------- dummy info for testing purposes -------------------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% subjectID =  'test999';
% order = 1;
% test_comp = 4;
% pwd = '/Users/schonberglabimac1/Documents/Boost_Israel_New_Rotem_mac';
% numRunsPerBlock = 1;
% block = 1;


tic

%==============================================
%% 'GLOBAL VARIABLES'
%==============================================

% essential for randomization
rng('shuffle');

%==============================================
%% 'Read in data'
%==============================================

%   'read in sorted file'
% - - - - - - - - - - - - - - - - -
% 
% file = dir([pwd '/Output/' subjectID '_stopGoList_allstim_order*.txt']);
% fid = fopen([pwd '/Output/' sprintf(file(length(file)).name)]);

file = dir([pwd '/Output/*_stopGoList_allstim_order*.txt']);
fid = fopen([pwd '/Output/' sprintf(file(length(file)).name)]);
data = textscan(fid, '%s %d %d %f %d') ;% these contain everything from the sortbdm
stimName = data{1};
% bidIndex = data{3};
% bidValue = data{4};
fclose(fid);

%==============================================
%%   'DATA ORGANIZATION'
%==============================================

% determine stimuli to use based on order number
%-----------------------------------------------------------------
switch order
    case 1
        %   comparisons of interest - High
        % - - - - - - - - - - - - - - -
        HV_90 = [4 9 11];
        HV_50 = [5 7 12];
        HV_10 = [6 8 10];
        
        %   comparisons of interest - Medium
        % - - - - - - - - - - - - - - -
        MV_90 = [28 30 32];
        MV_50 = [26 31 33];
        MV_10 = [27 29 34];
        
        %   comparisons of interest - Low
        % - - - - - - - - - - - - - - -
        LV_90 = [50 52 57];
        LV_50 = [51 53 55];
        LV_10 = [49 54 56];
        
        
    case 2
        
        %   comparisons of interest - High
        % - - - - - - - - - - - - - - -
        HV_90 = [5 7 12];
        HV_50 = [6 8 10];
        HV_10 = [4 9 11];
        
        %   comparisons of interest - Medium
        % - - - - - - - - - - - - - - -
        MV_90 = [26 31 33];
        MV_50 = [27 29 34];
        MV_10 = [28 30 32];
        
        %   comparisons of interest - Low
        % - - - - - - - - - - - - - - -
        LV_90 = [51 53 55];
        LV_50 = [49 54 56];
        LV_10 = [50 52 57];
        
    case 3
        
        %   comparisons of interest - High
        % - - - - - - - - - - - - - - -
        HV_90 = [6 8 10];
        HV_50 = [4 9 11];
        HV_10 = [5 7 12];
        
        %   comparisons of interest - Medium
        % - - - - - - - - - - - - - - -
        MV_90 = [27 29 34];
        MV_50 = [28 30 32];
        MV_10 = [26 31 33];
        
        %   comparisons of interest - Low
        % - - - - - - - - - - - - - - -
        LV_90 = [49 54 56];
        LV_50 = [50 52 57];
        LV_10 = [51 53 55];
        
end % end switch order


%   add multiple iterations of each item presentation
%-----------------------------------------------------


%   TRIAL TYPE 1: HV_90 vs. HV_50
% - - - - - - - - - - - - - - - - - - - - - - - - - - -
numHV_90_Items = length(HV_90); % How many happy Go stimuli
numHV_50_Items = length(HV_50); % How many happy No Go stimuli

HV_90_new = repmat(HV_90,numHV_90_Items,1); % Happy Go as a numHVbeepItems X length(HV_beep) matrix
HV_90_new = HV_90_new(:)';
HV_50_new = repmat(HV_50,1,numHV_50_Items); % Happy No Go as a numHVnobeepItems X length(HV_nobeep) matrix
HV_50_new = HV_50_new(:)';

[shuffle_HV_90_new1,shuff_HV_90_new1_ind] = Shuffle(HV_90_new); % Shuffles each column seperatley and index each column seperatley.
shuffle_HV_50_new1 = HV_50_new(shuff_HV_90_new1_ind); % Creates maching matrix of No Go stimuli.



%   TRIAL TYPE 2: HV_90 vs. HV_10
% - - - - - - - - - - - - - - - - - - - - - - - - - - -
numHV_10_Items = length(HV_10); % How many happy No Go stimuli

HV_10_new = repmat(HV_10,1,numHV_10_Items); % Happy No Go as a numHVnobeepItems X length(HV_nobeep) matrix
HV_10_new = HV_10_new(:)';

[shuffle_HV_90_new2,shuff_HV_90_new2_ind] = Shuffle(HV_90_new); % Shuffles each column seperatley and index each column seperatley.
shuffle_HV_10_new1 = HV_10_new(shuff_HV_90_new2_ind); % Creates maching matrix of No Go stimuli.



%   TRIAL TYPE 3: HV_10 vs. HV_50
% - - - - - - - - - - - - - - - - - - - - - - - - - - -
[shuffle_HV_50_new2,shuff_HV_50_new2_ind] = Shuffle(sort(HV_50_new)); % Shuffles each column seperatley and index each column seperatley.
shuffle_HV_10_new2 = HV_10_new(shuff_HV_50_new2_ind); % Creates maching matrix of No Go stimuli.



%   TRIAL TYPE 4: MV_90 vs. MV_50
% - - - - - - - - - - - - - - - - - - - - - - - - - - -
numMV_90_Items = length(MV_90); % How many happy Go stimuli
numMV_50_Items = length(MV_50); % How many happy No Go stimuli

MV_90_new = repmat(MV_90,numMV_90_Items,1); % Happy Go as a numHVbeepItems X length(HV_beep) matrix
MV_90_new = MV_90_new(:)';
MV_50_new = repmat(MV_50,1,numMV_50_Items); % Happy No Go as a numHVnobeepItems X length(HV_nobeep) matrix
MV_50_new = MV_50_new(:)';

[shuffle_MV_90_new1,shuff_MV_90_new1_ind] = Shuffle(MV_90_new); % Shuffles each column seperatley and index each column seperatley.
shuffle_MV_50_new1 = MV_50_new(shuff_MV_90_new1_ind); % Creates maching matrix of No Go stimuli.



%   TRIAL TYPE 5: MV_90 vs. MV_10
% - - - - - - - - - - - - - - - - - - - - - - - - - - -
numMV_10_Items = length(MV_10); % How many happy No Go stimuli

MV_10_new = repmat(MV_10,1,numMV_10_Items); % Happy No Go as a numHVnobeepItems X length(HV_nobeep) matrix
MV_10_new = MV_10_new(:)';

[shuffle_MV_90_new2,shuff_MV_90_new2_ind] = Shuffle(MV_90_new); % Shuffles each column seperatley and index each column seperatley.
shuffle_MV_10_new1 = MV_10_new(shuff_MV_90_new2_ind); % Creates maching matrix of No Go stimuli.



%   TRIAL TYPE 6: MV_10 vs. MV_50
% - - - - - - - - - - - - - - - - - - - - - - - - - - -
[shuffle_MV_50_new2,shuff_MV_50_new2_ind] = Shuffle(sort(MV_50_new)); % Shuffles each column seperatley and index each column seperatley.
shuffle_MV_10_new2 = MV_10_new(shuff_MV_50_new2_ind); % Creates maching matrix of No Go stimuli.


%   TRIAL TYPE 7: LV_90 vs. LV_50
% - - - - - - - - - - - - - - - - - - - - - - - - - - -
numLV_90_Items = length(LV_90); % How many happy Go stimuli
numLV_50_Items = length(LV_50); % How many happy No Go stimuli

LV_90_new = repmat(LV_90,numLV_90_Items,1); % Happy Go as a numHVbeepItems X length(HV_beep) matrix
LV_90_new = LV_90_new(:)';
LV_50_new = repmat(LV_50,1,numLV_50_Items); % Happy No Go as a numHVnobeepItems X length(HV_nobeep) matrix
LV_50_new = LV_50_new(:)';

[shuffle_LV_90_new1,shuff_LV_90_new1_ind] = Shuffle(LV_90_new); % Shuffles each column seperatley and index each column seperatley.
shuffle_LV_50_new1 = LV_50_new(shuff_LV_90_new1_ind); % Creates maching matrix of No Go stimuli.



%   TRIAL TYPE 8: LV_90 vs. LV_10
% - - - - - - - - - - - - - - - - - - - - - - - - - - -
numLV_10_Items = length(LV_10); % How many happy No Go stimuli

LV_10_new = repmat(LV_10,1,numLV_10_Items); % Happy No Go as a numHVnobeepItems X length(HV_nobeep) matrix
LV_10_new = LV_10_new(:)';

[shuffle_LV_90_new2,shuff_LV_90_new2_ind] = Shuffle(LV_90_new); % Shuffles each column seperatley and index each column seperatley.
shuffle_LV_10_new1 = LV_10_new(shuff_LV_90_new2_ind); % Creates maching matrix of No Go stimuli.



%   TRIAL TYPE 9: LV_10 vs. LV_50
% - - - - - - - - - - - - - - - - - - - - - - - - - - -
[shuffle_LV_50_new2,shuff_LV_50_new2_ind] = Shuffle(sort(LV_50_new)); % Shuffles each column seperatley and index each column seperatley.
shuffle_LV_10_new2 = LV_10_new(shuff_LV_50_new2_ind); % Creates maching matrix of No Go stimuli.



%   randomize all possible comparisons for all trial types
%-----------------------------------------------------------------
numComparisonsHV = (numHV_90_Items^2)*3; % How many High comparisons
numComparisonsMV = (numMV_90_Items^2)*3; % How many Medium comparisons
numComparisonsLV = (numLV_90_Items^2)*3; % How many Low comparisons



effort_levels=3;
value_levels=3;
numComparisonsTYPS=effort_levels*value_levels;
total_num_trials = numComparisonsHV + numComparisonsLV + numComparisonsMV; % How many Happy / neutral Go-No Go
trialsPerRun = total_num_trials/numRunsPerBlock; % Trials per run
    
stimnum1 = zeros(numRunsPerBlock,trialsPerRun); % for us - 3X27 zeros (pairs)
stimnum2 = zeros(numRunsPerBlock,trialsPerRun);
leftname = cell(numRunsPerBlock,trialsPerRun);
rightname = cell(numRunsPerBlock,trialsPerRun);
pairType = zeros(numRunsPerBlock,trialsPerRun);


numComparisonsPerRun = total_num_trials/numRunsPerBlock; % number of non-Sanity non-FakeGo comparisons per run
%trials_indexing = numHV_90_Items:numRunsPerBlock:trialsPerRun ;

% pairType(1:numRunsPerBlock,1:trials_indexing(1)) = 1; % pairs 1:3
% pairType(1:numRunsPerBlock,trials_indexing(1)+1:trials_indexing(2)) = 2; % pairs 4:6
% pairType(1:numRunsPerBlock,trials_indexing(2)+1:trials_indexing(3)) = 3; % pairs 7:9
% pairType(1:numRunsPerBlock,trials_indexing(3)+1:trials_indexing(4)) = 4; % pairs 10;12
% pairType(1:numRunsPerBlock,trials_indexing(4)+1:trials_indexing(5)) = 5; % pairs 13:15
% pairType(1:numRunsPerBlock,trials_indexing(5)+1:trials_indexing(6)) = 6; % pairs 16:18
% pairType(1:numRunsPerBlock,trials_indexing(6)+1:trials_indexing(7)) = 7; % pairs 19:21
% pairType(1:numRunsPerBlock,trials_indexing(7)+1:trials_indexing(8)) = 8; % pairs 22:24
% pairType(1:numRunsPerBlock,trials_indexing(8)+1:trials_indexing(9)) = 9; % pairs 25:27

% vector of (number of items group 1*number of items group 2)*numComparisonsTYPS
% = in case of one run of 81 trials: 9 ones, 9 twos..... 
for looper=1:numComparisonsTYPS
pairType(1:numRunsPerBlock,((looper*numComparisonsTYPS)-(numComparisonsTYPS-1)):looper*numComparisonsTYPS) = looper;
end    
    




leftGo = ones(numRunsPerBlock,total_num_trials/numRunsPerBlock);
leftGo(:,1:(numComparisonsPerRun+1)/2) = 0;
%leftGo(:,[1:numComparisonsPerRun/4 numComparisonsPerRun/2+1:numComparisonsPerRun*3/4 1+numComparisonsPerRun:numComparisonsPerRun+numSanityPerRun/2 numComparisonsPerRun+numSanityPerRun+1:numComparisonsPerRun+numSanityPerRun+numFakePerRun/2]) = 0;


for numRun = 1:numRunsPerBlock
    pairType(numRun,:) = Shuffle(pairType(numRun,:));
    leftGo(numRun,:) = Shuffle(leftGo(numRun,:));
end % end for numRun = 1:numRunsPerBlock

% HV_beep = shuffle_HV_beep_new;
% HV_nobeep = shuffle_HV_nobeep_new;
%
% LV_beep = shuffle_LV_beep_new;
% LV_nobeep = shuffle_LV_nobeep_new;


% % Divide the matrices of each comparison to the number of trials
% HV_beep_allRuns = reshape(HV_beep,2,length(HV_beep)/2);
% HV_nobeep_allRuns = reshape(HV_nobeep,2,length(HV_nobeep)/2);
% LV_beep_allRuns = reshape(LV_beep,2,length(LV_beep)/2);
% LV_nobeep_allRuns = reshape(LV_nobeep,2,length(LV_nobeep)/2);
% sanityHV_nobeep_allRuns = reshape(sanityHV_nobeep,2,length(sanityHV_nobeep)/2);
% sanityLV_nobeep_allRuns = reshape(sanityLV_nobeep,2,length(sanityLV_nobeep)/2);

H_90_50 = 1;
H_90_10 = 1;
H_10_50 = 1;

M_90_50 = 1;
M_90_10 = 1;
M_10_50 = 1;

L_90_50 = 1;
L_90_10 = 1;
L_10_50 = 1;

for numRun = 1:numRunsPerBlock
    
    % Create stimuliForProbe.txt for this run
    fid1 = fopen(['./Output/' sprintf('%s_stimuliForProbe_order%d_block_%d_run%d.txt',subjectID,order,block,numRun)], 'w');
    
    for trial = 1:trialsPerRun % trial num within block
        switch pairType(numRun,trial)
            case 1
                
                % High_90 vs. High_50
                % - - - - - - - - - - - - - - - - - - -
                
                stimnum1(numRun,trial) = shuffle_HV_90_new1(H_90_50);
                stimnum2(numRun,trial) = shuffle_HV_50_new1(H_90_50);
                H_90_50 = H_90_50+1;
                if leftGo(numRun,trial) == 1
                    leftname(numRun,trial) = stimName(stimnum1(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum2(numRun,trial));
                else
                    leftname(numRun,trial) = stimName(stimnum2(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum1(numRun,trial));
                end
                
            case 2
                
                % High_90 vs. High_10
                % - - - - - - - - - - - - - - - - - - -
                
                stimnum1(numRun,trial) = shuffle_HV_10_new1(H_90_10);
                stimnum2(numRun,trial) = shuffle_HV_90_new2(H_90_10);
                H_90_10 = H_90_10+1;
                if leftGo(numRun,trial) == 1
                    leftname(numRun,trial) = stimName(stimnum1(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum2(numRun,trial));
                else
                    leftname(numRun,trial) = stimName(stimnum2(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum1(numRun,trial));
                end
                
            case 3
                
                % High_50 vs. High_10
                % - - - - - - - - - - - - - - - - - - -
                
                stimnum1(numRun,trial) = shuffle_HV_50_new2(H_10_50);
                stimnum2(numRun,trial) = shuffle_HV_10_new2(H_10_50);
                H_10_50 = H_10_50+1;
                if leftGo(numRun,trial) == 1
                    leftname(numRun,trial) = stimName(stimnum1(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum2(numRun,trial));
                else
                    leftname(numRun,trial) = stimName(stimnum2(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum1(numRun,trial));
                end
                
            case 4
                
                % Medium_90 vs. Medium_50
                % - - - - - - - - - - - - - - - - - - -
                
                stimnum1(numRun,trial) = shuffle_MV_90_new1(M_90_50);
                stimnum2(numRun,trial) = shuffle_MV_50_new1(M_90_50);
                M_90_50 = M_90_50+1;
                if leftGo(numRun,trial) == 1
                    leftname(numRun,trial) = stimName(stimnum1(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum2(numRun,trial));
                else
                    leftname(numRun,trial) = stimName(stimnum2(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum1(numRun,trial));
                end
                
            case 5
                
                % Medium_90 vs. Medium_10
                % - - - - - - - - - - - - - - - - - - -
                
                stimnum1(numRun,trial) = shuffle_MV_10_new1(M_90_10);
                stimnum2(numRun,trial) = shuffle_MV_90_new2(M_90_10);
                M_90_10 = M_90_10+1;
                if leftGo(numRun,trial) == 1
                    leftname(numRun,trial) = stimName(stimnum1(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum2(numRun,trial));
                else
                    leftname(numRun,trial) = stimName(stimnum2(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum1(numRun,trial));
                end
                
            case 6
                
                % Medium_50 vs. Medium_10
                % - - - - - - - - - - - - - - - - - - -
                
                stimnum1(numRun,trial) = shuffle_MV_50_new2(M_10_50);
                stimnum2(numRun,trial) = shuffle_MV_10_new2(M_10_50);
                M_10_50 = M_10_50+1;
                if leftGo(numRun,trial) == 1
                    leftname(numRun,trial) = stimName(stimnum1(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum2(numRun,trial));
                else
                    leftname(numRun,trial) = stimName(stimnum2(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum1(numRun,trial));
                end
                
            case 7
                
                % Low_90 vs. Low_50
                % - - - - - - - - - - - - - - - - - - -
                
                stimnum1(numRun,trial) = shuffle_LV_90_new1(L_90_50);
                stimnum2(numRun,trial) = shuffle_LV_50_new1(L_90_50);
                L_90_50 = L_90_50+1;
                if leftGo(numRun,trial) == 1
                    leftname(numRun,trial) = stimName(stimnum1(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum2(numRun,trial));
                else
                    leftname(numRun,trial) = stimName(stimnum2(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum1(numRun,trial));
                end
                
            case 8
                
                % Low_90 vs. Low_10
                % - - - - - - - - - - - - - - - - - - -
                
                stimnum1(numRun,trial) = shuffle_LV_10_new1(L_90_10);
                stimnum2(numRun,trial) = shuffle_LV_90_new2(L_90_10);
                L_90_10 = L_90_10+1;
                if leftGo(numRun,trial) == 1
                    leftname(numRun,trial) = stimName(stimnum1(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum2(numRun,trial));
                else
                    leftname(numRun,trial) = stimName(stimnum2(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum1(numRun,trial));
                end
                
            case 9
                
                % Low_50 vs. Low_10
                % - - - - - - - - - - - - - - - - - - -
                
                stimnum1(numRun,trial) = shuffle_LV_50_new2(L_10_50);
                stimnum2(numRun,trial) = shuffle_LV_10_new2(L_10_50);
                L_10_50 = L_10_50+1;
                if leftGo(numRun,trial) == 1
                    leftname(numRun,trial) = stimName(stimnum1(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum2(numRun,trial));
                else
                    leftname(numRun,trial) = stimName(stimnum2(numRun,trial));
                    rightname(numRun,trial) = stimName(stimnum1(numRun,trial));
                end
                
        end % end switch pairtype
        
        fprintf(fid1, '%d\t%d\t%d\t%d\t%s\t%s\t\n', stimnum1(numRun,trial),stimnum2(numRun,trial),leftGo(numRun,trial),pairType(numRun,trial),leftname{numRun,trial},rightname{numRun,trial});
    end % end for trial = 1:total_num_trials
    
    fprintf(fid1, '\n');
    fclose(fid1);
end % end for numRun = 1:numRunsPerBlocks


%---------------------------------------------------------------------
% create a data structure with info about the run and all the matrices
%---------------------------------------------------------------------
outfile = strcat('./Output/', sprintf('%s_stimuliForProbe_order%d_block_%d_%d_trials_%d_runs_%s.mat',subjectID,order,block,total_num_trials,numRunsPerBlock,date));

% create a data structure with info about the run
run_info.subject = subjectID;
run_info.date = date;
run_info.outfile = outfile;
run_info.script_name = mfilename;

save(outfile);


end % end functio

