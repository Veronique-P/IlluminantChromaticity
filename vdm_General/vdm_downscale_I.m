function dout = vdm_downscale_I( im, sig, ind, h)
  
  tp = imfilter(im, h, 'replicate') ;

  d = size(im) ;
  if ( size(im,3)==1 )
    dout = tp(1:2:d(1), 1:2:d(2)) ;
  else
        dout = tp(1:2:d(1), 1:2:d(2),:) ;
  end
  
 