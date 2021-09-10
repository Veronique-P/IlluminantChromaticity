function o_opt =  vdm_init_para_2ill(i_opt) 

   o_opt = i_opt ;
   
   o_opt.ill.bin = 500 ; 
   o_opt.ill.nb_frame_illum = [] ;
   o_opt.ill.type = 1 ; %1=fitting, 2= lummax, 3= median, 
   %o_opt.ill.thres = 0. ;

  % o_opt.edge.type = 1 ; 
   %o_opt.edge.thres = 0.1;

  % 2 illum   
   o_opt.ill.win = [50,50];  
   o_opt.ill.dw = [10,10];   
   %options.ill.dw = [2^3,2^3];   % for dyadic interpolation
   o_opt.ill.mw = 120; % max constrainted by the Laplacian Mat
   o_opt.ill.tp = 1; % threshold on nb of pts in cell
   o_opt.ill.fit = 1;  % can be set to sero for o_opt.ill.type=1 or 3
 
    o_opt.lsqal.type = 1 ;