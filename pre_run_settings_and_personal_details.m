%  pre_run_settings_and_personal_details.m
%  fixed parameters throughout the experiment
%  must run first for any other script to run

% take whole experiment time
start_time = tic;

% essential for randomization
rng('shuffle');

% set the path
outputPath = [pwd '/Output'];

WithORnot_eyeTracker

%%  personal_details(subjectID, order, outputPath, sessionNum,timestamp)

% Subject code
% subjectID = input('Subject code: ','s');
% [subjectID_num,okID]=str2num(subjectID(end-2:end));
% while okID==0
%     warning(' Subject code must contain 3 characters numeric ending, e.g "BMI_bf_001". Please try again.');
%     subjectID = input('Subject code:','s');
%     [subjectID_num,okID]=str2num(subjectID(end-2:end));
%     
% end


subNUM = input('Subject number (4__): ','s');
[subNUM_num,okID]=str2num(subNUM(end-2:end));
while okID==0
    warning(' Subject code must contain 3 characters numeric ending, e.g "401". Please try again.');
    subNUM = input('Subject number (4__):','s');
    [subNUM_num,okID]=str2num(subNUM(end-2:end));
    
end

subjectID=['EVA4_' subNUM];


    subject_files = dir([outputPath '/' subjectID '*']);
    
    if ~isempty(subject_files)
        warning(' Subject already exists!!!. Please try again.');
        subjectID = input('Subject code: ','s');
    else
    end


% Subject order for counterbalancing
order = input('Subject order: ');
while order > 3 || order < 1
    warning(' Subject order must a number between 1 to 3. Please try again.');
    subjectID = input('Subject order:');
end

%  subject's Gender
Gender = questdlg('Please select your sex:','sex','Female','Male','Female');
while isempty(Gender)
    Gender = questdlg('Please select your sex:','sex','Female','Male','Female');
end
if strcmp(Gender,'Male')
    Gender = 2;
else
    Gender = 1;
end

%  subject's age
Age = inputdlg ('Please enter your age: ','Age',1);
while isempty(Age) || isempty(Age{1})
    Age = inputdlg ('Only integers between 18 and 40 are valid. Please enter your age: ','Age',1);
end
Age = cell2mat(Age);
Age = str2double(Age);
while mod(Age,1) ~= 0 || Age < 18 || Age > 40
    Age = inputdlg ('Only integers between 18 and 40 are valid. Please enter your age: ','Age',1);
    Age = cell2mat(Age);
    Age = str2double(Age);
end

%  subject's handedness
DominantHand = questdlg('Please select your domoinant hand:','Dominant hand','Left','Right','Right');
while isempty(DominantHand)
    DominantHand = questdlg('Please select your domoinant hand:','Dominant hand','Left','Right','Right');
end
if strcmp(DominantHand,'Left')
    
    warning(' Subject must be right handed');

    DominantHand = 2;
else
    DominantHand = 1;
end

%  subject's Occupation
Occupation = inputdlg('Please type your occupation (for example- a student for Psychology): ','Occupation',1);
Occupation = cell2mat(Occupation);
TIMEstamp

% open a txt file for the details
sub_details = fopen([outputPath '/' subjectID '_personalDetails_' timestamp '.txt'], 'a');
fprintf(sub_details,'subjectID\torder\tdate\tgender(1-female, 2-male)\tage\tdominant hand (1-right, 2-left)\toccupation\n'); %write the header line

% Write details to file
fprintf(sub_details,'%s\t%d\t%s\t%d\t%d\t%d\t%s\n', subjectID, order, timestamp, Gender, Age, DominantHand, Occupation);
fclose(sub_details);


%%
load_instruction_images

%% objects and screen parameters 

% Set up Screen
BackColor = 0; % Black back color
TextColor = 255; % White Text color
white=255;

% Choosing the main screen to display the trial on.
PresentScreen = max(Screen('Screens'));
ScreenRect = Screen(PresentScreen, 'rect'); 
% Setting the coordinates of the middle of the screen
[centerX, centerY] = RectCenter(ScreenRect); 


%% Onsets

load ([pwd '/Onset_files/onsets.mat'])

%% stimuli

% full stimuli
stimuli=dir([pwd '/stim/*.bmp' ]);
Image_example=imread([pwd '/stim/' stimuli(1).name ]);
stackH= size(Image_example,1); % Setting image hight.
stackW= size(Image_example,2); % Setting image width.
HWratio=stackH/stackW;
% stackW = 576;
% stackH = 432;

%demo stimuli
stimuli=dir('./stim/demo/*.bmp');
stimname=struct2cell(rmfield(stimuli,{'date','bytes','isdir','datenum'}));
Images_demo=cell(length(stimname),1);
for i=1:length(stimname)
    Images_demo{i}=imread(sprintf('%s','./stim/demo/',stimname{i}));
end
%%

save ([pwd '/Output/' subjectID '_AA_EVA4_pre_run_settings_and_personal_details'])
