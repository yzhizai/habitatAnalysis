function filenames =  image_deform(filenames, mskFile)
% List of open inputs
% Deformations: Image to base Id on - cfg_files
% Deformations: Apply to - cfg_files
nrun = 1; % enter the number of runs here
srcFile = mfilename('fullpath');
jobfile = {[srcFile, '_job.m']};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);
for crun = 1:nrun
    inputs{1, crun} = {mskFile}; % Deformations: Image to base Id on - cfg_files
    inputs{2, crun} = filenames; % Deformations: Apply to - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});

filenames = cellfun(@rename, filenames, 'UniformOutput' ,false);

end

function newName =  rename(filename)
    [pat, tit, ext] = fileparts(filename);
    
    newName = fullfile(pat, ['w', tit, ext]); 
end