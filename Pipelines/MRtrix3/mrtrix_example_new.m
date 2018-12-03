%-----------------------------------------------------------------------
% Job saved on 17-Oct-2018 13:32:14 by cfg_util (rev $Rev: 6942 $)
% mrtrix mrtrix3 - Unknown
% sct Spinal Cord Toolbox - Unknown
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
% fsl FSL - Unknown
% system System - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.parent = {'F:\STEMRI_NIFTI_RAW'};
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.bids_ses = 1;
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.name = 'mrtrix3';
matlabbatch{2}.system.mrtrix3.dwidenoise.inputs_{1}.anyfilebranch.help = '4D dwi: the input diffusion-weighted image';
matlabbatch{2}.system.mrtrix3.dwidenoise.inputs_{1}.anyfilebranch.anyfile(1) = cfg_dep('Parse BIDS Directory: dwi: dwi', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dwi_dwi'));
matlabbatch{2}.system.mrtrix3.dwidenoise.outputs_{1}.outputs.help = '4D dwi: the output denoised DWI image';
matlabbatch{2}.system.mrtrix3.dwidenoise.outputs_{1}.outputs.directory(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{2}.system.mrtrix3.dwidenoise.outputs_{1}.outputs.string = 'dwi_denoised.nii';
matlabbatch{2}.system.mrtrix3.dwidenoise.cmd = 'dwidenoise -force i1 o1';
matlabbatch{2}.system.mrtrix3.dwidenoise.usedocker_.dockerimg = 'bids/mrtrix3_connectome';
matlabbatch{3}.system.fsl.eddy_correct.inputs_{1}.anyfilebranch.help = '4D dwi: the input diffusion-weighted image';
matlabbatch{3}.system.fsl.eddy_correct.inputs_{1}.anyfilebranch.anyfile(1) = cfg_dep('dwidenoise: dwidenoise: output 1 - dwi_denoised.nii', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outputs', '{}',{1}));
matlabbatch{3}.system.fsl.eddy_correct.inputs_{2}.evaluatedbranch.help = 'reference number: volume that will be used as a reference for the registration';
matlabbatch{3}.system.fsl.eddy_correct.inputs_{2}.evaluatedbranch.evaluated = 1;
matlabbatch{3}.system.fsl.eddy_correct.inputs_{3}.stringbranch.help = 'interpolation: Choose interp from {trilinear,spline}';
matlabbatch{3}.system.fsl.eddy_correct.inputs_{3}.stringbranch.string = 'trilinear';
matlabbatch{3}.system.fsl.eddy_correct.outputs_{1}.outputs.help = '4D dwi: the output eddy corrected DWI image';
matlabbatch{3}.system.fsl.eddy_correct.outputs_{1}.outputs.directory(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{3}.system.fsl.eddy_correct.outputs_{1}.outputs.string = 'dwi_eddy.nii';
matlabbatch{3}.system.fsl.eddy_correct.cmd = 'eddy_correct i1 o1 i2 i3';
matlabbatch{3}.system.fsl.eddy_correct.usedocker_.dockerimg = 'bids/mrtrix3_connectome';
matlabbatch{4}.system.mrtrix3.dwi2mask.inputs_{1}.anyfilebranch.help = '4D dwi: the input diffusion-weighted image';
matlabbatch{4}.system.mrtrix3.dwi2mask.inputs_{1}.anyfilebranch.anyfile(1) = cfg_dep('eddy_correct: eddy_correct: output 1 - dwi_eddy.nii', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outputs', '{}',{1}));
matlabbatch{4}.system.mrtrix3.dwi2mask.inputs_{2}.anyfilebranch.help = 'bvecs file (in FSL format)';
matlabbatch{4}.system.mrtrix3.dwi2mask.inputs_{2}.anyfilebranch.anyfile(1) = cfg_dep('Parse BIDS Directory: dwi: bvec', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dwi_bvec'));
matlabbatch{4}.system.mrtrix3.dwi2mask.inputs_{3}.anyfilebranch.help = 'bvals file (in FSL format)';
matlabbatch{4}.system.mrtrix3.dwi2mask.inputs_{3}.anyfilebranch.anyfile(1) = cfg_dep('Parse BIDS Directory: dwi: bval', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dwi_bval'));
matlabbatch{4}.system.mrtrix3.dwi2mask.outputs_{1}.outputs.help = '3D Mask: the output whole-brain mask image';
matlabbatch{4}.system.mrtrix3.dwi2mask.outputs_{1}.outputs.directory(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{4}.system.mrtrix3.dwi2mask.outputs_{1}.outputs.string = 'mask_brain.nii.gz';
matlabbatch{4}.system.mrtrix3.dwi2mask.cmd = 'dwi2mask -fslgrad i2 i3 i1 o1';
matlabbatch{4}.system.mrtrix3.dwi2mask.usedocker_.dockerimg = 'bids/mrtrix3_connectome';
matlabbatch{5}.system.mrtrix3.dwi2tensor.inputs_{1}.anyfilebranch.help = '4D dwi: the input diffusion-weighted image';
matlabbatch{5}.system.mrtrix3.dwi2tensor.inputs_{1}.anyfilebranch.anyfile(1) = cfg_dep('eddy_correct: eddy_correct: output 1 - dwi_eddy.nii', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outputs', '{}',{1}));
matlabbatch{5}.system.mrtrix3.dwi2tensor.inputs_{2}.anyfilebranch.help = 'bvecs file (in FSL format)';
matlabbatch{5}.system.mrtrix3.dwi2tensor.inputs_{2}.anyfilebranch.anyfile(1) = cfg_dep('Parse BIDS Directory: dwi: bvec', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dwi_bvec'));
matlabbatch{5}.system.mrtrix3.dwi2tensor.inputs_{3}.anyfilebranch.help = 'bvals file (in FSL format)';
matlabbatch{5}.system.mrtrix3.dwi2tensor.inputs_{3}.anyfilebranch.anyfile(1) = cfg_dep('Parse BIDS Directory: dwi: bval', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dwi_bval'));
matlabbatch{5}.system.mrtrix3.dwi2tensor.inputs_{4}.anyfilebranch.help = '3D Mask';
matlabbatch{5}.system.mrtrix3.dwi2tensor.inputs_{4}.anyfilebranch.anyfile(1) = cfg_dep('dwi2mask: dwi2mask: output 1 - mask_brain.nii.gz', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outputs', '{}',{1}));
matlabbatch{5}.system.mrtrix3.dwi2tensor.outputs_{1}.outputs.help = '3D Diffusion Tensor';
matlabbatch{5}.system.mrtrix3.dwi2tensor.outputs_{1}.outputs.directory(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{5}.system.mrtrix3.dwi2tensor.outputs_{1}.outputs.string = 'tensor.nii';
matlabbatch{5}.system.mrtrix3.dwi2tensor.cmd = 'dwi2tensor -fslgrad i2 i3 -mask i4 i1 o1';
matlabbatch{5}.system.mrtrix3.dwi2tensor.usedocker_.dockerimg = 'bids/mrtrix3_connectome';
matlabbatch{6}.cfg_basicio.file_dir.dir_ops.cfg_mkdir.parent(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{6}.cfg_basicio.file_dir.dir_ops.cfg_mkdir.name = 'tensorfit';
matlabbatch{7}.system.mrtrix3.tensor2metric.inputs_{1}.anyfilebranch.help = '4D dwi: the input diffusion-weighted image';
matlabbatch{7}.system.mrtrix3.tensor2metric.inputs_{1}.anyfilebranch.anyfile(1) = cfg_dep('dwi2tensor: dwi2tensor: output 1 - tensor.nii', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outputs', '{}',{1}));
matlabbatch{7}.system.mrtrix3.tensor2metric.inputs_{2}.anyfilebranch.help = '3D Mask';
matlabbatch{7}.system.mrtrix3.tensor2metric.inputs_{2}.anyfilebranch.anyfile(1) = cfg_dep('dwi2mask: dwi2mask: output 1 - mask_brain.nii.gz', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outputs', '{}',{1}));
matlabbatch{7}.system.mrtrix3.tensor2metric.outputs_{1}.outputs.help = 'ADC image';
matlabbatch{7}.system.mrtrix3.tensor2metric.outputs_{1}.outputs.directory(1) = cfg_dep('Make Directory: Make Directory ''tensorfit''', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dir'));
matlabbatch{7}.system.mrtrix3.tensor2metric.outputs_{1}.outputs.string = 'adc.nii';
matlabbatch{7}.system.mrtrix3.tensor2metric.outputs_{2}.outputs.help = 'FA image';
matlabbatch{7}.system.mrtrix3.tensor2metric.outputs_{2}.outputs.directory(1) = cfg_dep('Make Directory: Make Directory ''tensorfit''', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dir'));
matlabbatch{7}.system.mrtrix3.tensor2metric.outputs_{2}.outputs.string = 'fa.nii';
matlabbatch{7}.system.mrtrix3.tensor2metric.outputs_{3}.outputs.help = 'AD image: axial diffusivity';
matlabbatch{7}.system.mrtrix3.tensor2metric.outputs_{3}.outputs.directory(1) = cfg_dep('Make Directory: Make Directory ''tensorfit''', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dir'));
matlabbatch{7}.system.mrtrix3.tensor2metric.outputs_{3}.outputs.string = 'ad.nii';
matlabbatch{7}.system.mrtrix3.tensor2metric.outputs_{4}.outputs.help = 'RD image: radial diffusivity';
matlabbatch{7}.system.mrtrix3.tensor2metric.outputs_{4}.outputs.directory(1) = cfg_dep('Make Directory: Make Directory ''tensorfit''', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dir'));
matlabbatch{7}.system.mrtrix3.tensor2metric.outputs_{4}.outputs.string = 'rd.nii';
matlabbatch{7}.system.mrtrix3.tensor2metric.cmd = 'tensor2metric -force -mask i2 i1 -adc o1 -fa o2 -ad o3 -rd o4';
matlabbatch{7}.system.mrtrix3.tensor2metric.usedocker_.dockerimg = 'bids/mrtrix3_connectome';
