function dep = cfg_vout_parsebids(job)

% Define virtual outputs for cfg_run_parsebids. The directory name can either
% be assigned to a cfg_files directory input or to a evaluated cfg_entry.
%
% This code is part of a batch job configuration system for MATLAB. See 
%      help matlabbatch
% for a general overview.
%_______________________________________________________________________

% Tanguy Duval

dep               = cfg_dep;
dep(1)            = cfg_dep;
dep(1).sname      = sprintf('BIDS directory path');
dep(1).src_output = substruct('.','bidsdir');
dep(1).tgt_spec   = cfg_findspec({{'filter','dir', 'strtype','e'}});
%
% BIDS = bids_parser(uigetdir([],'BIDS folder on which dependencies will be built'));
% types = setdiff(fieldnames(BIDS.subjects(1)),{'name','path','session'});

dep(2)            = cfg_dep;
dep(2).sname      = sprintf('BIDS output path for derivatives');
dep(2).src_output = substruct('.','bidsderivatives');
dep(2).tgt_spec   = cfg_findspec({{'class','cfg_files', 'strtype','e'}});

if strcmp(job.parent,'<UNDEFINED>')
    out = [];
else
    out = cfg_run_parsebids(job);
end
if isstruct(out) && ~isempty(setdiff(fieldnames(out)',{'bidsdir','bidsderivatives'}))
    for ff = setdiff(fieldnames(out)',{'bidsdir','bidsderivatives'})
        dep(end+1)            = cfg_dep;
        dep(end).sname      = strrep(ff{1},'_',': ');
        dep(end).src_output = substruct('.',ff{1});
        dep(end).tgt_spec   = cfg_findspec({{'class','cfg_files', 'strtype','e'}});
    end
else
    dep(3)            = cfg_dep;
    dep(3).sname      = sprintf('anat: T1w');
    dep(3).src_output = substruct('.','T1w');
    dep(3).tgt_spec   = cfg_findspec({{'class','cfg_files', 'strtype','e'}});
    dep(4)            = cfg_dep;
    dep(4).sname      = sprintf('anat: T2w');
    dep(4).src_output = substruct('.','T2w');
    dep(4).tgt_spec   = cfg_findspec({{'class','cfg_files', 'strtype','e'}});
    dep(5)            = cfg_dep;
    dep(5).sname      = sprintf('anat: FLAIR');
    dep(5).src_output = substruct('.','FLAIR');
    dep(5).tgt_spec   = cfg_findspec({{'class','cfg_files', 'strtype','e'}});
    dep(6)            = cfg_dep;
    dep(6).sname      = sprintf('func: bold');
    dep(6).src_output = substruct('.','bold');
    dep(6).tgt_spec   = cfg_findspec({{'class','cfg_files', 'strtype','e'}});
    dep(7)            = cfg_dep;
    dep(7).sname      = sprintf('dwi: dwi');
    dep(7).src_output = substruct('.','dwi');
    dep(7).tgt_spec   = cfg_findspec({{'class','cfg_files', 'strtype','e'}});
end
