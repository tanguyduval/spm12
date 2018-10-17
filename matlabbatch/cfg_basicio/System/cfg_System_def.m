function system = cfg_System_def
system.mrtrix3.dwidenoise.inputs_SetDefaultValOnLoad{1}.anyfilebranch.help = '4D dwi: the input diffusion-weighted image';
system.mrtrix3.dwidenoise.inputs_SetDefaultValOnLoad{1}.anyfilebranch.anyfile = '<UNDEFINED>';
system.mrtrix3.dwidenoise.outputs_SetDefaultValOnLoad{1}.outputs.help = '4D dwi: the output denoised DWI image';
system.mrtrix3.dwidenoise.outputs_SetDefaultValOnLoad{1}.outputs.directory = '<UNDEFINED>';
system.mrtrix3.dwidenoise.outputs_SetDefaultValOnLoad{1}.outputs.string = '<UNDEFINED>';
system.mrtrix3.dwidenoise.cmd = 'dwidenoise -force i1 o1';
system.mrtrix3.dwidenoise.usedocker_SetDefaultValOnLoad.dockerimg = 'bids/mrtrix3_connectome';system.fsl.eddy_correct.inputs_SetDefaultValOnLoad{1}.anyfilebranch.help = '4D dwi: the input diffusion-weighted image';
system.fsl.eddy_correct.inputs_SetDefaultValOnLoad{1}.anyfilebranch.anyfile = '<UNDEFINED>';
system.fsl.eddy_correct.inputs_SetDefaultValOnLoad{2}.evaluatedbranch.help = 'reference number: volume that will be used as a reference for the registration';
system.fsl.eddy_correct.inputs_SetDefaultValOnLoad{2}.evaluatedbranch.evaluated = 1;
system.fsl.eddy_correct.inputs_SetDefaultValOnLoad{3}.stringbranch.help = 'interpolation: Choose interp from {trilinear,spline}';
system.fsl.eddy_correct.inputs_SetDefaultValOnLoad{3}.stringbranch.string = 'trilinear';
system.fsl.eddy_correct.outputs_SetDefaultValOnLoad{1}.outputs.help = '4D dwi: the output eddy corrected DWI image';
system.fsl.eddy_correct.outputs_SetDefaultValOnLoad{1}.outputs.directory = '<UNDEFINED>';
system.fsl.eddy_correct.outputs_SetDefaultValOnLoad{1}.outputs.string = '<UNDEFINED>';
system.fsl.eddy_correct.cmd = 'eddy_correct i1 o1 i2 i3';
system.fsl.eddy_correct.usedocker_SetDefaultValOnLoad.dockerimg = 'bids/mrtrix3_connectome';
system.mrtrix3.dwi2mask.inputs_SetDefaultValOnLoad{1}.anyfilebranch.help = '4D dwi: the input diffusion-weighted image';
system.mrtrix3.dwi2mask.inputs_SetDefaultValOnLoad{1}.anyfilebranch.anyfile = '<UNDEFINED>';
system.mrtrix3.dwi2mask.inputs_SetDefaultValOnLoad{2}.anyfilebranch.help = 'bvecs file (in FSL format)';
system.mrtrix3.dwi2mask.inputs_SetDefaultValOnLoad{2}.anyfilebranch.anyfile = '<UNDEFINED>';
system.mrtrix3.dwi2mask.inputs_SetDefaultValOnLoad{3}.anyfilebranch.help = 'bvals file (in FSL format)';
system.mrtrix3.dwi2mask.inputs_SetDefaultValOnLoad{3}.anyfilebranch.anyfile = '<UNDEFINED>';
system.mrtrix3.dwi2mask.outputs_SetDefaultValOnLoad{1}.outputs.help = '3D Mask: the output whole-brain mask image';
system.mrtrix3.dwi2mask.outputs_SetDefaultValOnLoad{1}.outputs.directory = '<UNDEFINED>';
system.mrtrix3.dwi2mask.outputs_SetDefaultValOnLoad{1}.outputs.string = '<UNDEFINED>';
system.mrtrix3.dwi2mask.cmd = 'dwi2mask -fslgrad i2 i3 i1 o1';
system.mrtrix3.dwi2mask.usedocker_SetDefaultValOnLoad.dockerimg = 'bids/mrtrix3_connectome';
system.mrtrix3.dwi2tensor.inputs_SetDefaultValOnLoad{1}.anyfilebranch.help = '4D dwi: the input diffusion-weighted image';
system.mrtrix3.dwi2tensor.inputs_SetDefaultValOnLoad{1}.anyfilebranch.anyfile = '<UNDEFINED>';
system.mrtrix3.dwi2tensor.inputs_SetDefaultValOnLoad{2}.anyfilebranch.help = 'bvecs file (in FSL format)';
system.mrtrix3.dwi2tensor.inputs_SetDefaultValOnLoad{2}.anyfilebranch.anyfile = '<UNDEFINED>';
system.mrtrix3.dwi2tensor.inputs_SetDefaultValOnLoad{3}.anyfilebranch.help = 'bvals file (in FSL format)';
system.mrtrix3.dwi2tensor.inputs_SetDefaultValOnLoad{3}.anyfilebranch.anyfile = '<UNDEFINED>';
system.mrtrix3.dwi2tensor.inputs_SetDefaultValOnLoad{4}.anyfilebranch.help = '3D Mask';
system.mrtrix3.dwi2tensor.inputs_SetDefaultValOnLoad{4}.anyfilebranch.anyfile = '<UNDEFINED>';
system.mrtrix3.dwi2tensor.outputs_SetDefaultValOnLoad{1}.outputs.help = '3D Diffusion Tensor';
system.mrtrix3.dwi2tensor.outputs_SetDefaultValOnLoad{1}.outputs.directory = '<UNDEFINED>';
system.mrtrix3.dwi2tensor.outputs_SetDefaultValOnLoad{1}.outputs.string = '<UNDEFINED>';
system.mrtrix3.dwi2tensor.cmd = 'dwi2tensor -fslgrad i2 i3 -mask i4 i1 o1';
system.mrtrix3.dwi2tensor.usedocker_SetDefaultValOnLoad.dockerimg = 'bids/mrtrix3_connectome';
system.mrtrix3.tensor2metric.inputs_SetDefaultValOnLoad{1}.anyfilebranch.help = '4D dwi: the input diffusion-weighted image';
system.mrtrix3.tensor2metric.inputs_SetDefaultValOnLoad{1}.anyfilebranch.anyfile = '<UNDEFINED>';
system.mrtrix3.tensor2metric.inputs_SetDefaultValOnLoad{2}.anyfilebranch.help = 'bvecs file (in FSL format)';
system.mrtrix3.tensor2metric.inputs_SetDefaultValOnLoad{2}.anyfilebranch.anyfile = '<UNDEFINED>';
system.mrtrix3.tensor2metric.inputs_SetDefaultValOnLoad{3}.anyfilebranch.help = 'bvals file (in FSL format)';
system.mrtrix3.tensor2metric.inputs_SetDefaultValOnLoad{3}.anyfilebranch.anyfile = '<UNDEFINED>';
system.mrtrix3.tensor2metric.inputs_SetDefaultValOnLoad{4}.anyfilebranch.help = '3D Mask';
system.mrtrix3.tensor2metric.inputs_SetDefaultValOnLoad{4}.anyfilebranch.anyfile = '<UNDEFINED>';
system.mrtrix3.tensor2metric.outputs_SetDefaultValOnLoad{1}.outputs.help = 'ADC image';
system.mrtrix3.tensor2metric.outputs_SetDefaultValOnLoad{1}.outputs.directory = '<UNDEFINED>';
system.mrtrix3.tensor2metric.outputs_SetDefaultValOnLoad{1}.outputs.string = 'adc.nii';
system.mrtrix3.tensor2metric.outputs_SetDefaultValOnLoad{2}.outputs.help = 'FA image';
system.mrtrix3.tensor2metric.outputs_SetDefaultValOnLoad{2}.outputs.directory = '<UNDEFINED>';
system.mrtrix3.tensor2metric.outputs_SetDefaultValOnLoad{2}.outputs.string = 'fa.nii';
system.mrtrix3.tensor2metric.outputs_SetDefaultValOnLoad{3}.outputs.help = 'AD image: axial diffusivity';
system.mrtrix3.tensor2metric.outputs_SetDefaultValOnLoad{3}.outputs.directory = '<UNDEFINED>';
system.mrtrix3.tensor2metric.outputs_SetDefaultValOnLoad{3}.outputs.string = 'ad.nii';
system.mrtrix3.tensor2metric.outputs_SetDefaultValOnLoad{4}.outputs.help = 'RD image: radial diffusivity';
system.mrtrix3.tensor2metric.outputs_SetDefaultValOnLoad{4}.outputs.directory = '<UNDEFINED>';
system.mrtrix3.tensor2metric.outputs_SetDefaultValOnLoad{4}.outputs.string = 'rd.nii';
system.mrtrix3.tensor2metric.cmd = 'tensor2metric -mask i2 i1 -adc o1 -fa o2 -ad o3 -rd o4';
system.mrtrix3.tensor2metric.usedocker_SetDefaultValOnLoad.dockerimg = 'bids/mrtrix3_connectome';
