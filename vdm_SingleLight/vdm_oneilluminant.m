function [chrom , data_out, info]  = vdm_oneilluminant(this_dir, this_file, ...
                                                  init_count, options)
  
  
  % Read data
  [data_i, meta]= vdm_read_video_from_dir(this_dir, this_file, ...
                                   init_count, options.pre.format) ;  

  % Valid options
  options = vdm_valid_para(options, meta) ;

  % Preprocess data 
  [data warpdata]= vdm_prepro(data_i, meta,  options) ;
  data_i = [];
  
  % Compute illuminant
  chrom = [];
  disp('Compute Illuminant')
  [lum_est, lum_max, lum_med, aa, err_est, info] = ...
      vdm_compute_illuminant_L2(data, warpdata, options.start_frame+1, options.ill.nb_frame_illum, options) ;
    
  chrom(1,:)  = vdm_normalize(lum_est.^options.pre.igam) ;
  chrom(2,:)  = vdm_normalize(lum_max.^options.pre.igam) ;
  chrom(3,:)  = vdm_normalize(lum_med.^options.pre.igam) ;
  
  data_out = [];
