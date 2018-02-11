%function [] = sort_binary_ranking(subjectID,order,outputPath)
% function [] = sort_BDM_Israel(subjectID,order,outputPath)

% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
% =============== Created based on the previous boost codes ===============
% ==================== by Rotem Botvinik November 2014 ====================
% ================= Modified by Tom Salomon, January 2015 =================
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

% This function sorts the stimuli according to the Binary ranking results

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % % --------- Exterior files needed for task to run correctly: ----------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%   [subjectID,'_ItemRankingResults*']


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % % ------------------- Creates the following files: --------------------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%   'stopGoList_allstim_order%d.txt', order
%   'stopGoList_trainingstim.txt'
%   'order_testcomp.txt'

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % ------------------- dummy info for testing purposes -------------------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% subjectID = 'BM_9001';
% order = 1;
% outputPath = 'D:/Rotem/Matlab/Boost_Israel_New_Rotem/Output'; % On Rotem's PC 


%=========================================================================
%%  read in info from BDM1.txt
%=========================================================================

subj_rank_file=dir(fullfile(outputPath,[subjectID,'_ItemRankingResults*']));
lastname=length(subj_rank_file);
fid=fopen(fullfile(outputPath,subj_rank_file(lastname).name));
BDM1_data=textscan(fid, '%s %s %f %f %f %f %f', 'HeaderLines', 1); %read in cdata as new matrix   
fclose(fid);

%=========================================================================
%%  Create matrix sorted by descending bid value
%========================================================================

[bids_sort,trialnum_sort_bybid]=sort(BDM1_data{4},'descend');
% [bids_sort,trialnum_sort_bybid]=sort(BDM1_data{3},'descend');

bid_sortedM(:,1)=trialnum_sort_bybid; %trialnums organized by descending bid amt
bid_sortedM(:,2)=bids_sort; %bids sorted large to small
bid_sortedM(:,3)=1:1:70; %stimrank

stimnames_sorted_by_bid=BDM1_data{2}(trialnum_sort_bybid);

%=========================================================================
%%   The ranking of the stimuli determine the stimtype
%=========================================================================
%Each X and X+5 will be a different effort level (1+6 the esiest and 5+10
%the hardest). 1-5 will be cued and 6-10 will be uncued.
effort_design = randperm(10);
if order == 1
    bid_sortedM([     6,7,64,65     ], 4) = effort_design(1); % HV_beep_effort,  10 11 13 16 18
    bid_sortedM([     8,9,62,63     ], 4) = effort_design(2); % HV_beep_noeffort  5 8 19 21 24
    bid_sortedM([     10,11,60,61   ], 4) = effort_design(3); % HV_nobeep_effort  12 14 15 17 20
    bid_sortedM([     12,13,58,59   ], 4) = effort_design(4); % HV_nobeep_noeffort 3:4       6 7 9 22 23
    bid_sortedM([     14,15,56,57   ], 4) = effort_design(5); % LV_beep 
    bid_sortedM([     16,17,54,55   ], 4) = effort_design(6); % LV_nobeep  37:58
    bid_sortedM([     18,19,52,53   ], 4) = effort_design(7);
    bid_sortedM([     20,21,50,51   ], 4) = effort_design(8);
    bid_sortedM([     22,23,48,49   ], 4) = effort_design(9);
    bid_sortedM([     24,25,46,47   ], 4) = effort_design(10);
    bid_sortedM([     26:45         ], 4) = 33; %No-Go No-Effort
    bid_sortedM([     3:5, 66:68    ], 4) = 30; %Sanity check 
    bid_sortedM([     1:2, 69:70    ], 4) = 99; % notTrained 1:2        25:36       59:60
%{
else 
    bid_sortedM([          12 14 15 17 20      ], 4) = 11; % HV_beep_effort
    bid_sortedM([           6 7 9 22 23        ], 4) = 12; % HV_beep_noeffort
    bid_sortedM([          10 11 13 16 18      ], 4) = 13; % HV_nobeep_effort
    bid_sortedM([ 3:4       5 8 19 21 24       ], 4) = 14; % HV_nobeep_noeffort
    bid_sortedM([                              ], 4) = 22; % LV_beep 
    bid_sortedM([              37:58           ], 4) = 24; % LV_nobeep
    bid_sortedM([ 1:2          25:36     59:60 ], 4) = 0; % notTrained
    %}
end % end if order == 1

itemsForTraining = bid_sortedM(3:68,:);
itemsNamesForTraining = stimnames_sorted_by_bid(3:68);

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

