function [ooutput SA] = interpol_lum_s1(indata, conf_p, conf_n)
 % s_Lum = interpol_lum_s1(Lum, 1*(npl(:,:,1)>200)) ;
 %  s_Lum = interpol_lum_s1(Lum, 1*(Lum(:,:,1)>0)) ;

   ooutput = [];
   SA = [];
 
   [lm,ln,lc] = size(indata) ;
   
   lam = 0.1;
   delta = 1 ;
   
   rf =  conf_p(:) ./ max(conf_p(:)); % should have a robust function instead
 
    rf_b = (1 - rf)  ; % conf_n(:);
   %rf_b = max((1-rf),lam);
   
   Di =  rf - (4*rf_b) ;
    
   SA = spdiags([Di, rf_b, rf_b, rf_b, rf_b], [0, -lm, -1, 1, lm], lm*ln, ...
                lm*ln);
   SA = SA';
   
   lu = reshape(indata,[lm*ln,lc]) ;

   output= SA \ (repmat(rf,[1 lc]).*lu);
 
   ooutput = reshape(output, [lm,ln,lc]) ;   
   
   
