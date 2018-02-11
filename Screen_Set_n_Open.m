%% Screen_Set_n_Open


keepTrying = 1;
while keepTrying < 10
    try
       %% open_screen


%% Skipping the synchronization between Psychtoolbox and the computer's auto refresh. 

% Screen('Preference', 'SkipSyncTests', 1)
% Screen('Preference', 'SkipSyncTests', 2)

%%  checking the code using a smaller window size:
%Window = Screen(PresentScreen,'OpenWindow',BackColor,[0 0 1280 1080]); 

% full screen    
Window = Screen('OpenWindow', PresentScreen ,BackColor); % Opens the screen with the chosen backcolor

Screen ('fillRect',Window,BackColor);
Screen ('flip',Window);
Screen('TextSize',Window,60);
Screen('TextFont',Window,'Arial');

 
     
        keepTrying = 10;
    catch
        sca;
      
        keepTrying = keepTrying + 1;
        warning('CODE HAD CRASHED - Screen_Set_n_Open !');
    end
end

[wWidth, wHeight]=Screen('WindowSize', Window); % General window size
% Setting the screen center point.
xcenter=wWidth/2;
ycenter=wHeight/2;
% For placing the images on the center-bottom part of the screen.

HideCursor;

