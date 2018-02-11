%% BDM_demo_and_1stBDM


runBDM=questdlg('Do you want to run the BDM?','Run BDM','Yes','No','Yes');
if strcmp(runBDM,'Yes')
    BDM1Demo_start = GetSecs;
    system(['/usr/local/bin/python2.7 ',pwd,'/BDM_demo.py ' subjectID]);
        AllrunsDur.BDM1Demo_time=GetSecs-BDM1Demo_start;
    questdlg('Now the full part will start.','BDM','Continue','Continue');
    
    %1st full BDM
    BDM1_start = GetSecs;
    system(['/usr/local/bin/python2.7 ',pwd,'/BDM.py ' subjectID]);
    AllrunsDur.BDM1_time=GetSecs-BDM1_start;

    BDM=1;
else
    BDM=0;
end
