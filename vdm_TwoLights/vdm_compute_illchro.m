function X = vdm_compute_illchro(lum, alpha, info, optiosn) 
  
    reg.lambda = 0 ;
    reg.beta = 0 ;
    
    chrom = vdm_lsq_lchr_est(lum, alpha, info.npl>0, reg.lambda, reg.beta) ;
    X = chrom ./ max(repmat(sum(chrom,2),[1 3]), 1.e-6);
    X(chrom<1.e-6) = 0 ;