function o_par = vdm_init_para_siftflow(i_par)
  
  c = 255 ;
  
  if  (~exist('i_par','var') | isempty(i_par)  | ~isfield(i_par,'siftfflow')  ) 
    if (exist('i_par','var') | ~isempty(i_par)  )
      o_par = i_par ;
    end

    o_par.siftflow.alpha=2*c;
    o_par.siftflow.d=40*c;
    o_par.siftflow.gamma=0.005*c;
    o_par.siftflow.nlevels=4;
    o_par.siftflow.wsize=2;
    o_par.siftflow.topwsize=10;
    o_par.siftflow.nTopIterations = 60;
    o_par.siftflow.nIterations= 30;
    
  else
    o_par = i_par ;
    
    if ~isfield(i_par.siftfflow,'alpha')
      o_par.siftflow.alpha=2*c;
    end
    if ~isfield(i_par.siftfflow,'d')
      o_par.siftflow.d=40*c;
    end
    if ~isfield(i_par.siftfflow,'gamma')
      o_par.siftflow.gamma=0.005*c;
    end    
    if ~isfield(i_par.siftfflow,'nlevels')
      o_par.siftflow.nlevels=4;
    end    
    if ~isfield(i_par.siftfflow,'wsize')
      o_par.siftflow.wsize=2;
    end    
    if ~isfield(i_par.siftfflow,'topwsize')
    o_par.siftflow.topwsize=10;
    end    
   if ~isfield(i_par.siftfflow,'nTopIterations')
    o_par.siftflow.nTopIterations = 60;
    end    
   if ~isfield(i_par.siftfflow,'nIterations')
    o_par.siftflow.nIterations= 30;
    end    
    
  end
  