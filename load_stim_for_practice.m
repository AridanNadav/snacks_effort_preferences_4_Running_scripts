% load_stim_for_practice

practice_done=0;
% The function uses data from the 'daq', and show how hard does the subject
% is pressing by moving the image up and down.
% The function sets to each image a difficulty level - So that each image
% requires a different amount of power for moving it up toward the difficulty bar.

EffortDur = 1.5;
iti_length=1;

% images
stimuli=dir([pwd '/stim/*.bmp' ]);
Image_example=imread([pwd '/stim/' stimuli(1).name ]);
stackH= size(Image_example,1)*0.5; % Setting image hight.
stackW= size(Image_example,2)*0.5; % Setting image width.

% stackW = 576;
% stackH = 432;

%demo stimuli
stimuli=dir('./stim/demo/*.bmp');
stimname=struct2cell(rmfield(stimuli,{'date','bytes','isdir','datenum'}));
Images_demo=cell(length(stimname),1);
for i=1:length(stimname)
    Images_demo{i}=imread(sprintf('%s','./stim/demo/',stimname{i}));
end
