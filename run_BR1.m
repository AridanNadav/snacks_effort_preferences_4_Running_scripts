
%% run_BR1
BR1Demostart=GetSecs;
BinaryRanking_1st_done = 0;

        binary_ranking_demo%(subjectID,test_comp,pwd);
        
        % Ask if subject wanted another demo
        % ----------------------------------
        % demo_again = questdlg('Do you want to run the demo again?','Repeat Demo','Yes','No','No');
%         DrawFormattedText(Window,'Do you want to run the demo again? Y=yes any key=No','center','center',TextColor);
%         Screen('Flip',Window);
%         
%         [secs, keyCode, deltaSecs] = KbWait();
%         Response = KbName(keyCode);
%         
%         if ismember(Response,['y','Y'])
%             Screen('Flip',Window);
%             binary_ranking_demo%(subjectID,test_comp,pwd);
%         end

AllrunsDur.BR1Demo=GetSecs-BR1Demostart;

Screen('Flip',Window);

BR1start=GetSecs;
binary_ranking
AllrunsDur.BR1=GetSecs-BR1start;
BinaryRanking_1st_done = 1;