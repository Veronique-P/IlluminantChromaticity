 function  [para_est, lum_max, lum_med , da, info, oopt] = vdm_compute_illuminant_local_revis(in_data, in_warpflow, ...
                                                  st_frame, n_frame,  opt) 
 
 %disp('Compute illuminant')
 
 epsilon = 1.e-6 ;
 lepsilon = 5.e-4;
 Lnorm = 1;
 max_c = 1 ;
 min_c = 0.001 ;

 fop=optimset('Display','off','TolFun',1.e-06 );

 [dim_x, dim_y, n_channel] = size(in_data(st_frame).im) ;
 
 if (~isfield(opt.ill,'win') | isempty(opt.ill.win) )  % 23 march
   opt.ill.win(1:2)=100;
 end

 if (~isfield(opt.ill,'dw') | isempty(opt.ill.win) )
   opt.ill.dw(1:2)=10;
 end

 if (~isfield(opt.ill,'mw') | isempty(opt.ill.win) )
   opt.ill.mw=100;
 end

  if (~isfield(opt.ill,'tp') | isempty(opt.ill.tp) )
   opt.ill.tp=1.5;  % thershold on the percent of points kepts to compute density
 end
 
 if (~isfield(opt.ill,'fit') | isempty(opt.ill.fit) )
   opt.ill.fit=1;  % paramtric fitting
 end

 wind = opt.ill.win(1);  
 dwx = opt.ill.dw(1) ;
 dwy = opt.ill.dw(2) ;
 
 thr_npt_his = (opt.ill.tp*wind*wind/100)  ;       %percent of edges points...

 testsize=1;
 while testsize   %
   nb_wind_x = floor( (dim_x - wind) / dwx ) ;
   nb_wind_y = floor( (dim_y - wind) / dwy )  ;
   if nb_wind_x>opt.ill.mw | nb_wind_y>opt.ill.mw
     dwx = 2*dwx ;
     dwy= 2*dwy;
     testsize=1;
   else
     testsize=0;
   end
 end
 
 oopt = opt;
 oopt.ill.dw(1) = dwx ;
 oopt.ill.dw(2) = dwy ;
 
 if ( (n_frame-st_frame)>=(length(in_data)-1) | isempty(n_frame)) 
   n_frame = length(in_data)-1 ;
   oopt.ill.nb_frame_illum = n_frame ;
 end
 
 nrp = [] ;

  %oopt.ill 
 % Compute normalised difference between t and t+1 (est)
 % and concataned valeus computed at edges points from all frames (h)
 % ----------------------------------------------------------------------
 for i=st_frame:(st_frame+n_frame-1)
	
        % Compute normalised difference between consecutive frames
 	a(i).im = in_warpflow(i+1).im - in_data(i).im ; 
        
        if Lnorm==2
           % tthe L2 norm of the  LHS
           a3(i).im = sqrt( sum(a(i).im.^2 ,3) ) ;
        else  % defaut mode
             a3(i).im = sum(a(i).im ,3) ;
        end                                    
        
	su =  repmat(a3(i).im,[1,1,3]) ;
	
	est = a(i).im ./ max(su, epsilon) ;
        est(abs(su) < epsilon) = 0;  
         
        imed = zeros(dim_x, dim_y) ;
        fa = ones(dim_x, dim_y) ;
        
        % Compute edge points
        for c=1:n_channel
           imed = imed + edge((in_data(i).im(:,:,c)).^(1./2.2), 'canny') ; 
           fa = min(fa, abs(a(i).im(:,:,c)) ) ;  % 
        end
        
        % fa aims at eliminanting diffuse points (tot_der = 0, in r,g,b)
        %  or partially saturated (tot_der=0, in 1 of the channel)
        fa = fa<lepsilon ; % boolean
        fa3 = repmat(fa, [1 1 3]) ;
        est(fa3>0) = 0;
        
        % eliminate points which diff is not of all same sign % good/necessary
        ea_r=[]; a_g=[]; ea_b =[]; ea=[]; ea3=[];
        ea_rp = a(i).im(:,:,1)>(-lepsilon); 
        ea_gp = a(i).im(:,:,2)>(-lepsilon);
        ea_bp = a(i).im(:,:,3)>(-lepsilon);
        ea_rn = a(i).im(:,:,1)<(lepsilon); 
        ea_gn = a(i).im(:,:,2)<(lepsilon);
        ea_bn = a(i).im(:,:,3)<(lepsilon);
        ea = ((ea_rp & ea_gp & ea_bp)) |  ((ea_rn) & (ea_gn) & (ea_bn));
        ea3 = repmat(ea, [1 1 3]) ; % 
        est(~ea3) = 0;

	% keep points
	ed0 = zeros(dim_x, dim_y) ;
	if ~isempty(fa)
		ed0 = ed0 + fa ;
        end
        if ~isempty(ea)
		ed0 = ed0 + ea ;
        end
	if length(imed<epsilon)>1
		ed0 = ed0 + (imed<epsilon)*1;
        end
	info.edge(i).im = ed0>0;
        info.diff(i).im = fa ; %max(fa,ea) ;

        pox = 1;
        poy = 1;   
        akx = 1 ;
        aky = 1;

        for wx=1:nb_wind_x
          for wy=1:nb_wind_y
	   
            for c = 1:n_channel
               if i==st_frame
                 h(akx,aky,c).b = [] ;
                 rp(akx,aky).r = [] ;
               end
               
               ta = est(pox:pox+wind,poy:poy+wind,c)  ; 
               ta(imed(pox:pox+wind,poy:poy+wind)<epsilon) = [];  % select only edge points
                 
               ta = ta(:)' ;   
               h(akx,aky,c).b = [h(akx,aky,c).b  ta] ;
               
                % histo range between 0-1
                 if i==(st_frame+n_frame-1)
                    h(akx,aky,c).b(h(akx,aky,c).b >= max_c) = [] ;
                    h(akx,aky,c).b(h(akx,aky,c).b < min_c) = [] ;
                end
            end

            poy = poy+dwy ;
            aky = aky+1;
          end
          pox = pox+dwx ;      
          poy = 1 ;
          akx = akx+1;  
          aky = 1;
        end
        
 end 
 
 da = a ; % da is output parameter
 
 %s = 500 ; % limit seriously the precision of final results
 s = opt.ill.bin; 
 del = double(max_c - min_c) / s ;
 edges = (min_c+del):del:max_c;
  cz = 0;

  % Generate empirical distribution (ie., histo)
 k = 0 ; l = 0;
 for wx=1:nb_wind_x
   k = k+1;
   l = 0 ;
   for wy=1:nb_wind_y     
     l = l+1 ;
     for c=1:n_channel
        n(k,l,c).h = [] ; bin = [];
 	[n(k,l,c).h,bin] = histc(h(k,l,c).b(:),edges);
        
        info.npl(k,l,c) = length(h(k,l,c).b(:)) ; % sum(n(k, l,c).h); %    
        lum_med(k,l,c) = median(n(k,l,c).h) ; % 
        info.min(k,l,c) = min(n(k,l,c).h) ; % 
        info.max(k,l,c) = max(n(k,l,c).h) ; %
       
        if ( info.max(k,l,c)<epsilon)
	%	disp( '#($&#$@$#' )               
        end
        
        if ( info.npl(k,l,c) <  thr_npt_his )   % 
           %disp('insuf. number of point ')
           para_est(k,l,1:3) = 0;
           break;
        end
        
        n(k,l,c).h(end) = 0;
        n(k,l,c).h(1) = 0 ; 
  
        m = mode(bin) ;
	if ( m == 0 | isnan(m) )
		%disp(['ERROR in compute_illuminant_local.m: mode = 0 ; set ' ...
                 %     'to 3 '])
                m = 3;
	end

        lum_max(k,l,c) =  edges(m) ; %mode of the histogram

        n(k,l,c).h(m) = 0 ;     n(k,l,c).h(m+1) = 0 ;   n(k,l,c).h(m+2) = 0 ;   n(k,l,c).h(m+3) = 0 ;  
	if m>1 
           n(k,l,c).h(m-1) = 0 ; 	
	   if m>2 
         	n(k,l,c).h(m-2) = 0 ; 
		if m>3
          	   n(k,l,c).h(m-3) = 0; % 
	 	end 
	    end
         end
        
        % BUG in histc -  check : NECESSARY !!
        if (length(n(k,l,c).h) ~= length(edges))
          %disp('ERR: in compute_illuminant_L2.m: inconsistency here') ;
          dd = length(n(k,l,c).h) - length(edges) 
          if dd > 0
            n(k,l,c).h(end-dd+1:end) = [] ; % remove the end : arbitrary!
          end
        end 
        
        % condition  (opt.ill.fit>0) 
        if ( (opt.ill.fit>0) & (max(n(k,l,c).h)) )  
          
          tp = [];
          tp = edges(find(n(k, l,c).h==max(n(k,l,c).h))); %  mode, lum_max
          para_init(1) = tp(1) ; % center c, ie illuminant chromaticity
          para_init(2) = 1 ;    % decreasing factor l
          para_init(3) = max(n(k,l,c).h)  ;% pic 
          festim = [] ;
          [festim , fval, mess]= fminsearch(@vdm_funct_exp, para_init, fop, edges, ...
                            n(k,l,c).h');       
          
          if isempty(festim) 
	    disp('pble here')
          end
          if mess==1  % return output fminsearch ok
            para_est(k,l,c) = festim(1) ; 
          else 
             para_est(k,l,c) = lum_max(k,l,c) ;
          end

          if ( para_est(k,l,c)<min_c |  para_est(k,l,c)>1 )
                 para_est(k,l,c) = lum_max(k,l,c) ;
          end

        else
          % default assignement if no parametric fitting
  	  para_est(k,l,c) = lum_max(k,l,c);
       end
        
     end % end of c channnel
     
     % this takes out one channel zero valued color vector     
     if  prod(para_est(k,l,:))<epsilon
          para_est(k,l,:) = zeros(1,3);
     end   
   end
 end
 

 
