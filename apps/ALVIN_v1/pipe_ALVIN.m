%-----------------------------------------------------------------------
% Job saved on 16-Oct-2018 17:12:20 by cfg_util (rev $Rev: 6942 $)
% mrtrix MRtrix3 - Unknown
% sct Spinal Cord Toolbox - Unknown
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.parent = '<UNDEFINED>';
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.bids_ses = 1;
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.name = 'mask_csf';
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('Parse BIDS Directory: anat: T1w', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','anat_T1w'));
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{2}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;
matlabbatch{3}.cfg_basicio.run_ops.call_matlab.inputs{1}.anyfile(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{3}.cfg_basicio.run_ops.call_matlab.outputs = cell(1, 0);
matlabbatch{3}.cfg_basicio.run_ops.call_matlab.fun = @spm_setorigin2center;
matlabbatch{4}.spm.spatial.preproc.channel.vols(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{4}.spm.spatial.preproc.channel.biasreg = 0.001;
matlabbatch{4}.spm.spatial.preproc.channel.biasfwhm = 60;
matlabbatch{4}.spm.spatial.preproc.channel.write = [1 0];
matlabbatch{4}.spm.spatial.preproc.tissue(1).tpm = {'C:\Users\TONIC\Documents\code\spm12\tpm\TPM.nii,1'};
matlabbatch{4}.spm.spatial.preproc.tissue(1).ngaus = 1;
matlabbatch{4}.spm.spatial.preproc.tissue(1).native = [1 0];
matlabbatch{4}.spm.spatial.preproc.tissue(1).warped = [0 0];
matlabbatch{4}.spm.spatial.preproc.tissue(2).tpm = {'C:\Users\TONIC\Documents\code\spm12\tpm\TPM.nii,2'};
matlabbatch{4}.spm.spatial.preproc.tissue(2).ngaus = 1;
matlabbatch{4}.spm.spatial.preproc.tissue(2).native = [1 0];
matlabbatch{4}.spm.spatial.preproc.tissue(2).warped = [0 0];
matlabbatch{4}.spm.spatial.preproc.tissue(3).tpm = {'C:\Users\TONIC\Documents\code\spm12\tpm\TPM.nii,3'};
matlabbatch{4}.spm.spatial.preproc.tissue(3).ngaus = 2;
matlabbatch{4}.spm.spatial.preproc.tissue(3).native = [1 0];
matlabbatch{4}.spm.spatial.preproc.tissue(3).warped = [0 0];
matlabbatch{4}.spm.spatial.preproc.tissue(4).tpm = {'C:\Users\TONIC\Documents\code\spm12\tpm\TPM.nii,4'};
matlabbatch{4}.spm.spatial.preproc.tissue(4).ngaus = 3;
matlabbatch{4}.spm.spatial.preproc.tissue(4).native = [1 0];
matlabbatch{4}.spm.spatial.preproc.tissue(4).warped = [0 0];
matlabbatch{4}.spm.spatial.preproc.tissue(5).tpm = {'C:\Users\TONIC\Documents\code\spm12\tpm\TPM.nii,5'};
matlabbatch{4}.spm.spatial.preproc.tissue(5).ngaus = 4;
matlabbatch{4}.spm.spatial.preproc.tissue(5).native = [1 0];
matlabbatch{4}.spm.spatial.preproc.tissue(5).warped = [0 0];
matlabbatch{4}.spm.spatial.preproc.tissue(6).tpm = {'C:\Users\TONIC\Documents\code\spm12\tpm\TPM.nii,6'};
matlabbatch{4}.spm.spatial.preproc.tissue(6).ngaus = 2;
matlabbatch{4}.spm.spatial.preproc.tissue(6).native = [0 0];
matlabbatch{4}.spm.spatial.preproc.tissue(6).warped = [0 0];
matlabbatch{4}.spm.spatial.preproc.warp.mrf = 1;
matlabbatch{4}.spm.spatial.preproc.warp.cleanup = 1;
matlabbatch{4}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
matlabbatch{4}.spm.spatial.preproc.warp.affreg = 'mni';
matlabbatch{4}.spm.spatial.preproc.warp.fwhm = 0;
matlabbatch{4}.spm.spatial.preproc.warp.samp = 3;
matlabbatch{4}.spm.spatial.preproc.warp.write = [1 1];
matlabbatch{5}.cfg_basicio.run_ops.call_matlab.inputs = cell(1, 0);
matlabbatch{5}.cfg_basicio.run_ops.call_matlab.outputs{1}.filter.image = true;
matlabbatch{5}.cfg_basicio.run_ops.call_matlab.fun = @ALVIN_v1_getmask;
matlabbatch{6}.spm.spatial.normalise.write.subj.def(1) = cfg_dep('Segment: Inverse Deformations', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','invdef', '()',{':'}));
matlabbatch{6}.spm.spatial.normalise.write.subj.resample(1) = cfg_dep('Call MATLAB function: Call MATLAB: output 1 - filter image', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','outputs', '{}',{1}));
matlabbatch{6}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
matlabbatch{6}.spm.spatial.normalise.write.woptions.vox = [1 1 1];
matlabbatch{6}.spm.spatial.normalise.write.woptions.interp = 4;
matlabbatch{6}.spm.spatial.normalise.write.woptions.prefix = 'w';
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_move.files(1) = cfg_dep('Normalise: Write: Normalised Images (Subj 1)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_move.action.moveto(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{8}.spm.util.imcalc.input(1) = cfg_dep('Segment: c3 Images', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{3}, '.','c', '()',{':'}));
matlabbatch{8}.spm.util.imcalc.input(2) = cfg_dep('Normalise: Write: Normalised Images (Subj 1)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{8}.spm.util.imcalc.output = 'mask_CSF';
matlabbatch{8}.spm.util.imcalc.outdir(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{8}.spm.util.imcalc.expression = 'i1.*(i2>50)';
matlabbatch{8}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{8}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{8}.spm.util.imcalc.options.mask = 0;
matlabbatch{8}.spm.util.imcalc.options.interp = 1;
matlabbatch{8}.spm.util.imcalc.options.dtype = 4;
matlabbatch{9}.spm.spatial.smooth.data(1) = cfg_dep('Image Calculator: ImCalc Computed Image: mask_CSF', substruct('.','val', '{}',{8}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{9}.spm.spatial.smooth.fwhm = [3 3 3];
matlabbatch{9}.spm.spatial.smooth.dtype = 0;
matlabbatch{9}.spm.spatial.smooth.im = 0;
matlabbatch{9}.spm.spatial.smooth.prefix = 's';
matlabbatch{10}.spm.util.imcalc.input(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{10}.spm.util.imcalc.output = 'mask_CSF_s.nii';
matlabbatch{10}.spm.util.imcalc.outdir(1) = cfg_dep('Parse BIDS Directory: BIDS output path for derivatives', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','bidsderivatives'));
matlabbatch{10}.spm.util.imcalc.expression = 'i1>.5';
matlabbatch{10}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{10}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{10}.spm.util.imcalc.options.mask = 0;
matlabbatch{10}.spm.util.imcalc.options.interp = 1;
matlabbatch{10}.spm.util.imcalc.options.dtype = 4;
