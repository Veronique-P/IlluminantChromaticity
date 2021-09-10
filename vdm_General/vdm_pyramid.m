function I_out = vdm_pyramid(I_in, sig, ind, h, maxl)
  
  I_out = I_in ;

  if (ind == maxl)  % max level of the pyramid here fixed to 6
    return ;
  end
  
  if ind==maxl
    ind
    size(I_in(ind).im)
  end
  
 I_out(ind+1).im  = vdm_downscale_I(I_out(ind).im, sig, ind, h) ;
 I_out = vdm_pyramid(I_out, sig, ind+1, h, maxl) ;
