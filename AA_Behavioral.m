 % AA_Behavioral
 
%function  AA_EVA4_preScan

% =========  by Nadav Aridan  Nov 2016 =============
% 
%  oooooooooooo oooooo     oooo   .o.               .o     
%  `888'     `8  `888.     .8'   .888.            .d88    
%   888           `888.   .8'   .8"888.         .d'888     
%   888oooo8       `888. .8'   .8' `888.      .d'  888      
%   888    "        `888.8'   .88ooo8888.     88ooo888oo 
%   888       o      `888'   .8'     `888.         888     
%  o888ooooood8       `8'   o88o     o8888o       o888o    
%


  
%                     @@@@@@@@@                              
%                    @@@@@@@@@@@@                            
%                   @@@@@@@@@@@@%  @@@@@                     
%                 #@@@@@@@@@@@@  @@@@@@@@@@                  
%                &@@@@@@@@@@@@  @@@@@@@@@@@@@                
%            @@@@#    @@@@@@@  @@@@@@@@@@@@@@                
%           @@@@@@@@@@    @@  @@@@@@@@@@@@@@  @@@            
%          @@@@@@@@@@@@@@@    @@@@@@@@@@@@%  @@@@@@&         
%        @@@@@@@@@@@@@@@@@@@@@    @@@@@@@  @@@@@@@@@@&       
%       @@@@@@@@@@@@@@@@@@@@@@@@@@  @@@@  @@@@@@@@@@@@@      
%      @@@@@@@@@@@@@@@@@@@@@@@@@@@  @@   @@@@@@@@@@@@@@      
%    (@@@@@@@@@@@@@@@@@@@@@@@@@@@   @  @@@@@@@@@@@@@@  @@    
%   @@@@@@@@@@@@@@@@  @@@@@@@@@    @  @@@@@@@@@@@@@  *@@@@@  
%  @@@@@@@@@@@@@@@@                 @@@@@@@@@@@@@   @@@@@@@@ 
% @@@@@@@@@@@@@@@@                 @@@@@@@@@@@@@  @@@@@@@@@@@
% @@@@@@@@@@@@@@@@@@                @@@@@@@@@@  @@@@@@@@@@@@ 
%  @@@@@@@@@@@@@@@@@@@@@              (@@@@@  @@@@@@@@@@@@   
%   @@@@@@@@@@@@@@@@@@@@@@               @  @@@@@@@@@@@@  @  
%    .@@@@@@@@@@@@@@@@@@@@@@               @@@@@@@@@@@  @@@  
%      @@@@@@@@@@@@@@@@@@@@@@@               @@@@@@   #@@@@  
%       @@@@@@@@@@@@@@@@@@@@@@@        @       @@   ,@@@@@   
%         @@@@@@@@@@@@@@@@@@@@@@       @@@@&       @@@@@@@   
%          @@@@@@@@@@@@@@@@@@@@@@     ,@@@@@@@@  @@@@@@@@    
%           ,@@@@@@@@@@@@@@@@@@@@@    @@@@@@@@@@@@@@@@@@     
%             @@@@@@@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@      
%              @@@@@@@@@@@@@@@@@@@@# @@@@@@@@@@@@@@@@@       
%                @@@@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@        
%                 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         
%                  /@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          
%                   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@           
%                   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@            
%                  @@@@@@@@@@@@@&       @@@@@@@@@            
%                  @@@@@@@@@@@@@@@   @@@@@@@@@@@@            
%                  @@@@@@@@@@@@@@@   @@@@@@@@@@@@            
%                 @@@@@@@@@@@@@@@@  #@@@@@@@@@@@@            
%                 @@@@@@@@@@@@@@@@% @@@@@@@@@@@@@            
%                 @@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@            
%                #@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@            
%                @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            
%                @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   

                                                                                                                
% Runs WTP and effort association to SNACKS images

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % % ---------------- order of run: ----------------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% general INSTRUCTIONS
% BDM1 (demo+full)
% Binary Ranking 1st (demo)
% Binary Ranking 1st (full)
% Dynamometer calibration
% Effort-item demo
% effort
% effort
% effort
% vas
% effort
% effort
% effort
% vas
% (break)fractals bdm
% Probe 
% Probe 
% BDM 2
% Binary Ranking 2nd
% Recognition perceived effort - VAS
% "Resolve BDM 
% Resolve probe"

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % % ---------------- SCRIPTS REQUIRED TO RUN PROPERLY: ----------------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%{
AA_Behavioral.m    
AA_Screen_Set_n_Open.m                        
BB_probe.m                                 
BB_training.m                              
BB_VAS.m                                   
BB_VAS_noJitter.m                          
BDM_demo_and_1stBDM.m                      
binary_ranking.m                           
binary_ranking_2.m                         
binary_ranking_demo.m                      
BRallCOMB.m                                
CenterText.m                               
colley.m                                   
disp_probeResolve.m                        
disp_resolveBDM_mac.m                      
dyno_check.m                               
effort_levels_randomizer.m                 
effort_levels_setup.m                      
Grip_Practice_Demo.m                       
load_instruction_images.m                  
load_stim_for_practice.m                   
matchkey2num.m                             
MRI_Grip_Calibration.m                     
organizeProbe_Israel.m                     
pre_run_settings_and_personal_details.m    
probe_Israel.m                             
probeDemo_Israel.m                         
ProbeResolve.m                             
random_stimlist_generator.m                
remove_probe_from_BR2.m                    
run_BR1.m                                  
run_BR2.m                                  
run_break.m                                
setting_stimuli.m                          
Shuffle.m                                  
sort_BDM_Israel.m                          
sort_binary_ranking.m                      
TIMEstamp.m                                
vas_Demo.m                                 
wait4key.m 
%}

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % % ---------------- FOLDERS REQUIRED TO RUN PROPERLY: ------------------
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%   'Onset_files': a folder with the onset files for the probe.
%   'Output': the folder for the output files- results.
%   'stim': with the image files of all the stimuli for the cue-approach
%   'Instructions'
%    fractals

%% =========================================================================
% Pre run settings and personal details
% =========================================================================
%
experimentStart=GetSecs;

pre_run_settings_and_personal_details

%% =========================================================================
% BDM demo & 1st BDM
% =========================================================================
BDM_demo_and_1stBDM
sort_BDM_Israel
save ([pwd '/Output/' subjectID '_BDM1'])


%% open screen 

AA_Screen_Set_n_Open

%% introduction instruction
callexp
Screen('PutImage',Window,instrct_introduction);
Screen(Window,'Flip');
WaitSecs(2);
wait4key % wait for any key press to continue


%% =========================================================================
% BR1 (including demo)= creats a another ranking of the images
%  =========================================================================

setting_stimuli

save ([pwd '/Output/' subjectID '_AA_EVA4_preBR'])

run_BR1

save ([pwd '/Output/' subjectID '_AA_EVA4_preScan_exp_parameters'])


%% pre training


effort_levels_setup;

load_stim_for_practice

load([pwd '/Onset_files/onsets.mat'])

%%
callexp

runNUM=1;
   
%--------------------------------------------------------------
% grip calibration- get subject's MVC by avarege of 3 sqeezes

MRI_Grip_Calibration
%--------------------------------------------------------------

% grip practice DEMO - associate images and effort levels
Grip_Practice_Demo
%--------------------------------------------------------------

eye_tracker_setup

BB_training

runNUM=2;
BB_training

runNUM=3;
BB_training

%%
callexp

runNUM=1;
BB_VAS
%%
runNUM=4;
BB_training

runNUM=5;
BB_training

runNUM=6;
BB_training
%%
runNUM=2;
BB_VAS
%%
callexp
run_break
%%
eye_tracker_setup

runNUM=1;
BB_probe 

runNUM=2;
BB_probe 

eye_tracker_wrapup


%% ==========================================================
%  BDM2
%==========================================================
callexp
Screen('PutImage',Window,instrct_BDM2);
Screen(Window,'Flip');
wait4key % wait for any key press to continue

sca
BDM2_start = GetSecs;
system(['/usr/local/bin/python2.7 ',pwd,'/BDM2.py ' subjectID]);
AllrunsDur.BDM2=GetSecs-BDM2_start;


%==========================================================
%%   BR2
%==========================================================
AA_Screen_Set_n_Open
BR2_start=GetSecs;
binary_ranking_2
AllrunsDur.BR2=GetSecs-BR2_start;

%==========================================================
%%  VAS recognition
%==========================================================
callexp
Screen('PutImage',Window,instrct_vasRECOG);
Screen(Window,'Flip');
wait4key % wait for any key press to continue

runNUM=3;
BB_VAS_noJitter
%% resolveBDM
% questdlg('Click ''Continue'' to start the shuffle  ','start shuffle','Continue','Continue');

callexp
Screen(Window,'Flip');
wait4key
Screen(Window,'Flip');

disp_resolveBDM_mac%(subjectID)
Screen(Window,'Flip');
%}
%% ProbeResolve
% questdlg('Click ''Continue'' to start the shuffle  ','start shuffle','Continue','Continue');
CenterText(Window,' press any key to start the shuffle', white,0,-60);
Screen(Window,'Flip');
wait4key
Screen(Window,'Flip');
disp_probeResolve%(subjectID, 1, outputPath,numRunsPerBlock)
%%  finishing

run_time= toc(start_time);
disp('total run time was:')
disp(num2str(run_time));
save ([pwd '/Output/' subjectID '_exp_parameters'])


sca;

AllrunsDur.totalEXPtime=GetSecs-experimentStart;

    save ([pwd '/Output/' subjectID '_AA_EVA4_postScan_exp_parameters'])

%end %(function)

