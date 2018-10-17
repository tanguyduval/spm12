function cfg = cfg_System(varargin)

% ---------------------------------------------------------------------
% dwidenoise dwidenoise
% ---------------------------------------------------------------------
dwidenoise         = cfg_cfg_call_system;
dwidenoise.tag     = 'dwidenoise';
dwidenoise.name    = 'dwidenoise';
% ---------------------------------------------------------------------
% dwi2mask dwi2mask
% ---------------------------------------------------------------------
dwi2mask         = cfg_cfg_call_system;
dwi2mask.tag     = 'dwi2mask';
dwi2mask.name    = 'dwi2mask';
% ---------------------------------------------------------------------
% dwi2tensor dwi2tensor
% ---------------------------------------------------------------------
dwi2tensor         = cfg_cfg_call_system;
dwi2tensor.tag     = 'dwi2tensor';
dwi2tensor.name    = 'dwi2tensor';
% ---------------------------------------------------------------------
% tensor2metric tensor2metric
% ---------------------------------------------------------------------
tensor2metric         = cfg_cfg_call_system;
tensor2metric.tag     = 'tensor2metric';
tensor2metric.name    = 'tensor2metric';
% ---------------------------------------------------------------------
% mrtrix3 MRtrix3
% ---------------------------------------------------------------------
mrtrix3         = cfg_choice;
mrtrix3.tag     = 'mrtrix3';
mrtrix3.name    = 'MRtrix3';
mrtrix3.values  = {dwidenoise dwi2mask dwi2tensor tensor2metric };
% ---------------------------------------------------------------------
% eddy_correct eddy_correct
% ---------------------------------------------------------------------
eddy_correct         = cfg_cfg_call_system;
eddy_correct.tag     = 'eddy_correct';
eddy_correct.name    = 'eddy_correct';
% ---------------------------------------------------------------------
% fsl FSL
% ---------------------------------------------------------------------
fsl         = cfg_choice;
fsl.tag     = 'fsl';
fsl.name    = 'FSL';
fsl.values  = {eddy_correct };
% ---------------------------------------------------------------------
% system System
% ---------------------------------------------------------------------
cfg         = cfg_choice;
cfg.tag     = 'system';
cfg.name    = 'System';
cfg.values  = {mrtrix3 fsl };
