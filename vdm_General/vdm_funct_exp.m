function sse=vdm_funct_exp(params,x, y)
  
A=params(3); % pic max 
lamda=params(2); % decreasing factor
C = params(1) ; % centerize

% Laplace distribution
Fitted_Curve=A .* exp(-lamda*abs(x-C));
Error_Vector=Fitted_Curve - y;

% minimize sse 
sse=sum(Error_Vector .^ 2) ;
