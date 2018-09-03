function out = cfg_run_parsebids(job)

% Make a directory and return its path in out.dir{1}.
%
% This code is part of a batch job configuration system for MATLAB. See 
%      help matlabbatch
% for a general overview.
%_______________________________________________________________________

% Tanguy Duval


BIDS = bids_parser(job.parent{1});
if isempty(BIDS.subjects)
    out = [];
    return
end
out.bidsdir         = {BIDS.path};
SCAN = BIDS.subjects(job.bids_ses);
out.bidsderivatives = fullfile(out.bidsdir,'derivatives','test',SCAN.name,SCAN.session);
mkdir(out.bidsderivatives{1})
% MODALITY = SCAN.anat(strcmp({SCAN.anat.modality},'T1w'));
% out.T1w = fullfile(SCAN.path,'anat',MODALITY.filename);
% MODALITY = SCAN.func(strcmp({SCAN.func.modality},'bold'));
% out.bold = fullfile(SCAN.path,'func',MODALITY.filename);
list = {'anat','T1w','anat','T2w','anat', 'FLAIR','func','bold','dwi','dwi'};
for ii=1:2:length(list)
    if isfield(SCAN,list{ii})
        MODALITY = SCAN.(list{ii})(strcmp({SCAN.(list{ii}).modality},list{ii+1}));
        if ~isempty(MODALITY)
            out.([list{ii} '_' list{ii+1}]) = {strrep(fullfile(SCAN.path,list{ii},MODALITY(1).filename),'.gz','')};
        end
    end
end
