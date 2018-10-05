function mrtrix = mrtrix_cfg_tlbx

%--------------------------------------------------------------------------
% input input Image
%--------------------------------------------------------------------------
input         = cfg_files;
input.tag     = 'i';
input.name    = 'Input image';
input.help    = {'This is the input image.'};
input.ufilter = '.*\.nii(\.gz)';
input.num     = [1 1];
input.preview = @(f) spm_image('Display',char(f));

%--------------------------------------------------------------------------
% mask mask Image
%--------------------------------------------------------------------------
mask         = cfg_files;
mask.tag     = 'mask';
mask.name    = 'mask image';
mask.help    = {'This is the mask image.'};
mask.ufilter = '.*\.nii(\.gz)';
mask.num     = [1 1];
mask.preview = @(f) spm_image('Display',char(f));

%--------------------------------------------------------------------------
% output dir
%--------------------------------------------------------------------------
dir         = cfg_files;
dir.tag     = 'ofolder';
dir.name    = 'Output Directory';
dir.help    = {
    'output directory.'
    }';
dir.filter  = {'dir'};
dir.ufilter = '.*';
dir.num     = [1 1];

%--------------------------------------------------------------------------
% denoise dwidenoise
%--------------------------------------------------------------------------
dwidenoise         = cfg_exbranch;
dwidenoise.tag     = 'denoise';
dwidenoise.name    = 'dwidenoise';
dwidenoise.val     = {input dir};
dwidenoise.help    = {'Denoise DWI data and estimate the noise level based on the optimal threshold for PCA'
    '     DWI data denoising and noise map estimation by exploiting data redundancy'
    ' in the PCA domain using the prior knowledge that the eigenspectrum of'
    ' random covariance matrices is described by the universal Marchenko Pastur'
    ' distribution.'
    ''
    ' Important note: image denoising must be performed as the first step of the'
    ' image processing pipeline. The routine will fail if interpolation or'
    ' smoothing has been applied to the data prior to denoising.'
    ''
    'Note that this function does not correct for non-Gaussian noise biases.'
    }';
dwidenoise.prog = @(job) mrtrix_run('dwidenoise',job);
dwidenoise.vout = @sct_run_vout;

%--------------------------------------------------------------------------
% fslgrad fslgrad
%--------------------------------------------------------------------------
bvecs         = cfg_files;
bvecs.tag     = 'bvecs';
bvecs.name    = 'bvecs file';
bvecs.help    = {'This is the bvecs file in FSL format.'};
bvecs.ufilter = '.*.bvec';
bvecs.num     = [1 1];
bvals         = cfg_files;
bvals.tag     = 'bvals';
bvals.name    = 'bvals file';
bvals.help    = {'This is the bvals file in FSL format.'};
bvals.ufilter = '.*.bval';
bvals.num     = [1 1];

fslgrad         = cfg_branch;
fslgrad.tag     = 'fslgrad';
fslgrad.name    = 'fslgrad';
fslgrad.val     = {bvecs bvals};

%--------------------------------------------------------------------------
% biascorrect dwibiascorrect
%--------------------------------------------------------------------------
dwibiascorrect         = cfg_exbranch;
dwibiascorrect.tag     = 'biascorrect';
dwibiascorrect.name    = 'dwibiascorrect';
dwibiascorrect.val     = {input fslgrad dir};
dwibiascorrect.help    = {'Perform B1 field inhomogeneity correction for a DWI volume series.'
    }';
dwibiascorrect.prog = @(job) mrtrix_run('dwibiascorrect',job);
dwibiascorrect.vout = @sct_run_vout;

%--------------------------------------------------------------------------
% dwi2tensor dwi2tensor
%--------------------------------------------------------------------------
dwi2tensor         = cfg_exbranch;
dwi2tensor.tag     = 'dwi2tensor';
dwi2tensor.name    = 'dwi2tensor';
dwi2tensor.val     = {input mask fslgrad dir};
dwi2tensor.help    = {'Diffusion (kurtosis) tensor estimation using iteratively reweighted linear'
                      '  least squares estimator'
                      'The tensor coefficients are stored in the output image as follows:'
                      '  volumes 0-5: D11, D22, D33, D12, D13, D23 ;'
                      '  If diffusion kurtosis is estimated using the -dkt option, these are stored'
                      '  as follows:'
                      '  volumes 0-2: W1111, W2222, W3333 ; '
                      '  volumes 3-8: W1112, W1113, W1222, W1333, W2223, W2333 ; '
                      '  volumes 9-11: W1122, W1133, W2233 ; '
                      '  volumes 12-14: W1123, W1223, W1233 ;'
                         }';
