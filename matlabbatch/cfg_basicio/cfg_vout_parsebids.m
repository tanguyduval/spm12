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
    job.parent = {[mfilename('fullpath') '_template']};  
end
try
    out = cfg_run_parsebids(job);
catch
    job.parent = {[mfilename('fullpath') '_template']};  
    out = cfg_run_parsebids(job);
end

for ff = setdiff(fieldnames(out)',{'bidsdir','bidsderivatives'})
    dep(end+1)            = cfg_dep;
    dep(end).sname      = strrep(strrep(ff{1},'_meta',' metadata'),'_',': ');
    dep(end).src_output = substruct('.',ff{1});
    if strcmp(ff{1}(end-4:end),'_meta')
        dep(end).tgt_spec   = cfg_findspec({{'class','cfg_entry', 'strtype','e'}});
    else
        dep(end).tgt_spec   = cfg_findspec({{'class','cfg_files', 'strtype','e'}});
    end
end