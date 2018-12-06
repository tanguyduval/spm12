function cfg_ui_loop(handles)
% Get job
udmodlist = get(handles.modlist, 'userdata');
[~, matlabbatch] = cfg_util('harvest', udmodlist.cjob);

% Check if first module is parsebids
if isfield(matlabbatch{1},'cfg_basicio') && isfield(matlabbatch{1}.cfg_basicio,'file_dir') && isfield(matlabbatch{1}.cfg_basicio.file_dir,'dir_ops') && isfield(matlabbatch{1}.cfg_basicio.file_dir.dir_ops,'cfg_parsebids')
    job.parent = matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.parent;
    BIDS = cfg_run_parsebids(job);
    matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids = rmfield(matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids,'bids_ses_type');
    errorsubs = {};
    hh = listdlg('PromptString','Select subjects to process','ListString',strcat({BIDS.subjects.name}','_', {BIDS.subjects.session}'));

    for ii=hh
        matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_parsebids.bids_ses_type.bids_sesnum = ii;
        try
            spm_jobman('run',matlabbatch);
        catch err
            disp(err.message)
            errorsubs{end+1,1} = ['sub-' BIDS.subjects(ii).name ' ses-' BIDS.subjects(ii).session ': ' err.message(1,1:end)];
        end
    end
    
    if ~isempty(errorsubs)
        disp('the following subjects could not be run:')
        disp(errorsubs)
    end
    
else
    warndlg('The first module must be a BasicIO>Dir Operation>Parse BIDS directory','Could not run over all subjects')
end