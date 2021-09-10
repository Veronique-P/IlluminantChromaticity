function Lchr = vdm_lsq_lchr_est(in_data, alpha, i_w, beta, lam) 
  
  % indata normalised 
  [lm, ln, lc] =  size(in_data) ;
  lmn = lm*ln ;
  
  M = spdiags(i_w(:),0, lmn, lmn) ;
  W = [alpha(:) , (1-alpha(:))]' ;
  K =  reshape(in_data,[lmn,lc] );
  
  
  Q = W * M * K ;  
  R = W * M * W' ;
  C = lam .* diag(ones([2,1]));
  S = beta * ones(2,3) ;
  T = inv( R + C )  ;
  U = (Q + S);
  
  Lchr = T * U ;
 % Lchr = T * Q ; 
