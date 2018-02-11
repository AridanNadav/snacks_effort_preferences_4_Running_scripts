%% =========================================================================
% Break + fractals ranking
%  =========================================================================

sca

% Take a brake and relax :)
end_break=0;
% opens Fractals BDM script (py)
questdlg('In the next step, you will be asked to indicate how much do you like each of the following images. Please call the experimenter'... '
    ,'part 3','Continue','Continue');
WaitSecs(1);
system(['/usr/local/bin/python2.7 ',pwd,'/BDM_fractals.py ' subjectID]);



try
    exp_break = input('Type in "123" when you are ready to continue with the experiment:  ');
catch
    exp_break = input('Type in "123" when you are ready to continue with the experiment:  ');
end
if exp_break==123
    end_break=1;
end

while end_break==0
    fprintf('\n<strong>ERROR: Invalid input.</strong>\n');
    exp_break = input('Type in "123" when you are ready to continue: ');
    if exp_break==123
        end_break=1;
    end
end



 AA_Screen_Set_n_Open

