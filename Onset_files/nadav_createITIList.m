%function [] = nadav_createITIList(mean_iti,min_iti,max_iti,numOfEvants)
clear
%     -- !! find and replace all to right name
Probe_onST_vec=[]

trialLength=1.5;
mean_iti= 3
min_iti= 2
max_iti= 10
numOfEvants= 81
runs=2
 
for RuN=1:runs

ITI_vec= [];
inD=1;


tmp=exprnd(mean_iti);
tmp=tmp-mod(tmp,1); % round to nearest interval
while tmp < min_iti || tmp > max_iti
    tmp=exprnd(mean_iti);
    tmp=tmp-mod(tmp,1); % round to nearest interval
end;

ITI_vec(inD)=tmp;
inD=inD+1;

while length(ITI_vec)<numOfEvants
    
    
    tmp=exprnd(mean_iti);
    tmp=tmp-mod(tmp,1); % round to nearest interval
    
    if mean(ITI_vec)<mean_iti
        while tmp < min_iti || tmp > max_iti || tmp <mean_iti
            tmp=exprnd(mean_iti);
            tmp=tmp-mod(tmp,1); % round to nearest interval
        end;
        
        ITI_vec(inD)=tmp;
        inD=inD+1;
        
    elseif mean(ITI_vec)>mean_iti
        
         while tmp < min_iti || tmp > max_iti || tmp >mean_iti
            tmp=exprnd(mean_iti);
            tmp=tmp-mod(tmp,1); % round to nearest interval
        end;
        
        ITI_vec(inD)=tmp;
        inD=inD+1;
        
        
    else
        tmp=exprnd(mean_iti);
        tmp=tmp-mod(tmp,1); % round to nearest interval
        while tmp < min_iti || tmp > max_iti
            tmp=exprnd(mean_iti);
            tmp=tmp-mod(tmp,1); % round to nearest interval
        end;
         
        ITI_vec(inD)=tmp;
        inD=inD+1;
        
        
        
    end
    
  
end

while mean(ITI_vec)~=mean_iti
inD= randi([min_iti max_iti],1,1) ;

if mean(ITI_vec)<mean_iti
    
 ITI_vec (inD)=ITI_vec (inD)+1
 
elseif mean(ITI_vec)>mean_iti
    
 ITI_vec (inD)=ITI_vec (inD)-1
end
end
    
probe_ITI_vec(RuN,:)= ITI_vec

end    
    
    
%% onsets
Probe_onST_vec=zeros(runs,numOfEvants);
Probe_onST_vec(:,1)=2;

for RuN=1:runs

for hu=2:length(probe_ITI_vec)
    
Probe_onST_vec(RuN,hu) =  probe_ITI_vec(RuN,hu) + Probe_onST_vec(RuN,hu-1)+trialLength;

    
end
    
end
    

%end