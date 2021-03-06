
# Illuminant Chromaticity
<p>This directory contains reference code for the paper <a href="https://www.cs.huji.ac.il/labs/cglab/projects/illumest/Illuminant/iccv2013_illuminant.pdf" >"Illuminant Chromaticity from Image Sequences", Veronique Prinet, Dani Lischinski and Michael Werman, ICCV 2013</a>.</p> 

<p>The code is implemented in Matlab. Project page <a href='https://www.cs.huji.ac.il/labs/cglab/projects/illumest/Illuminant/'> here </a>.</p>


### Usage 
 ----------
##### run
```
matlab runDemo_OneIlluminant_vdm.m
```

`runDemo_OneIlluminant_vdm.m`   estimates the chromaticity values of one global illuminant from the input sequence frames. 
Edit `runDemo_OneIlluminant_vdm.m` to modify the input data. 
Parameters of the approach are defined and instantiated in ./vdm_SingleLight/`vdm_init_para_ill.m` and ./vdm_SingleLight/`vdm_init_para_prepro.m` . 

##### run 
```
matlab runDemo_TwoIlluminants_vdm.m
```

 `runDemo_TwoIlluminant_vdm.m`   estimates the chromaticity values of two global illuminants from the input sequence frames. 
Edit `runDemo_TwoIlluminant_vdm.m` to modify the input data. 
Parameters of the approach are defined and instantiated in ./vdm_TwoLights/`vdm_init_para_2ill.m` and ./vdm_TwoLights/`vdm_init_para_prepro.m` . 

### Preprequisit
 -----------

`runDemo_OneIlluminant_vdm.m` and  `runDemo_TwoIlluminant_vdm.m` require the preliminary installation of _SIFTFlow_ and/or _OpticalFlow_ as implemented by <a href="http://people.csail.mit.edu/celiu/"> Ce Liu's and al</a> . You need to install the mex files from the `./vdm_Extern/OF`   directory and `./vdm_Extern/SIFTflow` directory, following instructions given by the `readme.txt`'s . (equivalently you can directly download files from <a href="http://people.csail.mit.edu/celiu/OpticalFlow/" > here </a> and   <a href="people.csail.mit.edu/celiu/SIFTflow/"> there</a>).

### Data format
-------------

- Input data files (frames) are stored in directories `./vdm_TwoLights/Data/` and `./vdm_SingleLight/Data/` .
- In order to use your own input data: 
  -  create a new directory (eg `./vdm_TwoLights/Data/mydir/`) , 
  - place the new frames files into that directory. Frame files should be ordered in consecutive order , and indexed from n+1 to n+N , for an N frames sequence (eg: my_file_1.jpg , my_file_2.jpg, my_file_2.jpg , ...) ; 
  - edit `runDemo_TwoIlluminants_vdm.m` (or `runDemo_OneIlluminants_vdm.m`) and change the input directory name accordingly.


> Note 1:  input frame file format (.bmp, .jpg, .tif) should be specified in `vdm_init_para_prepro.m` (under `./vdm_TwoLights/` or `./vdm_SingleLight/`). Defaut value: '.bmp'. 

> Note 2 : if the first frame index does not start at 1, edit `./vdm_TwoLights/vdm_init_para_prepro.m` (or `./vdm_SingleLight/vdm_init_para_prepro.m`) and modify parameter _'init_count'_ appropriately (should be set to init_count=0 if index files starts at 1). Default value: 0.  


### Citation
-----------
If you use this code, please cite it:
```
@InProceedings{vdm_iccv2013,
	author  = {V. Prinet and D. Lischinski and M. Werman},
	title   = {Illuminant Chromaticity from Image Sequences},
	journal = {International Conference on Computer Vision (ICCV)},
	year    = {2013},
	month   = {December}}
```
