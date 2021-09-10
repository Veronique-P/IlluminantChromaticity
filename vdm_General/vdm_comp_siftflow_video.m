
 function [oflow  oflow_amp  oimflow owarp] = vdm_comp_siftflow_video(indata, par, ...
                                                  st_frame, n_frame) 
  
 
  dim_x = size(indata(1),1) ;
  dim_y = size(indata(1),2) ;

  oflow_amp(1).im = zeros(dim_x, dim_y) ;
  oflow(1).im=  zeros(dim_x, dim_y, 2);
  oimflow(1).im=  zeros(dim_x, dim_y);
  owarp(1).im =  zeros(dim_x, dim_y);
  
  para = [par.alpha, par.d, par.gamma, par.nlevels, par.wsize, ...
          par.topwsize, par.nTopIterations, par.nIterations ];
  
  cellsize=3;
  gridspacing=1;
  
  im1 = indata(st_frame+1).im ;
  sift1 = mexDenseSIFT(im1,cellsize,gridspacing);

  for i=2:n_frame
    
    im2 = indata(i+st_frame).im ;
    sift2 = mexDenseSIFT(im2,cellsize,gridspacing);

    [vx,vy,energylist]=SIFTflowc2f(sift1,sift2,para);
    warpI2=warpImage(im2,vx,vy);

    im1 = im2 ;
    sift1 = sift2 ;
    oflow_amp(i).im = sqrt( vx.^2 + vy.^2 ) ;
    norma = max(oflow_amp(i).im(:)) ;
    oflow_amp(i).im = oflow_amp(i).im ./ norma ;  % 
                                                  
    oflow(i).im(:,:,1) = vx;
    oflow(i).im(:,:,2) = vy;
    oimflow(i).im = flowToColor(oflow(i).im);
    owarp(i).im = warpI2 ;
    
  end 
  