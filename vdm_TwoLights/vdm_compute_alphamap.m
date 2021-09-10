function  alpha = vdm_compute_alphamap(Lum, opt)
  
      sig=0.1^6; %
      neigs = 3 ;
      OPT.disp = 0;
      
      [lm,ln,lc]= size(Lum) ;
      
     % if opt.lsqal.type == 1
       M=vdm_getLaplacian1_ada(Lum,zeros(lm,ln),sig,[floor((lm-1)/2), ...
                           floor((ln-1)/2)]);  
     % end
      
     % if  (opt.alph.type ~= 4 )
        [u00,d00]=eigs(M,neigs,'sm', OPT);
      
        ui = reshape(u00(:,2),[lm,ln]) ;  
        alpha = (ui - min(ui(:))) ./ (max(ui(:)) - min(ui(:))) ;
     % end
      