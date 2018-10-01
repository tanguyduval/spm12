%-----------------------------------------------------------------------
% Job saved on 01-Oct-2018 09:58:33 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
% mrtrix MRtrix3 - Unknown
% sct Spinal Cord Toolbox - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.parent = '<UNDEFINED>';
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.bids_ses = 1;
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.name = 'SCT';
matlabbatch{2}.sct.seg.i(1) = cfg_dep('Parse BIDS Directory: anat: T1w', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','anat_T1w'));
matlabbatch{2}.sct.seg.ofolder(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{2}.sct.seg.c = 't1';
