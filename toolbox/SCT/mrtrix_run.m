function out = mrtrix_run(name, job)
out = [];
options = '';

[~,filename] = fileparts(job.i{1});
filename = strrep(filename,'.nii','');
%% parse options.
switch name
    case 'dwidenoise'
        out.o = fullfile(job.ofolder,[filename '_denoise.nii.gz']);    
        options = [job.i{1} ' ' out.o{1} ' -force '];        
        job.noise = fullfile(job.ofolder,'noisemap.nii.gz');
        job = rmfield(job,{'i','ofolder'});
    case 'dwibiascorrect'
        out.o = fullfile(job.ofolder,[filename '_biascorrect.nii.gz']);    
        options = [job.i{1} ' ' out.o{1} ' -force '];        
        job.bias = 'b1bias.nii.gz';
        job = rmfield(job,{'i','ofolder'});
        
        job.fslgrad = [job.fslgrad.bvecs{1} ' ' job.fslgrad.bvals{1}];
        
    case 'dwi2tensor'
        out.o = fullfile(job.ofolder,'diffusiontensor.nii.gz');    
        options = [job.i{1} ' ' out.o{1} ' -force '];        
        
        job.fslgrad = [job.fslgrad.bvecs{1} ' ' job.fslgrad.bvals{1}];

    case 'dwipreproc'
        out.o = fullfile(job.ofolder,[filename '_preproc.nii.gz']);    
        options = [job.i{1} ' ' out.o{1} ' -force -rpe_none -pe_dir j -eddy_options " --data_is_shelled"'];        
        
        % export corrected bvecs
        [~,filebvec] = fileparts(job.fslgrad.bvecs{1});
        [~,filebval] = fileparts(job.fslgrad.bvals{1});
        out.bvecs = fullfile(job.ofolder,[filebvec '_corr.bvec']);
        out.bvals = fullfile(job.ofolder,[filebval '_corr.bval']);
        job.export_grad_fsl = [out.bvecs{1} ' ' out.bvals{1}];
        % add fslgrad input
        job.fslgrad = [job.fslgrad.bvecs{1} ' ' job.fslgrad.bvals{1}];
        job = rmfield(job,{'i','ofolder'});
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
system([name ' ' options])