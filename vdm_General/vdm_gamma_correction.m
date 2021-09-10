function out = vdm_gamma_correction(indata, gam, bx, by)
% Gamma correction to linearise the input

 % indata is normalised : max(indata(:),im(:))<=1 
 [dim_x dim_y dim_c] = size(indata(1).im) ;

 if nargin<=2
	bx(1) = 1 ; bx(2) = dim_x ;
	by(1) = 1 ; by(2) = dim_y ;
 end

 for i=1:length(indata)
    out(i).im =  ( indata(i).im(bx(1):bx(2),by(1):by(2),:) ).^gam;  % 
 end


