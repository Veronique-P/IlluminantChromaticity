function  [data meta]= vdm_read_video_from_dir(mydir, myname, initcount, file_name_extension)
%  mydir
%  myname
 % file_name_extension
 list = dir(strcat(mydir,'/*',file_name_extension)) ; % 
  %list
 nbfile = size(list,1) ;   %
 for i=1:nbfile
     namef= list(i).name ;  % 
    str = strcat(mydir, myname,int2str(i+initcount),file_name_extension)  ; %
    eval('img = imread(str);') ;
    data(i).im = (double(img) + 1 ) / 256.0 ; % 
    data(i).name = strcat(myname,int2str(i),file_name_extension) ;
    data(i).size = size(img) ;
 end


  meta.nb_frame = length(data) ;
  [meta.dim_x meta.dim_y meta.dim_c] = size(data(1).im) ;
  meta.npts = meta.dim_x * meta.dim_y ;
  