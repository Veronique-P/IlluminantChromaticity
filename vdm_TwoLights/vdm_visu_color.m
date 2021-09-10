function vdm_visu_color( rgb , gam)

n = rgb(1) + rgb(2) + rgb(3) ;

if nargin==1
  gam = 1 ;
end

n=1;

color_patch(:,:,1) = repmat(rgb(1), [100,100,1]) ;
color_patch(:,:,2) = repmat(rgb(2), [100,100,1]) ;
color_patch(:,:,3) = repmat(rgb(3), [100,100,1]) ;

color_patch = color_patch.^gam ;
color_patch = color_patch ./ repmat(sum(color_patch,3),[1 1 3]) ;

color_patch(1,1,:);

color_gray(:,:,1) = repmat(0.333, [25,25,1]) ;
color_gray(:,:,2) = repmat(0.333, [25,25,1]) ;
color_gray(:,:,3) = repmat(0.333, [25,25,1]) ;

figure, imagesc(color_patch)
hold 
imagesc(color_gray)