dwi2tensor.prog = @(job) mrtrix_run('dwi2tensor',job);
dwi2tensor.vout = @sct_run_vout;

%--------------------------------------------------------------------------
% preproc dwipreproc
%--------------------------------------------------------------------------
pedir              = cfg_entry;
pedir.tag          = 'pe_dir';
pedir.name         = 'Phase encoding direction';
pedir.help         = {
                    'Automatically extracted from dwi metadata (PhaseEncodingAxis field)'
                    'OR'
                    'Manually specify the phase encoding direction of the input series; can be a'
                    '  an axis designator (e.g. RL, PA, IS),'
                    '  or NIfTI axis codes (e.g. i-, j, k)'
                    }';
                
dwipreproc         = cfg_exbranch;
dwipreproc.tag     = 'preproc';
dwipreproc.name    = 'dwipreproc';
dwipreproc.val     = {input fslgrad dir pedir};
dwipreproc.help    = {
    'Perform diffusion image pre-processing using FSL''s eddy tool; including'
    '  inhomogeneity distortion correction using FSL''s topup tool if possible'
    }';
dwipreproc.prog = @(job) mrtrix_run('dwipreproc',job);
dwipreproc.vout = @mrtrix_vout_dwipreproc;

%--------------------------------------------------------------------------
% tensor2metric tensor2metric
%--------------------------------------------------------------------------

tensor2metric         = cfg_exbranch;
tensor2metric.tag     = 'tensor2metric';
tensor2metric.name    = 'tensor2metric';
tensor2metric.val     = {input mask dir};
tensor2metric.help    = {
    'Generate maps of tensor-derived parameters'
    }';
tensor2metric.prog = @(job) mrtrix_run('tensor2metric',job);
tensor2metric.vout = @mrtrix_vout_tensor2metric;

%--------------------------------------------------------------------------
% dwi2mask dwi2mask
%--------------------------------------------------------------------------
dwi2mask         = cfg_exbranch;
dwi2mask.tag     = 'dwi2mask';
dwi2mask.name    = 'dwi2mask';
dwi2mask.val     = {input dir fslgrad};
dwi2mask.help    = {
    'Generate maps of tensor-derived parameters'
    }';
dwi2mask.prog = @(job) mrtrix_run('dwi2mask',job);
dwi2mask.vout = @sct_run_vout;

%--------------------------------------------------------------------------
% mrtrix MRtrix3
%--------------------------------------------------------------------------

mrtrix         = cfg_choice;
mrtrix.tag     = 'mrtrix';
mrtrix.name    = 'MRtrix3';
mrtrix.help    = {
    'Advanced tools for the analysis of diffusion MRI data'
    }';
mrtrix.values  = {dwidenoise dwibiascorrect dwipreproc dwi2tensor tensor2metric dwi2mask};

function dep = mrtrix_vout_dwipreproc(job)
dep = cfg_dep;
dep(1).sname      = sprintf('output file');
dep(1).src_output = substruct('.','o');
dep(1).tgt_spec   = cfg_findspec({{'class','cfg_files', 'strtype','e'}});
dep(2).sname      = sprintf('corrected bvec file');
dep(2).src_output = substruct('.','bvecs');
dep(2).tgt_spec   = cfg_findspec({{'class','cfg_files', 'strtype','e'}});
dep(3).sname      = sprintf('corrected bval file');
dep(3).src_output = substruct('.','bvals');
dep(3).tgt_spec   = cfg_findspec({{'class','cfg_files', 'strtype','e'}});

function dep = mrtrix_vout_tensor2metric(job)
met = {'adc','fa','ad','rd','vector'};
dep = cfg_dep;
for imet = 1:length(met)
    dep(imet).sname      = sprintf([met{imet} ' file']);
    dep(imet).src_output = substruct('.',met{imet});
    dep(imet).tgt_spec   = cfg_findspec({{'class','cfg_files', 'strtype','e'}});
end