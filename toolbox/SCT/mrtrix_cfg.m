function mrtrix = mrtrix_cfg

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
dwi2tensor.val     = {input fslgrad dir};
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
dwipreproc         = cfg_exbranch;
dwipreproc.tag     = 'preproc';
dwipreproc.name    = 'dwipreproc';
dwipreproc.val     = {input fslgrad dir};
dwipreproc.help    = {
    'Perform diffusion image pre-processing using FSL''s eddy tool; including'
    '  inhomogeneity distortion correction using FSL''s topup tool if possible'
    }';
dwipreproc.prog = @(job) mrtrix_run('dwipreproc',job);
dwipreproc.vout = @sct_run_vout;

%--------------------------------------------------------------------------
% mrtrix MRtrix3
%--------------------------------------------------------------------------

mrtrix         = cfg_choice;
mrtrix.tag     = 'mrtrix';
mrtrix.name    = 'MRtrix3';
mrtrix.help    = {
    'Advanced tools for the analysis of diffusion MRI data'
    }';
mrtrix.values  = {dwidenoise dwibiascorrect dwipreproc dwi2tensor};
