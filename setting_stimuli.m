%function [Images] = setting_stimuli()
% The function gather all the stimuli from the chosen folder and converts
% them from struct to cell.


%Loading practice images - Tal 16.11
subj_allstim_file=dir(fullfile(outputPath,[subjectID,'_stopGoList_allstim_order*']));
fid=fopen(fullfile(outputPath,subj_allstim_file.name));
IMG_set=textscan(fid, '%s %d %f %f %f %f %f'); %read in data as new matrix 'HeaderLines', 1
fclose(fid);



%Loading demo images - Tal 16.11
demo_stimuli=dir([pwd '/stim/demo/*.bmp' ]);
stimname=struct2cell(rmfield(demo_stimuli,{'date','bytes','isdir','datenum'}));
demo_Images=cell(length(stimname),1);
for i=1:length(stimname)
    demo_Images{i}=imread(sprintf('%s',pwd,'/stim/demo/',stimname{i}));
end


fid3 = fopen([outputPath '/' subjectID '_stimuli_' timestamp '.txt'],'a');
fprintf(fid3,'StimName\t Image_Rank\t IMG_class\n');

effort_stim_num = 0;
for ind=1:length(IMG_set{3})
    if double(IMG_set{2}(ind)) <= 3 %############# to change so it won't be hard coded
        effort_stim_num = effort_stim_num +1;
    end
end

Practice_Images=cell(effort_stim_num, 1);
IMGnames1 = cell(effort_stim_num/3, 1);
IMGnames2 = cell(effort_stim_num/3, 1);
IMGnames3 = cell(effort_stim_num/3, 1);

count_effort_1 = 1;
count_effort_2 = 1;
count_effort_3 = 1;

for i=1:length(IMG_set{3}) %stimname\RanStimuli
    if IMG_set{2}(i) == 1
        Practice_Images_1{count_effort_1}=imread(sprintf('%s',pwd,'/stim/',IMG_set{1}{i})); %RanStimuli(i)
        fprintf(fid3,'%s\t %d\t %d\n', IMG_set{1}{i}, IMG_set{3}(i), IMG_set{2}(i) ); %stimuli(i).name, RanStimuli(i)
        IMGnames1{count_effort_1} = IMG_set{1}(i);
        count_effort_1 = count_effort_1 + 1;
    elseif IMG_set{2}(i) == 2
        Practice_Images_2{count_effort_2}=imread(sprintf('%s',pwd,'/stim/',IMG_set{1}{i})); %RanStimuli(i)
        fprintf(fid3,'%s\t %d\t %d\n', IMG_set{1}{i}, IMG_set{3}(i), IMG_set{2}(i) ); %stimuli(i).name, RanStimuli(i)
        IMGnames2{count_effort_2} = IMG_set{1}(i);
        count_effort_2 = count_effort_2 + 1;
    elseif IMG_set{2}(i) == 3
        Practice_Images_3{count_effort_3}=imread(sprintf('%s',pwd,'/stim/',IMG_set{1}{i})); %RanStimuli(i)
        fprintf(fid3,'%s\t %d\t %d\n', IMG_set{1}{i}, IMG_set{3}(i), IMG_set{2}(i) ); %stimuli(i).name, RanStimuli(i)
        IMGnames3{count_effort_3} = IMG_set{1}(i);
        count_effort_3 = count_effort_3 + 1;
    end
end

Practice_Images = [Practice_Images_1 Practice_Images_2 Practice_Images_3];
IMGnames1 = IMGnames1';
IMGnames2 = IMGnames2';
IMGnames3 = IMGnames3';
IMGnames = [IMGnames1 IMGnames2 IMGnames3];

fclose(fid3);

