function [chrom Lumap]  = vdm_twoilluminant(this_dir, this_file, ...
                                                  init_count, options)
  
  
  % Read data
  [data_i, meta]= vdm_read_video_from_dir(this_dir, this_file, ...
                                   init_count, options.pre.format) ;  

  % Valid options
  options = vdm_valid_para(options, meta) ;

  % Preprocess data 
  [data warpdata]= vdm_prepro(data_i, meta,  options) ;
  data_i = [];
  
  % Compute local incident illuminant
  chrom = [];
  
  [lum_est, lum_max, lum_med, aa, info, options] = ...
      vdm_compute_illuminant_local_revis(data, warpdata, options.start_frame+1, options.ill.nb_frame_illum, options) ;
    
  [Lum lmnc]= vdm_norma_lum(lum_est, lum_max, lum_med, options) ;
  
  Lum = vdm_interpol_lum_s1(Lum, 1*(Lum(:,:,1)>0)) ;
   
  % Compute alpha map and color
  disp('Comp alphwb') 
  alpha = vdm_compute_alphamap(Lum, options) ;
  Lchr = vdm_compute_illchro(Lum, alpha, info, options) ; % normalised,
                                                           % linear
  
  % delinearise
  Lchrgam(1,:) = vdm_normalize(Lchr(1,:).^options.pre.igam) ;
  Lchrgam(2,:) = vdm_normalize(Lchr(2,:).^options.pre.igam) ;
  
  chrom = Lchrgam ;
  Lumap = vdm_normalize(Lum.^options.pre.igam,2);

  
  
  
