function out = mrtrix_run(name, job)
out = [];
options = '';

[~,filename] = fileparts(job.i{1});
filename = strrep(filename,'.nii','');
%% parse options.
switch name
    case 'dwidenoise'
        out.o = fullfile(job.ofolder,[filename '_denoise.nii']);    
        options = [job.i{1} ' ' out.o{1} ' -force '];        
        job.noise = fullfile(job.ofolder,'noisemap.nii.gz');
        job = rmfield(job,{'i','ofolder'});
    case 'dwibiascorrect'
        out.o = fullfile(job.ofolder,[filename '_biascorrect.nii']);    
        options = [job.i{1} ' ' out.o{1} ' -force '];        
        job.bias = 'b1bias.nii.gz';
        job = rmfield(job,{'i','ofolder'});
        
        job.fslgrad = [job.fslgrad.bvecs{1} ' ' job.fslgrad.bvals{1}];
        
    case 'dwi2tensor'
        out.o = fullfile(job.ofolder,'diffusiontensor.nii');    
        options = [job.i{1} ' ' out.o{1} ' -force '];        
        job = rmfield(job,{'i','ofolder'});
        
        job.fslgrad = [job.fslgrad.bvecs{1} ' ' job.fslgrad.bvals{1}];

    case 'dwipreproc'
        if isstruct(job.pe_dir), job.pe_dir = job.pe_dir.PhaseEncodingAxis; end
        out.o = fullfile(job.ofolder,[filename '_preproc.nii']);    
        options = [job.i{1} ' ' out.o{1} ' -force -rpe_none -eddy_options " --data_is_shelled"'];        
        
        % export corrected bvecs
        [~,filebvec] = fileparts(job.fslgrad.bvecs{1});
        [~,filebval] = fileparts(job.fslgrad.bvals{1});
        out.bvecs = fullfile(job.ofolder,[filebvec '_corr.bvec']);
        out.bvals = fullfile(job.ofolder,[filebval '_corr.bval']);
        job.export_grad_fsl = [out.bvecs{1} ' ' out.bvals{1}];
        % add fslgrad input
        job.fslgrad = [job.fslgrad.bvecs{1} ' ' job.fslgrad.bvals{1}];
        job = rmfield(job,{'i','ofolder'});
    case 'tensor2metric'
        met = {'adc','fa','ad','rd','vector'};
        if ~exist(fullfile(job.ofolder{1},'tensorfit'),'dir')
            mkdir(fullfile(job.ofolder{1},'tensorfit'));
        end
        for imet = 1:length(met)
            job.(met{imet}) = fullfile(job.ofolder,'tensorfit',[met{imet} '.nii.gz']);
            out.(met{imet}) = job.(met{imet});
        end
        options = [job.i{1} ' -force '];        
        job = rmfield(job,{'i','ofolder'});
        
    case 'dwi2mask'
        out.o = fullfile(job.ofolder,'mask.nii.gz');    
        options = [job.i{1} ' ' out.o{1} ' -force '];        
        job = rmfield(job,{'i','ofolder'});
        
        job.fslgrad = [job.fslgrad.bvecs{1} ' ' job.fslgrad.bvals{1}];
end
    
%% Append options -flag to the command call
% job.flag='3' --> -flag 3
for ff= fieldnames(job)'
    val = job.(ff{1});
    if iscell(val), val = val{1}; end
    options = [options ' -' ff{1} ' ' val];
end

%% Call Command
disp(['<strong>' name ' ' options '</strong>'])
if isfield(out,'o') && exist(out.o{1},'file')
    disp(['<strong>output file already exists, assuming that the processing was already done... skipping</strong>'])
    disp(['Delete output file to restart this job = ' out.o{1}])
else
    [status, cmd]=system([name ' ' options],'-echo');
    if status, error(cmd); end
end