function QC = cfg_QC(varargin)

% ---------------------------------------------------------------------
% nii nii
% ---------------------------------------------------------------------
nii         = cfg_files;
nii.tag     = 'nifti';
nii.name    = 'NIFTI file';
nii.help = {'Select one or multiple nifti resliced files images (same space, same matrix size)'};
nii.num     = [0 Inf];
% ---------------------------------------------------------------------
% nii nii
% ---------------------------------------------------------------------
mask         = cfg_files;
mask.tag     = 'mask';
mask.name    = 'Mask file';
mask.val     = {''};
mask.num     = [0 1];
% ---------------------------------------------------------------------
% imtool3D imtool3D
% ---------------------------------------------------------------------
imtool3D         = cfg_exbranch;
imtool3D.tag     = 'imtool3D';
imtool3D.name    = 'imtool3D';
imtool3D.val     = {nii mask};
imtool3D.prog = @(job) imtool3D_nii(job.nifti,[],job.mask{1});
imtool3D.help = {'NIFTI viewer with ROI tools and statistics'};

% ---------------------------------------------------------------------
% QC QC
% ---------------------------------------------------------------------
imtool3D         = cfg_exbranch;
imtool3D.tag     = 'html';
imtool3D.name    = 'html quality control report';
imtool3D.val     = {nii mask};
imtool3D.prog = @(job) imtool3D_nii(job.nifti,[],job.mask{1});
imtool3D.help = {'NIFTI viewer with ROI tools and statistics'};

% ---------------------------------------------------------------------
% QC QC
% ---------------------------------------------------------------------
QC         = cfg_choice;
QC.tag     = 'QC';
QC.name    = 'Quality Control';
QC.values  = {imtool3D};