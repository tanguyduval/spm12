%-----------------------------------------------------------------------
% Job saved on 06-Sep-2018 11:41:30 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
% mrtrix MRtrix3 - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.parent = '<UNDEFINED>';
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.bids_ses = '<UNDEFINED>';
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.name = 'mrtrix';
matlabbatch{2}.mrtrix.denoise.i(1) = cfg_dep('Parse BIDS Directory: dwi: dwi', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dwi_dwi'));
matlabbatch{2}.mrtrix.denoise.ofolder(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{3}.mrtrix.preproc.i(1) = cfg_dep('dwidenoise: output file', substruct('.','val', '{}',{2}, '.','val', '{}',{1}), substruct('.','o'));
matlabbatch{3}.mrtrix.preproc.fslgrad.bvecs(1) = cfg_dep('Parse BIDS Directory: dwi: bvec', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dwi_bvec'));
matlabbatch{3}.mrtrix.preproc.fslgrad.bvals(1) = cfg_dep('Parse BIDS Directory: dwi: bval', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dwi_bval'));
matlabbatch{3}.mrtrix.preproc.ofolder(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{3}.mrtrix.preproc.pe_dir(1) = cfg_dep('Parse BIDS Directory: dwi: dwi metadata', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dwi_dwi_meta'));
matlabbatch{4}.mrtrix.dwi2mask.i(1) = cfg_dep('dwipreproc: output file', substruct('.','val', '{}',{3}, '.','val', '{}',{1}), substruct('.','o'));
matlabbatch{4}.mrtrix.dwi2mask.ofolder(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{4}.mrtrix.dwi2mask.fslgrad.bvecs(1) = cfg_dep('dwipreproc: corrected bvec file', substruct('.','val', '{}',{3}, '.','val', '{}',{1}), substruct('.','bvecs'));
matlabbatch{4}.mrtrix.dwi2mask.fslgrad.bvals(1) = cfg_dep('dwipreproc: corrected bval file', substruct('.','val', '{}',{3}, '.','val', '{}',{1}), substruct('.','bvals'));
matlabbatch{5}.mrtrix.dwi2tensor.i(1) = cfg_dep('dwipreproc: output file', substruct('.','val', '{}',{3}, '.','val', '{}',{1}), substruct('.','o'));
matlabbatch{5}.mrtrix.dwi2tensor.mask(1) = cfg_dep('dwi2mask: output file', substruct('.','val', '{}',{4}, '.','val', '{}',{1}), substruct('.','o'));
matlabbatch{5}.mrtrix.dwi2tensor.fslgrad.bvecs(1) = cfg_dep('dwipreproc: corrected bvec file', substruct('.','val', '{}',{3}, '.','val', '{}',{1}), substruct('.','bvecs'));
matlabbatch{5}.mrtrix.dwi2tensor.fslgrad.bvals(1) = cfg_dep('dwipreproc: corrected bval file', substruct('.','val', '{}',{3}, '.','val', '{}',{1}), substruct('.','bvals'));
matlabbatch{5}.mrtrix.dwi2tensor.ofolder(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{6}.mrtrix.tensor2metric.i(1) = cfg_dep('dwi2tensor: output file', substruct('.','val', '{}',{5}, '.','val', '{}',{1}), substruct('.','o'));
matlabbatch{6}.mrtrix.tensor2metric.mask(1) = cfg_dep('dwi2mask: output file', substruct('.','val', '{}',{4}, '.','val', '{}',{1}), substruct('.','o'));
matlabbatch{6}.mrtrix.tensor2metric.ofolder(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{7}.spm.spatial.coreg.estwrite.ref(1) = cfg_dep('Parse BIDS Directory: anat: T1w', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','anat_T1w'));
matlabbatch{7}.spm.spatial.coreg.estwrite.source(1) = cfg_dep('tensor2metric: adc file', substruct('.','val', '{}',{6}, '.','val', '{}',{1}), substruct('.','adc'));
matlabbatch{7}.spm.spatial.coreg.estwrite.other(1) = cfg_dep('tensor2metric: fa file', substruct('.','val', '{}',{6}, '.','val', '{}',{1}), substruct('.','fa'));
matlabbatch{7}.spm.spatial.coreg.estwrite.other(2) = cfg_dep('tensor2metric: ad file', substruct('.','val', '{}',{6}, '.','val', '{}',{1}), substruct('.','ad'));
matlabbatch{7}.spm.spatial.coreg.estwrite.other(3) = cfg_dep('tensor2metric: rd file', substruct('.','val', '{}',{6}, '.','val', '{}',{1}), substruct('.','rd'));
matlabbatch{7}.spm.spatial.coreg.estwrite.other(4) = cfg_dep('tensor2metric: vector file', substruct('.','val', '{}',{6}, '.','val', '{}',{1}), substruct('.','vector'));
matlabbatch{7}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
matlabbatch{7}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
matlabbatch{7}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{7}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
matlabbatch{7}.spm.spatial.coreg.estwrite.roptions.interp = 4;
matlabbatch{7}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
matlabbatch{7}.spm.spatial.coreg.estwrite.roptions.mask = 0;
matlabbatch{7}.spm.spatial.coreg.estwrite.roptions.prefix = 'space-T1w_';
