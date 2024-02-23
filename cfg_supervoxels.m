function exbr1 = cfg_supervoxels

paramFiles = cfg_files;
paramFiles.name = 'Choose param files';
paramFiles.tag = 'paramFile';
paramFiles.num = [0 Inf];
paramFiles.help = {'Choose param files', 'All parameter files used to identify the tumor habitat.'};

maskFiles = cfg_files;
maskFiles.name = 'Choose Mask file';
maskFiles.tag = 'maskFile';
maskFiles.num = [0, 1];
maskFiles.help = {'Choose Mask file', 'Chose the ROI image'};

segNum = cfg_entry;
segNum.name = 'The number of supervoxels';
segNum.tag = 'segNum';
segNum.num = [1, 1];
segNum.strtype = 'n';
segNum.help = {'Specify the number of supervoxel to segment'};


exbr1 = cfg_exbranch;
exbr1.name = 'Supervoxels segmentation';
exbr1.tag = 'cfg_supervoxels';
exbr1.val = {paramFiles, maskFiles, segNum};
exbr1.prog = @cfg_run_supervoxels;
exbr1.help = {'Supervoxels segmentation'};