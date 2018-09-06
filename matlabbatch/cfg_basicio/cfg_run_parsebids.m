function out = cfg_run_parsebids(job)

% Make a directory and return its path in out.dir{1}.
%
% This code is part of a batch job configuration system for MATLAB. See 
%      help matlabbatch
% for a general overview.
%_______________________________________________________________________

% Tanguy Duval

% CALL BIDS_PARSER
BIDS = bids_parser(job.parent{1});

% TEST IF BIDS
if isempty(BIDS.subjects)
    out = [];
    return
end

% SELECT CURRENT SUBJECT

SCAN = BIDS.subjects(min(end,job.bids_ses));

% ADD OUTPUT DIRECTORIES
out.bidsdir         = {BIDS.path};
if strcmp(job.name,'<UNDEFINED>'), job.name = 'test'; end
out.bidsderivatives = fullfile(out.bidsdir,'derivatives','matlabbatch',['sub-' SCAN.name],['ses-' SCAN.session],job.name);
if ~exist(out.bidsderivatives{1},'dir')
    mkdir(out.bidsderivatives{1})
end

% LOOP OVER MODALITIES AND EXTRACT PATIENT DATA FILENAME AND METADATA
list = {'anat','T1w',...
        'anat','T2w',...
        'anat', 'FLAIR',...
        'func','bold',...
        'dwi','dwi'...
        };
    
mods = setdiff(fieldnames(SCAN),{'name','path','session'});
list = {};
for imods = 1:length(mods)
    for ifile = 1:length(SCAN.(mods{imods}))
        list{end+1} = mods{imods};
        if isfield(SCAN.(mods{imods}),'modality') && ~isempty(SCAN.(mods{imods})(ifile).modality)
            list{end+1} = SCAN.(mods{imods})(ifile).modality;
        else
            list{end+1} = regexprep(SCAN.(mods{imods})(ifile).filename,'\.nii(\.gz)?','');
        end
    end
end

for ii=1:2:length(list)
        MODALITY = SCAN.(list{ii})(strcmp({SCAN.(list{ii}).modality},list{ii+1}) | strcmp(regexprep({SCAN.(list{ii}).filename},'\.nii(\.gz)?',''),list{ii+1}));
        if ~isempty(MODALITY)
            % Add nifti
            nii_fname = fullfile(SCAN.path,list{ii},MODALITY(1).filename);
            tag = [list{ii} '_' list{ii+1}];
            out.(tag) = {nii_fname};
            
            % Special treatment for dmri
            if strcmp(list{ii},'dwi')
                out.dwi_bvec = {strrep(strrep(nii_fname,'.gz',''),'.nii','.bvec')};
                out.dwi_bval = {strrep(strrep(nii_fname,'.gz',''),'.nii','.bval')};
            end
            
            % Add metadata
            if isfield(MODALITY(1),'meta') && ~isempty(MODALITY(1).meta)
                tag = [tag '_meta'];
                out.(tag) = MODALITY(1).meta;
            end
        end
end
