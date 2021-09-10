function   synth2 = vdm_synt_map(alpha, X)
  
    % regenerate the image
      synth2 = [];
      synth2(:,:,1) = alpha * X(1,1) + (1-alpha) * X(2,1) ; 
      synth2(:,:,2) = alpha * X(1,2) + (1-alpha) * X(2,2) ; 
      synth2(:,:,3) = alpha * X(1,3) + (1-alpha) * X(2,3) ; 
      synth2 = synth2 ./ repmat(sum(synth2,3),[1 1 3]) ;
