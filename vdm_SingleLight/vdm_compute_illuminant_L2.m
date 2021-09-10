 function  [para_est , lum_max, lum_med, da, err_est, info] = vdm_compute_illuminant_L2(in_data, in_warpflow, ...
                                                  st_frame, n_frame, opt) 

 %disp('Compute illuminant')
% opt
 Lnorm = 1;
 epsilon = 1.e-6 ;
 for c=1:3
 	h(c).b = [] ;
 end
 
 [dim_x, dim_y, n_channel] = size(in_data(st_frame).im) ;
 
 % Compute normalised difference between t and t+1 (est)
 % and concataned valeus computed at edges points from all frames (h)
 % ----------------------------------------------------------------------
 
 for i=st_frame:(st_frame+n_frame-1)
	
 	a(i).im = in_warpflow(i+1).im - in_data(i).im ; 
        
        if Lnorm==2
           % tthe L2 norm of the  LHS
           a3(i).im = sqrt( sum(a(i).im.^2 ,3) ) ;
        else  % default mode : use this one for light correction
             a3(i).im = sum(a(i).im ,3) ;
        end                                    
        
	su =  repmat(a3(i).im,[1,1,3]) ;
	
	est = a(i).im ./ max(su, epsilon) ;
        est(abs(su) < opt.ill.thres) = 0 ; 
        
	imed = zeros(dim_x, dim_y) ;
        
        if opt.edge.type == 1
          for c=1:n_channel
		imed = imed + edge(in_data(i).im(:,:,c), 'canny', opt.edge.thres) ;
          end
        else
          imed =[] ;
        end
        
	for c = 1:n_channel
		ta = est(:,:,c)  ; 
		ta(imed<epsilon) = [];  % select only edge points
                                        % (trustable)
		ta = ta(:)' ; 
		h(c).b = [h(c).b ta] ;
                
        end
        
        info.edge(i).nb = length(ta);
        info.edge(i).im = imed.*(imed>epsilon);

 end 
 
 da = a ; % da is output parameter
 
 % Generate empirical distribution (ie., histo)
 % ---------------------------------------------------------
 max_c = 1 ;
 min_c = 0.001 ; % 
 
 % truncate
 for c=1:n_channel
   h(c).b(h(c).b >= max_c) = [] ;
   h(c).b(h(c).b < min_c) = [] ;
 end
 

 s = opt.ill.bin ; % 2000
 del = double(max_c - min_c) / s ;
 edges = (min_c+del):del:max_c;

 for c=1:n_channel
        n(c).h = [] ; bin = [];
 	[n(c).h,bin] = histc(h(c).b(:),edges);

        n(c).h(end) = 0;
        n(c).h(1) = 0 ; 
  
        m = mode(bin) ;
	if m ==0 
		disp('ERROR in compute_illuminant_l2.m: mode = 0 ; set to 2 ')
		m = 3;
	end
        
        lum_max(c) =  edges(m) ;
        
        info.mean(c) = mean(h(c).b(:)) ; %
        info.med(c) = median(h(c).b(:)) ;
         
        lum_med(c) = median(h(c).b(:)) ;  % 

        % remove dominant peak and nearby before fitting
         n(c).h(m) = 0 ;     n(c).h(m+1) = 0 ;    n(c).h(m+2) = 0 ;      n(c).h(m+3) = 0 ;  
	 if m>1 
           n(c).h(m-1) = 0 ; 	
	   if m>2 
         	n(c).h(m-2) = 0 ; 
		if m>3
          	   n(c).h(m-1) = 0;
	 	end 
	    end
	  end
        
        % BUG in histc - security check : NECESSARY !!
        if (length(n(c).h) ~= length(edges))
          disp('ERR: in compute_illuminant_L2.m: inconsistency here') ;
          dd = length(n(c).h) - length(edges) 
          if dd > 0
            n(c).h(end-dd+1:end) = [] ; % remove the end : arbitrary!
          end
        end

 end

 % Initialise parameters for the fitting
 % Then fits with fminsearch , for each channel
 % ------------------------------------------------
 for c=1:n_channel
   tp = [];
   tp = edges(find(n(c).h==max(n(c).h)));
   ill(c) = tp(1) ; % poor solution for multiple nearby pics
 end

 foptions=optimset('Display','notify','TolFun',1.e-06 ); 

 for c=1:n_channel
   
   n(c).h = n(c).h ./ sum(n(c).h)  ;  % 

   para_init(1) = ill(c) ; % center c, ie illuminant chromaticity
   para_init(2) = 1 ;    % decreasing factor l
   para_init(3) = max(n(c).h)  ;% pic 
   festim = fminsearch(@vdm_funct_exp, para_init, foptions, edges,  n(c).h'); 
   
  % para_est(c).par = estim ;
    para_est(c) = festim(1) ;
    
   if opt.disp 
     figure, 
     bar(edges,n(c).h,'histc') 
     hold on
     plot(edges, festim(3)*exp(-festim(2)*abs(edges-festim(1))), 'r') ;     
     hold off
     %title(strcat('histogram ',int2str(c)))
   end
   
 end

 tot_para1 = 0 ;
 for c=1:n_channel
   %tot_para1 = tot_para1 + para_est(c).par(1) ;
   tot_para1 = tot_para1 + para_est(c);
 end
 err_est = 1 - tot_para1 ;  
 