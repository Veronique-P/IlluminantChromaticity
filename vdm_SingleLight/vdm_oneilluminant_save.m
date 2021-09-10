function mes = vdm_oneilluminant_save(myfile, data, opt)
  
  if opt.save == 0
    mes = 0;
    return
  end
  
  dlmwrite([myfile,  'lightest_huji.txt'], data ,  'delimiter', '\t', 'precision', 6);
         
  if ~opt.save==2
       color_patch(:,:,1) = repmat(light_est(1) , [100,100,1]) ;
       color_patch(:,:,2) = repmat(light_est(2) , [100,100,1]) ;
       color_patch(:,:,3) = repmat(light_est(3) , [100,100,1]) ;
       
       imwrite(color_patch, [myfile, '_colorpatch',  '.jpg']) ;
  end
  mes = 1 ;
  