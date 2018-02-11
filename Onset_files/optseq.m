H_val__H_efrt 
H_val__M_efrt 
H_val__L_efrt 
M_val__H_efrt 
M_val__M_efrt 
M_val__L_efrt 
L_val__H_efrt 
L_val__M_efrt 
L_val__L_efrt 

 --ev H_val__H_efrt 1.5 3
 --ev H_val__M_efrt 1.5 3
 --ev H_val__L_efrt 1.5 3
 --ev M_val__H_efrt 1.5 3
 --ev M_val__M_efrt 1.5 3
 --ev M_val__L_efrt 1.5 3
 --ev L_val__H_efrt 1.5 3
 --ev L_val__M_efrt 1.5 3
 --ev L_val__L_efrt 1.5 3
 
 optseq2 ?ntp 131 --tr 2 --tprescan 2 --psdwin 3 3 2 --ev H_val__H_efrt 1.5 3 --ev H_val__M_efrt 1.5 3 --ev H_val__L_efrt 1.5 3 --ev M_val__H_efrt 1.5 3 --ev M_val__M_efrt 1.5 3 --ev M_val__L_efrt 1.5 3 --ev L_val__H_efrt 1.5 3 --ev L_val__M_efrt 1.5 3 --ev L_val__L_efrt 1.5 3 --nkeep 10 --o OptseqResults --nsearch 1000 

 
 ./optseq2 --ntp 139 --tr 2 --tprescan 2 --psdwin 0 10 1 --ev H_val__H_efrt 2 3 --ev H_val__M_efrt 2 3 --ev H_val__L_efrt 2 3 --ev M_val__H_efrt 2 3 --ev M_val__M_efrt 2 3 --ev M_val__L_efrt 2 3 --ev L_val__H_efrt 2 3 --ev L_val__M_efrt 2 3 --ev L_val__L_efrt 2 3 --nkeep 10 --o OptseqResults --nsearch 10000 
 
 
 
 
./optseq2 --ntp 270 --tr 2 --tprescan 0 --psdwin 0 10  --tnullmin 8 --tnullmax 12 --ev H_val__H_efrt 2 6 --ev H_val__M_efrt 2 6 --ev H_val__L_efrt 2 6 --ev M_val__H_efrt 2 6 --ev M_val__M_efrt 2 6 --ev M_val__L_efrt 2 6 --ev L_val__H_efrt 2 6 --ev L_val__M_efrt 2 6 --ev L_val__L_efrt 2 6 --nkeep 6 --o OptseqResults --nsearch 10000
 