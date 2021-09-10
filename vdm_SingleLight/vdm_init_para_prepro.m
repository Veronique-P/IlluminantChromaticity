 function o_opt =  vdm_init_para_prepro(i_opt) 

   o_opt = i_opt ;
   
   o_opt.pre.format = '.bmp' ;
   
   o_opt.pre.time_rate = 3; %% 
   o_opt.pre.ave=0;
   
   o_opt.pre.gam = 2.2 ;
   o_opt.pre.igam = 1./o_opt.pre.gam ;
   o_opt.pre.range = [1 , 1080 , 1 , 1920/2] ;  % crop the input frame - 4 dim vector : [rowmin rowmax colmin colmax]
   % o_opt.pre.range = [ ] ; % no crop

   o_opt.pre.pyr  = 0 ; % 0 for image original size
   
   o_opt.flow.static = 2; % 2= siftflow, 0= OptFlow, 1= static
   
   o_opt.nb_frame = [] ;
   o_opt.start_frame = 0;
   
   o_opt.disp = 0 ;
   o_opt.verb = 1 ;
   %o_opt.debug = 0 ;
   
