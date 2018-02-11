% remove_probe_from_BR2

BR2Full=[shuffle_stimlist1_2nd;shuffle_stimlist2_2nd]';


HV_90 = (19:21);
HV_50 = (10:12);
HV_10 = (1:3);

%   comparisons of interest - Medium
% - - - - - - - - - - - - - - -
MV_90 = (22:24 );
MV_50 = (13:15);
MV_10 = (4:6);

%   comparisons of interest - Low
% - - - - - - - - - - - - - - -
LV_90 = (25:27);
LV_50 = (16:18);
LV_10 = (7:9);

 probeind=[];
for reoutcome=1:length(BR2Full)
    
    if  ismember(BR2Full(reoutcome,1),HV_90)%%%%%%%%%%%%%%%%%%%%%%90
        if ismember(BR2Full(reoutcome,2),HV_50)
            probeind=[probeind reoutcome];
            
            
        elseif  ismember(BR2Full(reoutcome,2),HV_10)
            
            probeind=[probeind reoutcome];
            
            
        end
    elseif ismember(BR2Full(reoutcome,1),HV_50)%%%%%%%%%%%%%% 50
        
        if ismember(BR2Full(reoutcome,2),HV_90)
            probeind=[probeind reoutcome];
            
        elseif  ismember(BR2Full(reoutcome,2),HV_10)
            
            probeind=[probeind reoutcome];
            
        end
    elseif ismember(BR2Full(reoutcome,1),HV_10)%%%%%%%%%%%%%%%10
        
        if ismember(BR2Full(reoutcome,2),HV_90)
            probeind=[probeind reoutcome];
            
            
        elseif  ismember(BR2Full(reoutcome,2),HV_50)
            probeind=[probeind reoutcome];
            
        end
        
    elseif  ismember(BR2Full(reoutcome,1),MV_90)%%%%%%%%%%%%%
        if ismember(BR2Full(reoutcome,2),MV_50)
            probeind=[probeind reoutcome];
            
        elseif  ismember(BR2Full(reoutcome,2),MV_10)
            probeind=[probeind reoutcome];
            
            
        end
    elseif ismember(BR2Full(reoutcome,1),MV_50)%%%%%%%%%%%%%%%%%%%%
        
        if ismember(BR2Full(reoutcome,2),MV_90)
            probeind=[probeind reoutcome];
            
        elseif  ismember(BR2Full(reoutcome,2),MV_10)
            probeind=[probeind reoutcome];
            
            
        end
    elseif ismember(BR2Full(reoutcome,1),MV_10)%%%%%%%%%%%%%%%%%%
        
        if ismember(BR2Full(reoutcome,2),MV_90)
            probeind=[probeind reoutcome];
            
        elseif  ismember(BR2Full(reoutcome,2),MV_50)
            probeind=[probeind reoutcome];
            
        end
        
    elseif  ismember(BR2Full(reoutcome,1),LV_90)%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if ismember(BR2Full(reoutcome,2),LV_50)
            probeind=[probeind reoutcome];
            
        elseif  ismember(BR2Full(reoutcome,2),LV_10)
            
            probeind=[probeind reoutcome];
            
            
        end
    elseif ismember(BR2Full(reoutcome,1),LV_50)%%%%%%%%%%%%%%%%%%%%%%%
        
        if ismember(BR2Full(reoutcome,2),LV_90)
            probeind=[probeind reoutcome];
            
        elseif  ismember(BR2Full(reoutcome,2),LV_10)
            
            probeind=[probeind reoutcome];
            
        end
    elseif ismember(BR2Full(reoutcome,1),LV_10)%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        if ismember(BR2Full(reoutcome,2),LV_90)
            probeind=[probeind reoutcome];
            
        elseif  ismember(BR2Full(reoutcome,2),LV_50)
            probeind=[probeind reoutcome];
            
        end
    end
end


BR2noProbe= BR2Full;
BR2noProbe(probeind,:)=[];


shuffle_stimlist1_2nd= BR2noProbe(:,1)';
shuffle_stimlist2_2nd= BR2noProbe(:,2)';

