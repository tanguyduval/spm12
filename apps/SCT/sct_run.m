function out = sct_run(name, job)
out = [];
options = '';

switch name
    case 'sct_crop_image'
        job.o = fullfile(job.o.ofolder,job.o.filename);    
        out.o = {job.o};
    case 'sct_deepseg_sc'
        out.o = fullfile(job.ofolder,strrep(job.i,'.nii.gz','_seg.nii.gz'));
end
    
for ff= fieldnames(job)'
    val = job.(ff{1});
    if iscell(val), val = val{1}; end
    options = [options ' -' ff{1} ' ' val];
end
system([name options])