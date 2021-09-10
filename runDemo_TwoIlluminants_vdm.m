 % --------------------------------
 % RunDemo.m 
 % Illuminant Chromaticity from Image Sequences
 % V. Prinet, D. Lischinski, M. Werman - ICCV 2013
 % Two-Illuminant Estimation
 % September 9, 2013
 % vprinet@gmail.com
 % ------------------------------- 
  clear

  addpath ./vdm_Extern/ ; % flow(), siftflow
  addpath ./vdm_Extern/SIFTflow/   ./vdm_Extern/SIFTflow/mexDenseSIFT/ ...
      ./vdm_Extern/SIFTflow/mexDiscreteFlow/ ; 
  addpath  ./vdm_Extern/OF   ./vdm_Extern/OF/mex/;
  addpath ./vdm_General/ ;  
  addpath ./vdm_TwoLights/ ;
 
  
  %Read the frames 
 %  this_dir.dir = ['./vdm_TwoLights/Data/tunnel_1082/'] ;
 % this_file.file = ['1082_']  ; %  keyboard
 %  init_count = 0 ;
   
   this_dir.dir = ['./vdm_TwoLights/Data/bootle_0016/'] ;
   this_file.file = ['0016_']  ; % bootle initcout 260
   init_count = 0;
  
 
  % Parameters 
  options = [] ;
  options = vdm_init_para_prepro(options) ;
  options = vdm_init_para_2ill(options) ;
  options.save = 0;
  options.verb = 1;
  options.disp = 0 ;
   
  % Estimate illuminant
  [chrom Lumap] = vdm_twoilluminant(this_dir.dir, this_file.file, ...
                                         init_count, options) ;
   if options.verb
     chrom
   end
   
   if options.save
       outdirfile = ['./vdm_TwoLights/Resu/',this_file.file];
       imwrite(Lumap,[outdirfile,'lumap.png']) ;
       dlmwrite([outdirfile, 'Lchr.txt'], [chrom(1,:) ; chrom(2,:)], 'delimiter', '\t') ;
  end
   
  if options.disp==1
    vdm_visu_color(chrom(1,:)) ;  title('est 1')
    vdm_visu_color(chrom(2,:))  ; title('est 2')
    figure, imagesc(Lumap)
  end
  
