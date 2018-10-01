function sct = sct_cfg

%--------------------------------------------------------------------------
% input input Image
%--------------------------------------------------------------------------
input         = cfg_files;
input.tag     = 'i';
input.name    = 'Input image';
input.help    = {'This is the input image.'};
input.filter  = 'image';
input.ufilter = '.*';
input.num     = [1 1];
input.preview = @(f) spm_image('Display',char(f));


%--------------------------------------------------------------------------
% Output dir
%--------------------------------------------------------------------------
dir         = cfg_files;
dir.tag     = 'ofolder';
dir.name    = 'Directory';
dir.help    = {
    'output directory.'
    }';
input.filter  = 'dir';
dir.num     = [1 1];

%--------------------------------------------------------------------------
% Output filename
%--------------------------------------------------------------------------
filename         = cfg_entry;
filename.tag     = 'filename';
filename.name    = 'Filename';
filename.help    = {
    'output image.'
    }';
filename.num     = [1 Inf];
filename.strtype = 's';

%--------------------------------------------------------------------------
% Output filename
%--------------------------------------------------------------------------
output         = cfg_branch;
output.tag     = 'o';
output.name    = 'Output';
output.val     = {dir filename };

%--------------------------------------------------------------------------
% crop sct_crop_image
%--------------------------------------------------------------------------

sct_crop_image         = cfg_exbranch;
sct_crop_image.tag     = 'crop';
sct_crop_image.name    = 'sct_crop_image';
sct_crop_image.val     = {input output};
sct_crop_image.help    = {
    'Tools to crop an image. Either through command line or GUI'
    }';
sct_crop_image.prog = @(job) sct_run('sct_crop_image',job);
sct_crop_image.vout = @sct_run_vout;
%--------------------------------------------------------------------------
% contrast Contrast type
%--------------------------------------------------------------------------
contrast         = cfg_menu;
contrast.tag     = 'c';
contrast.name    = 'Contrast type';
contrast.help    = {
                  'Choose the contrast.'
                  }';
contrast.labels = {
                 't1'
                 't2'
                 't2s'
                 'dwi'
                 }';
contrast.values = {
                 't1'
                 't2'
                 't2s'
                 'dwi'
                 }';
%--------------------------------------------------------------------------
% seg sct_deepseg_sc
%--------------------------------------------------------------------------

sct_deepseg_sc         = cfg_exbranch;
sct_deepseg_sc.tag     = 'seg';
sct_deepseg_sc.name    = 'sct_deepseg_sc';
sct_deepseg_sc.val     = {input dir contrast};
sct_deepseg_sc.help    = {
    'Tools to segment the spinal cord.'
    }';
sct_deepseg_sc.prog = @(job) sct_run('sct_deepseg_sc',job);
sct_deepseg_sc.vout = @sct_run_vout;

%--------------------------------------------------------------------------
% sct sct_toolbox
%--------------------------------------------------------------------------

sct         = cfg_choice;
sct.tag     = 'sct';
sct.name    = 'Spinal Cord Toolbox';
sct.help    = {
    'Process Spinal Cord'
    }';
sct.values  = {sct_crop_image sct_deepseg_sc};
