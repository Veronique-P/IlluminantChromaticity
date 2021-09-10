function [data_out,  warp_out,  o_meta, o_opt]= vdm_prepro(data_in, i_meta,  i_opt)
  
  o_opt = i_opt ;
  o_meta = i_meta ;
   
  % subsample in time domain
  disp('Subsample time') 
  ndata_i = vdm_subsample_time(data_in, o_opt.pre.time_rate, o_opt.pre.ave, o_opt.start_frame+1,o_opt.nb_frame) ;
  nb_frame = length(ndata_i) ;
  o_meta.nb_frame  = nb_frame ;
  
  % linearise data
  disp('Linearise') 
  data = vdm_gamma_correction(ndata_i, o_opt.pre.gam, o_opt.pre.range(1:2), o_opt.pre.range(3:4)) ;
  [o_meta.dim_x o_meta.dim_y o_meta.dim_c] = size(data(1).im) ;
  
  
  % subsample in space domain
  disp('Subsample space')
  if o_opt.pre.pyr > 1
    o_opt.pre.sig = 1. ;
    for i = 1:nb_frame
      im_pyra.lev(i,:) = vdm_compute_pyram(data(i).im, o_opt.pre.sig) ;
      data(i).im = im_pyra.lev(i, o_opt.pre.pyr ).im  ;
    end
    [o_meta.dim_x, o_meta.dim_y , o_meta.dim_c] = size(data(1).im) ; 
  end
  im_pyra = [];
  
  % Compute flow  
  disp('Compute motion field')
  para = [] ;
  if o_opt.flow.static==2
    para = vdm_init_para_siftflow(para) ;
  elseif o_opt.flow.static==0
    para = vdm_init_para_flow(para) ;
  end
  
  [warp_out, flow, maxflow] = vdm_compute_flow(data, [1, o_meta.dim_x],  [1, o_meta.dim_y],    o_opt.start_frame, nb_frame,   o_opt.flow.static, './',   ' ' , para) ;

  %[flow flow_amp imflow warpflow] = comp_siftflow_video(data,
  %options.flow.para.siftflow, ...
  data_out = data ;
  