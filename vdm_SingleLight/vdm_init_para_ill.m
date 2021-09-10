function o_opt =  vdm_init_para_ill(i_opt) 

   o_opt = i_opt ;
   
   o_opt.ill.bin = 2000 ; 
   o_opt.ill.nb_frame_illum = 2 ; % total frame used : nb_frame_illum+1
   o_opt.ill.thres = 0.1; % 0.1 ; 
   o_opt.ill.type = 1 ; % 1=fitting, 2= lummax,3= median,

   o_opt.edge.type = 1 ; % 1: edges , 0: whole image
   o_opt.edge.thres = 0; % canny high threshold -hysteresis.; []: adaptative threshold

