function [Lum lmnc]= vdm_norma_lum(lumest, lummax, lummed, opt) 
  
  epsilon = 1.e-6 ;
  
  if opt.ill.type==1
    Lum = lumest ./ repmat(max(sum(lumest,3), epsilon), [1 1 3]) ;
  elseif opt.ill.type==2
    Lum = lummax ./ repmat(max(sum(lummax,3), epsilon), [1 1 3]) ;
   elseif opt.ill.type==3
    Lum = lummed ./ repmat(max(sum(lummed,3), epsilon), [1 1 3]) ;
  else
    Lum = lumest ./ repmat(max(sum(lumest,3), epsilon), [1 1 3]) ;
  end
  
  lmnc = size(Lum) ;
   