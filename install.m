% run to install
spmpath = fileparts(mfilename('fullpath'));
addpath(spmpath)
addpath(fullfile(spmpath,'spm12'))
addpath(fullfile(spm('Dir'),'matlabbatch'));
addpath(fullfile(spm('Dir'),'matlabbatch','cfg_basicio'));
addpath(fullfile(spm('Dir'),'config'));
addpath(genpath(fullfile(spm('Dir'),'external')));
addpath(genpath(fullfile(spmpath,'apps')));
cfg_util('initcfg')

% Default app folder location
defaultappfname = fullfile(spmpath,'apps_savepath.txt');
if ~exist(defaultappfname,'file')
    fid = fopen(defaultappfname,'w');
    fprintf(fid,'%s',fullfile(spmpath,'apps'));
    fclose(fid);
end
