% BRallCOMB 
total_stimuli=27; %number_of_stimuli ;

a=[];
b=[];

for i=1:total_stimuli-1
    for j=i+1:total_stimuli
        a(end+1)=i;
        b(end+1)=j;
    end
end

if BinaryRanking_1st_done == 0
    [shuffle_stimlist1, shuffle_stimlist1_ind] = Shuffle(a);
    shuffle_stimlist2 = b(shuffle_stimlist1_ind);
else
    [shuffle_stimlist1_2nd, shuffle_stimlist1_ind_2nd] = Shuffle(a);
    shuffle_stimlist2_2nd = b(shuffle_stimlist1_ind_2nd);
end
    