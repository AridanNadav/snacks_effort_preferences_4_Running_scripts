%function [] = sort_BDM_Israel(subjectID,order,outputPath)

% function [] = sort_BDM_Israel(subjectID,order,outputPath)

% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
% =============== Created based on the previous boost codes ===============
% ==================== by Rotem Botvinik April 2015 ====================
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

% This function sorts the stimuli according to the BDM results.
% This function is a version in which only the 40 of the items are included
% in the training


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % % --------- Exterior files needed for task to run correctly: ----------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%   [pwd '\Output\' subjectID '_BDM1.txt']


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % % ------------------- Creates the following files: --------------------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%   'stopGoList_allstim_order%d.txt', order
%   'stopGoList_trainingstim.txt' ---> The file for training 40 items


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % ------------------- dummy info for testing purposes -------------------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% order = 1;
% outputPath = '/Users/schonberglabimac1/Documents/BMI_bs_high/Output'; % On the
% lab's mac
% outputPath = 'D:\Rotem\Dropbox\Rotem\BMI_bs_high_052015\BMI_BS_high\Output' on
% Rotem's PC
% subjectID = 'test999';
% order = 2;

tic

%=========================================================================
%%  read in info from BDM1.txt
%=========================================================================
if BDM==1
    fid = fopen([outputPath '/' subjectID '_BDM1.txt']);
    BDM1_data = textscan(fid, '%d%s%f%d' , 'HeaderLines', 1); %read in data as new matrix
    fclose(fid);
else
    fid = fopen([pwd '/BDM_demo.txt']);
    BDM1_data = textscan(fid, '%d%s%f%d' , 'HeaderLines', 1); %read in data as new matrix
    fclose(fid);
end

%=========================================================================
%%  Create matrix sorted by descending bid value
%========================================================================

[bids_sort,trialnum_sort_bybid] = sort(BDM1_data{3},'descend');

bid_sortedM(:,1) = trialnum_sort_bybid; % trial nums organized by descending bid amt
bid_sortedM(:,2) = bids_sort; % bids sorted large to small
bid_sortedM(:,3) = 1:1:60; % stimrank

stimnames_sorted_by_bid = BDM1_data{2}(trialnum_sort_bybid);


%=========================================================================
%%   The ranking of the stimuli determine the stimtype
%=========================================================================

if order == 1
    
    bid_sortedM([     4 9 11 28 30 32 50 52 57    ], 4) = 3; %A
    bid_sortedM([     5 7 12 26 31 33 51 53 55    ], 4) = 2; %B
    bid_sortedM([     6 8 10 27 29 34 49 54 56    ], 4) = 1; %C
    bid_sortedM([  1:3   13:25   35:48    58:60   ], 4) = 99; %Not trained
    
elseif order == 2
    
    bid_sortedM([     4 9 11 28 30 32 50 52 57    ], 4) = 1; %A
    bid_sortedM([     5 7 12 26 31 33 51 53 55    ], 4) = 3; %B
    bid_sortedM([     6 8 10 27 29 34 49 54 56    ], 4) = 2; %C
    bid_sortedM([  1:3   13:25   35:48    58:60   ], 4) = 99; %Not trained
    
elseif order == 3
    
    bid_sortedM([     4 9 11 28 30 32 50 52 57    ], 4) = 2; %A
    bid_sortedM([     5 7 12 26 31 33 51 53 55    ], 4) = 1; %B
    bid_sortedM([     6 8 10 27 29 34 49 54 56    ], 4) = 3; %C
    bid_sortedM([  1:3   13:25   35:48    58:60   ], 4) = 99; %Not trained
    
end % end if order == 1

itemsForTraining = bid_sortedM([4:12 26:34 49:57],:);
itemsNamesForTraining = stimnames_sorted_by_bid([4:12 26:34 49:57]);

%=========================================================================
%%  create stopGoList_allstim.txt
%   this file is used during probe
%=========================================================================

fid2 = fopen([outputPath '/' subjectID sprintf('_stopGoList_allstim_order%d.txt', order)], 'w');

for i = 1:length(bid_sortedM)
    fprintf(fid2, '%s\t%d\t%d\t%d\t%d\t\n', stimnames_sorted_by_bid{i,1},bid_sortedM(i,4),bid_sortedM(i,3),bid_sortedM(i,2),bid_sortedM(i,1));
end
fprintf(fid2, '\n');
fclose(fid2);

fid3 = fopen([outputPath '/' subjectID '_stopGoList_trainingstim.txt'], 'w');

for i = 1:length(itemsForTraining)
    fprintf(fid3, '%s\t%d\t%d\t%d\t%d\t\n', itemsNamesForTraining{i,1},itemsForTraining(i,4),itemsForTraining(i,3),itemsForTraining(i,2),itemsForTraining(i,1));
end
fprintf(fid3, '\n');
fclose(fid3);

%end % end function