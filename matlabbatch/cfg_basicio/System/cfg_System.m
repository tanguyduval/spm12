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
% tmean Tmean
% ---------------------------------------------------------------------
tmean         = cfg_cfg_call_system;
tmean.tag     = 'tmean';
tmean.name    = 'Tmean';
% ---------------------------------------------------------------------
% fslmaths fslmaths
% ---------------------------------------------------------------------
fslmaths         = cfg_choice;
fslmaths.tag     = 'fslmaths';
fslmaths.name    = 'fslmaths';
fslmaths.values  = {tmean };
% ---------------------------------------------------------------------
% bet bet
% ---------------------------------------------------------------------
bet         = cfg_cfg_call_system;
bet.tag     = 'bet';
bet.name    = 'bet';
% ---------------------------------------------------------------------
% fsl FSL
% ---------------------------------------------------------------------
fsl         = cfg_choice;
fsl.tag     = 'fsl';
fsl.name    = 'FSL';
fsl.values  = {eddy_correct fslmaths bet };
% ---------------------------------------------------------------------
% rigid Rigid
% ---------------------------------------------------------------------
rigid         = cfg_cfg_call_system;
rigid.tag     = 'rigid';
rigid.name    = 'Rigid';
% ---------------------------------------------------------------------
% antsregistration antsRegistration
% ---------------------------------------------------------------------
antsregistration         = cfg_choice;
antsregistration.tag     = 'antsregistration';
antsregistration.name    = 'antsRegistration';
antsregistration.values  = {rigid };
% ---------------------------------------------------------------------
% antsapplytransforms antsApplyTransforms
% ---------------------------------------------------------------------
antsapplytransforms         = cfg_cfg_call_system;
antsapplytransforms.tag     = 'antsapplytransforms';
antsapplytransforms.name    = 'antsApplyTransforms';
% ---------------------------------------------------------------------
% ants ANTS
% ---------------------------------------------------------------------
ants         = cfg_choice;
ants.tag     = 'ants';
ants.name    = 'ANTS';
ants.values  = {antsregistration antsapplytransforms };
% ---------------------------------------------------------------------
% dcm2bids dcm2bids
% ---------------------------------------------------------------------
dcm2bids         = cfg_cfg_call_system;
dcm2bids.tag     = 'dcm2bids';
dcm2bids.name    = 'dcm2bids';
% ---------------------------------------------------------------------
% system System
% ---------------------------------------------------------------------
cfg         = cfg_choice;
cfg.tag     = 'system';
cfg.name    = 'System';
cfg.values  = {mrtrix3 fsl ants dcm2bids };
