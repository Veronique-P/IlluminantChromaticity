function A=vdm_getLaplacian1_ada(I,consts,epsilon,win_size_hw);
  
  if (~exist('epsilon','var'))
    epsilon=0.0000001;
  end  
  if (isempty(epsilon))
    epsilon=0.0000001;
  end
  if (~exist('win_size','var'))
    win_size=1;
  end     
  if (isempty(win_size))
    win_size=1;
  end     

  win_size_h = win_size_hw(1);
  win_size_w =  win_size_hw(2);
 neb_size=(win_size_h*2+1)*(win_size_w*2+1);
 
  [h,w,c]=size(I);
  n=h; m=w;
  img_size=w*h;
  consts=imerode(consts,ones(win_size_h*win_size_w+1));
  
  indsM=reshape([1:img_size],h,w);

  tlen=sum(sum(1-consts((win_size_h+1):(end-win_size_h),(win_size_w+1):(end-win_size_w))))*(neb_size^2);

 
  row_inds=zeros(tlen ,1);
  col_inds=zeros(tlen,1);
  vals=zeros(tlen,1);
  len=0;

  for j=1+win_size_w:w-win_size_w
   for i=win_size_h+1:h-win_size_h
      if (consts(i,j))
        continue
      end  
      win_inds=indsM(i-win_size_h:i+win_size_h,j-win_size_w:j+win_size_w);
     
      win_inds=win_inds(:);
      winI=I(i-win_size_h:i+win_size_h,j-win_size_w:j+win_size_w,:);
      
      winI=reshape(winI,neb_size,c);
      win_mu=mean(winI,1)';
      win_var=inv(winI'*winI/neb_size-win_mu*win_mu' +epsilon/neb_size*eye(c));
      
      winI=winI-repmat(win_mu',neb_size,1);
      tvals=(1+winI*win_var*winI')/neb_size;
      
      row_inds(1+len:neb_size^2+len)=reshape(repmat(win_inds,1,neb_size),...
                                             neb_size^2,1);
      col_inds(1+len:neb_size^2+len)=reshape(repmat(win_inds',neb_size,1),...
                                             neb_size^2,1);
      vals(1+len:neb_size^2+len)=tvals(:);
      len=len+neb_size^2;
    end
  end  
    
  vals=vals(1:len);
  row_inds=row_inds(1:len);
  col_inds=col_inds(1:len);
  
  A=sparse(row_inds,col_inds,vals,img_size,img_size);
  sumA=sum(A,2); %
  
  A=spdiags(sumA(:),0,img_size,img_size)-A;
  
return


