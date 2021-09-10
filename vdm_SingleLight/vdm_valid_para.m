function o_opt = vdm_valid_para(i_opt, meta)
  
  o_opt = i_opt ;
    
  if (isempty(i_opt.nb_frame) |  ~isfield(i_opt, 'nb_frame')) 
    o_opt.nb_frame = meta.nb_frame;
  elseif (i_opt.nb_frame > meta.nb_frame)
    o_opt.nb_frame = meta.nb_frame ;
  end
     
  
  if ( isempty(i_opt.start_frame) |  ~isfield(i_opt, 'start_frame')) 
    o_opt.start_frame =0;
  end
     
   
  if ( isempty(i_opt.pre.range) |   ~isfield(i_opt.pre,'range')) 
       o_opt.pre.range = [1,meta.dim_x, 1,meta.dim_y] ;
  end

  if ( isempty(i_opt.ill.nb_frame_illum) |   ~isfield(i_opt.ill,'nb_frame_illum')) 
       o_opt.ill.nb_frame_illum = meta.nb_frame - 1 ;
  end
