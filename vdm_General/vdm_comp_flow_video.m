
 function [oflow  oflow_amp  oimflow owarp] = vdm_comp_flow_video(indata, par, ...
                                                  st_frame, n_frame) 
  
 
  dim_x = size(indata(1),1) ;
  dim_y = size(indata(1),2) ;

  oflow_amp(1).im = zeros(dim_x, dim_y) ;
  oflow(1).im=  zeros(dim_x, dim_y, 2);
  oimflow(1).im=  zeros(dim_x, dim_y);
  owarp(1).im =  zeros(dim_x, dim_y);
  
  para = [par.alpha, par.ratio, par.minWidth, par.nOuterFPIterations, par.nInnerFPIterations, ...
          par.nSORIterations];
       
  im1 = indata(st_frame+1).im ;
  for i=2:n_frame
    
    im2 = indata(i+st_frame).im ;
   
    [vx,vy,warpI2] = Coarse2FineTwoFrames(im1,im2,para);  % 
    
    im1 = im2 ;
    oflow_amp(i).im = sqrt( vx.^2 + vy.^2 ) ;
    norma = max(oflow_amp(i).im(:)) ;
    
    oflow(i).im(:,:,1) = vx;
    oflow(i).im(:,:,2) = vy;
    oimflow(i).im = flowToColor(oflow(i).im);
    owarp(i).im = warpI2 ;
    
  end 
  
