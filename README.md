
# Illuminant Chromaticity
<p>This directory contains reference code for the paper <a href="https://www.cs.huji.ac.il/labs/cglab/projects/illumest/Illuminant/iccv2013_illuminant.pdf" >"Illuminant Chromaticity from Image Sequences", Veronique Prinet, Dani Lischinski and Michael Werman, ICCV 2013</a>.</p> 

<p>The code is implemented in Matlab. Project page <a href='https://www.cs.huji.ac.il/labs/cglab/projects/illumest/Illuminant/'> here </a>.</p>


####  Matlab code 
 ----------
##### run
_matlab runDemo_OneIlluminant_vdm.m_

runDemo_OneIlluminant_vdm.m   estimates the chromaticity values of one global illuminant from the input sequence frames. 
Edit runDemo_OneIlluminant_vdm.m to modify the input data. 
Parameters of the approach are defined and instantiated in ./vdm_SingleLight/vdm_init_para_ill.m and ./vdm_SingleLight/vdm_init_para_prepro.m . 

##### run 
_matlab runDemo_TwoIlluminants_vdm.m_

 runDemo_TwoIlluminant_vdm.m   estimates the chromaticity values of two global illuminants from the input sequence frames. 
Edit runDemo_TwoIlluminant_vdm.m to modify the input data. 
Parameters of the approach are defined and instantiated in ./vdm_TwoLights/vdm_init_para_2ill.m and ./vdm_TwoLights/vdm_init_para_prepro.m . 

#### Preprequisit
 -----------

runDemo_OneIlluminant_vdm.m and  runDemo_TwoIlluminant_vdm.m require the preliminary installation of SIFTFlow and/or OpticalFlow as implemented by Liu's and al. You need to install the mex files from the vdm_Extern/OF   directory and vdm_Extern/SIFTflow directory, following instructions given by the readme.txt's . (equivalently you can directly download files from <a href="http://people.csail.mit.edu/celiu/OpticalFlow/" > here </a> and   <href="people.csail.mit.edu/celiu/SIFTflow/"> there </a>‎  )

#### Data format
-------------
Input data files (frames) are stored in directories vdm_TwoLights/Data/ and vdm_SingleLight/Data/ .
In order to use your own input data, (i) create a new directory (eg 'vdm_TwoLights/Data/mydir/') , (ii) place the new frames files into that directory. Frame files should be ordered in consecutive order , and indexed from n+1 to n+N , for an N frames sequence (eg: my_file_1.jpg , my_file_2.jpg, my_file_2.jpg , ...) ; (iii) edit runDemo_TwoIlluminants_vdm.m (or runDemo_OneIlluminants_vdm.m) and change the input directory name accordingly.
Note1:  input frame file format (.bmp, .jpg, .tif) should be specified in vdm_init_para_prepro.m (under ./vdm_TwoLights/ or /vdm_SingleLight/). Defaut value : '.bmp'. 
Note2 : if the first frame index does not start at 1, edit ./vdm_TwoLights/vdm_init_para_prepro.m (or ./vdm_SingleLight/vdm_init_para_prepro.m) and modify parameter 'init_count' appropriately (should be set to init_count=0 if index files starts at 1). Default value: 0.  