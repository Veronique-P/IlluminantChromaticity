function out_vect = vdm_normalize(in_vect, dim)
  
  epsilon = 1.e-6 ;
  if  nargin<2
   dim=1;
  end

  if (dim==1)
    out_vect =  in_vect ./ repmat(max(sum(in_vect), epsilon), [1,3]) ;
  else 
    out_vect =  in_vect ./ repmat(max(sum(in_vect,3), epsilon), [1,1,3]) ;
  end
          
