function cfg_run_supervoxels(job)

filenames = job.paramFile;
maskFile = job.maskFile{1};
numSeg = job.segNum;


filenames = image_deform(filenames, maskFile);
maskFile = image_deform({maskFile}, maskFile);
maskFile = maskFile{1};


mask = niftiread(maskFile);
mask(mask < 0.5) = 0;
info_mask = niftiinfo(maskFile);

V = [];
for i_a =1:numel(filenames)
    filename = filenames{i_a};
    
    i_V = niftiread(filename);
    i_V(mask == 0) = 0;
    
    V = cat(4, V, i_V);
end

L = imsegkmeans3(V, numSeg + 1); % add 1 to identify background
L(L == 1) = NaN;
L = L - 1;

values = zeros(numSeg, numel(filenames));
varNames = {};
for i_a = 1:numel(filenames)
    filename = filenames{i_a};
    [pat, tit, ext] = fileparts(filename);
    tit_cell = strsplit(tit,  '_');
    i_V = niftiread(filename);  
    
    i_values = zeros(numSeg, 1);
    for i_label = 1:numSeg
        i_values(i_label) = mean(i_V(L == i_label));
    end
    i_values = reshape(i_values, [], 1);
    values(:, i_a) = i_values;
    varNames{i_a} = tit_cell{2};
end

tbl = array2table(values);
tbl.Properties.VariableNames = varNames;



img_L = strrep(maskFile, '.nii', '-supervoxels.nii');
niftiwrite(int16(L), img_L, info_mask);

tbl.Label = (1:numSeg)';
tbl.ID = repmat(img_L, numSeg, 1);
outputParam = strrep(maskFile, '.nii', '.csv');
writetable(tbl, outputParam);



