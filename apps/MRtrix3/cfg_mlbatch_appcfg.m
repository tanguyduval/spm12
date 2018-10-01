function [cfg, def] = cfg_mlbatch_appcfg(varargin)

% Add MRtrix3 to applications list of cfg_util. 
%_______________________________________________________________________
% Copyright (C) 2018 Toulouse Neuroimaging Center

% Tanguy Duval

% these two files are now on MATLABs path
cfg = mrtrix_cfg_tlbx;
def = [];
