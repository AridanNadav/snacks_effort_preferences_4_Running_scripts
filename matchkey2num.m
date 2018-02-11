%matchkey2num

% if BhavOrMRI==1
    
    if strcmp(vas_input_str, '1!')
        vas_input(l)=1;
    elseif strcmp(vas_input_str, '2@')
        vas_input(l)=2;
    elseif strcmp(vas_input_str, '3#')
        vas_input(l)=3;
    elseif strcmp(vas_input_str, '4$')
        vas_input(l)=4;
%     elseif strcmp(vas_input_str, '5%')
%         vas_input(l)=5;
%     elseif strcmp(vas_input_str, '6^')
%         vas_input(l)=6;
%     elseif strcmp(vas_input_str, '7&')
%         vas_input(l)=7;
%     elseif strcmp(vas_input_str, '8*')
%         vas_input(l)=8;
%     elseif strcmp(vas_input_str, '9(')
%         vas_input(l)=9;
%     elseif strcmp(vas_input_str, '0)')
%         vas_input(l)=10;
%     elseif strcmp(vas_input_str, '`~')
%         vas_input(l)=0;
    else
        vas_input(l)=99;
    end
    
    
% elseif BhavOrMRI==2
%     
%     
%     if strcmp(vas_input_str, 'r')
%         vas_input(l)=1;
%     elseif strcmp(vas_input_str, 'g')
%         vas_input(l)=2;
%     elseif strcmp(vas_input_str, 'y')
%         vas_input(l)=3;
%     elseif strcmp(vas_input_str, 'b')
%         vas_input(l)=4;
%         
%     end
% end
