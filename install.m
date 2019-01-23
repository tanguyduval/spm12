% run to install
spmpath = fileparts(mfilename('fullpath'));
addpath(spmpath)
addpath(fullfile(spmpath,'spm12'))
addpath(fullfile(spm('Dir'),'matlabbatch'));
addpath(fullfile(spm('Dir'),'matlabbatch','cfg_basicio'));
addpath(fullfile(spm('Dir'),'config'));
addpath(genpath(fullfile(spm('Dir'),'external')));
addpath(genpath(fullfile(spmpath,'apps')));

% Default app folder location
defaultappfname = fullfile(spmpath,'apps_savepath.txt');
if ~exist(defaultappfname,'file')
    fid = fopen(defaultappfname,'w');
    fprintf(fid,'%s',fullfile(spmpath,'apps'));
    fclose(fid);
end

% Add Boutiques
directory = textread(defaultappfname,'%s');
if exist(fullfile(directory{1},'Boutiques'),'dir')
    copyfile(which('cfg_mlbatch_appcfg_Boutiques.m'),fullfile(directory{1},'Boutiques','cfg_mlbatch_appcfg.m'))
end

% init 
cfg_util('initcfg')
