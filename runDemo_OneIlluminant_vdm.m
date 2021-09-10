 % --------------------------------
 % RunDemo.m 
 % Iluminant Chromaticity from Video Sequences
 % V. Prinet, D. Lischinski, M. Werman - ICCV 2013
 % Single Illuminant Estimation
 % vprinet@gmail.com
 % Sept 9, 2013
 % ------------------------------- 
  clear 
  
  addpath ./vdm_Extern/ ; 
  addpath ./vdm_Extern/SIFTflow/   ./vdm_Extern/SIFTflow/mexDenseSIFT/  ./vdm_Extern/SIFTflow/mexDiscreteFlow/ ; 
  addpath  ./vdm_Extern/OF   ./vdm_Extern/OF/mex/;
  addpath ./vdm_General/ ;  
  addpath ./vdm_SingleLight/ ; 
 
  %Read the frames
  this_dir.dir = './vdm_SingleLight//Data/seq_251/' ; 
  this_file.file = 'seq_251_' ;   
  init_count = 0 ;

  % Parameters of the approach
  % -----------------------------------------
  options = [] ;
  options = vdm_init_para_prepro(options) ;
  options = vdm_init_para_ill(options) ;
  options.save = 0;
  options.verb = 1 ;

  % Estimate illuminant
  disp('Compute illuminant ...')
  [chrom  out_data  info] = vdm_oneilluminant(this_dir.dir, this_file.file, ...
                                         init_count, options) ;
  light_est = chrom(options.ill.type,:) ;
  
  if options.verb
    light_est
  end
  
  % Save data
  outdir = ['./vdm_SingleLight//Resu/'] ;  proc_opt= [ ];
  outfile = [outdir, this_file.file,  proc_opt];
  vdm_oneilluminant_save(outfile, light_est, options) ;
  
  disp('Done')

   
