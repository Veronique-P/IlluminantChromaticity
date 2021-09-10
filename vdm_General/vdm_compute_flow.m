function [warpflow, flow, maxflow, para] = vdm_compute_flow(indata, sx, sy, ...
                                                  st_frame, n_frame, static, this_dir, flowfilename, para) ;

  [dim_x, dim_y, dim_c] = size(indata(2).im) ;

  if static==1  % no motion
     disp('No motion') 
     for i = 2:n_frame
       warpflow(i).im = indata(i).im ;  
       flow(i).im(:,:,1:2) = zeros(dim_x,dim_y,2) ;
     end

  elseif static==-1 % read from file 
     disp('read motion from mat file') 
     flow(1).im(:,:,1:2)  = zeros(dim_x,dim_y,2) ;
     disp('Flow from file.')
     for i = 1:n_frame-1
       tmp = load(strcat(this_dir, flowfilename, int2str(i), '.mat')) ;
       flow(i+1).im(:,:,1)  = tmp.vx(sx(1):sx(2), sy(1):sy(2)) ; 
       flow(i+1).im(:,:,2)  = tmp.vy(sx(1):sx(2), sy(1):sy(2)) ;
       warpflow(i+1).im= warpFLColor(indata(i).im , indata(i+1).im, ...
                                                flow(i+1).im(:,:,1), ...
                                    flow(i+1).im(:,:,2)) ;
     end

  elseif static == 0
     % optical flow
     disp('Comp of ..')
      if (~exist('para','var') | isempty(para) | ~isfield(para,'flow'))       
        para = vdm_init_para_flow([]) ;
      else
        para = vdm_init_para_flow(para) ;
      end
      [flow flow_amp imflow warpflow] = vdm_comp_flow_video(indata, para.flow, ...
                                                    st_frame,  n_frame) ; 
  elseif static == 2 % sift flow
    disp('Comp sift flow ..')
    if (~exist('para','var') | isempty(para) | ~isfield(para,'flow'))      
       para = vdm_init_para_siftflow([]) ;
    else
        para =vdm_init_para_siftflow(para) ;
    end
     
    [flow flow_amp imflow warpflow] = vdm_comp_siftflow_video(indata, para.siftflow, st_frame, n_frame) ; 
  else
    disp('static = 1 (no motion), -1 (read from file), 0 (of), 2 (siftflow)') ;
  end


  maxflow = 0 ;
  for i = 2:n_frame
    mflow = max(abs(flow(i).im(:))) ; % 
    if mflow > maxflow
        maxflow = max(abs(flow(i).im(:))) ;
    end
  end
