 function o_opt =  vdm_init_para_prepro(i_opt) 

   o_opt = i_opt ;
   
   o_opt.pre.format = '.bmp' ;
   
   o_opt.pre.time_rate = 3; %%  % 3 is standard
   o_opt.pre.ave=0;
   
   o_opt.pre.gam = 2.2 ;
   o_opt.pre.igam = 1./o_opt.pre.gam ;
   
   % 4 dim vector; crop frames
 %  o_opt.pre.range = [301 , 1080 , 251 , 1200] ;  % for keyboard
   o_opt.pre.range = []  ; 
     
   o_opt.pre.pyr  =  0; %2 ; % 0 for image original size
   
   o_opt.flow.static = 0; % 2= siftflow, 0= OptFlow, 1= static
   
   o_opt.nb_frame = [] ;
   o_opt.start_frame = 0;
   
   o_opt.disp = 0 ;
   o_opt.verb = 0 ;
   o_opt.debug = 0 ;
   
