
function o_par = vdm_init_para_flow(i_par)

  % set optical flow parameters 
  if  (~exist('i_par','var') | isempty(i_par)  | ~isfield(i_par,'flow') ...
       ) 
    if (exist('i_par','var') | ~isempty(i_par)  )
      o_par = i_par ;
    end
    
    o_par.flow.alpha = 0.012;             % alpha (1), the regularization weight
    o_par.flow.ratio = 0.75;                % ratio (0.5), the downsample ratio
    o_par.flow.minWidth = 20;            %minWidth (40), the width of the coarsest level
    o_par.flow.nOuterFPIterations = 7;
    o_par.flow.nInnerFPIterations = 1;
    o_par.flow.nSORIterations = 30;
  else
    o_par = i_par ;
    if ~isfield(i_par.flow,'alpha')
        o_par.flow.alpha = 0.012;             
    end
    if ~isfield(i_par.flow,'ratio')
      o_par.flow.ratio = 0.75;  
    end
    if ~isfield(i_par.flow,'minWidth')
     o_par.flow.minWidth = 20;   
    end    
    if ~isfield(i_par.flow,'nOuterFPIterations')
    o_par.flow.nOuterFPIterations = 7;
    end    
    if ~isfield(i_par.flow,'nInnerFPIterations')
      o_par.flow.nInnerFPIterations = 1;
    end    
    if ~isfield(i_par.flow,'nSORIterations')
      o_par.flow.nSORIterations = 30;
    end    
  end
  
