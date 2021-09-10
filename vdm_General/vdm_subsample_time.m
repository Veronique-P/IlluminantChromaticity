function ndata = vdm_subsample_time(idata, time_rate, ave, st_frame,n_frame) 
 k = 1 ;
 % SHOULD USE ST_FRAME ! 
 zeroim = zeros(size(idata(1).im)) ;
 
 if ave==0
   %disp('no time averaging')
   for i=st_frame:time_rate:n_frame
     ndata(k) =idata(i) ;
     k = k+1 ;
   end
 elseif ave==1
   for i=st_frame:time_rate:n_frame
     ndata(k).im = zeroim ;
     for j=1:time_rate
       ndata(k).im = ndata(k).im + idata(i+j-1).im ;
     end
     ndata(k).im =ndata(k).im ./ time_rate ;
     k = k+1 ;
   end
 else
   disp('ave ={0,1}')
 end
 
 k = [] ;