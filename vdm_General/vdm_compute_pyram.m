function p_output = vdm_compute_pyram(p_input, sig, max_level) 
  
  p_input = double(p_input) ;
  [dix,diy, dic] = size(p_input) ;
  if nargin<3
      max_level = floor(min(log2(dix), log2(diy))) ;
  end
  
  sigm = 1 ;
  h = fspecial('gaussian',round(4*sigm), sigm) ;
  
  p_output(1).im = p_input ;
  p_output = vdm_pyramid(p_output, sig, 1, h, max_level);
