function [outdata cropdata coord] = vdm_upscale(indata, opt, meta)

   [lm, ln, lc] = size(indata) ;
   metho = 'linear' ;
   dix = opt.ill.dw(1) ; diy = opt.ill.dw(2) ;
   w2 = floor(opt.ill.win/2) + mod(opt.ill.win,2) ;
  
   xi = w2(1)+1:dix:((dix*lm)+w2(1)) ;     
   yi = w2(2)+1:diy:((diy*ln)+w2(2)) ; 
   xo = w2(1)+1:((dix*lm)+(w2(1)*2)+dix) ;          % 
   yo = w2(2)+1:((diy*ln)+(w2(2)*2)+diy) ;  
   coord = [xi(1) xi(end)  yi(1), yi(end) ; xo(1) xo(end) yo(1) yo(end)] ;

   up_ui = [] ;
   up_ui(w2(1)+1:xo(end), w2(2)+1:yo(end)) = interp2(yi, xi, indata, yo,xo', ...
                                               metho);
   
   up_ui(up_ui>1) = 1 ;  
   up_ui(up_ui<0) = 0 ;
   up_ui(isnan(up_ui)) = 0 ; 
   
   tp = up_ui( (w2(1)+1):(xi(end)-1), (w2(2)+1):(yi(end)-1) );
   cropdata = (tp-min(tp(:))) / (max(tp(:)) - min(tp(:)) );
   
    % this is sanity check
   dim_x = meta.dim_x ; dim_y = meta.dim_y ;
   [n_dimx, n_dimy] = size(up_ui) ;
   if  (n_dimx~=dim_x | n_dimy~=dim_y)
     if n_dimx < dim_x
       up_ui(end+1:dim_x,:,:) = 0;
     else
       up_ui(dim_x+1:end,:,:) = [];
    end
     if n_dimy < dim_y
       up_ui(:,end+1:dim_y,:) = 0;
     else
       up_ui(:,dim_y+1:end,:) = [];
     end
   end     
   
   outdata = [] ;
   outdata = (up_ui - min(up_ui(:))) ./ (max(up_ui(:))- min(up_ui(:))) ;
   
