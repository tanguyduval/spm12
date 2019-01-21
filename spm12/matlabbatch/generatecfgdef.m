function jobstr = generatecfgdef(tree, job)

% remove dependencies
job = rmdep(job);

if exist(['cfg_' tree{1} '_def'],'file')
    cfgdef = eval(['cfg_' tree{1} '_def']);
    tree = genvarname(lower(tree));
    switch length(tree)
        case 2
            cfgdef.(tree{2}) = job;
        case 3
            cfgdef.(tree{2}).(tree{3}) = job;
        case 4
            cfgdef.(tree{2}).(tree{3}).(tree{4}) = job;
        case 5
            cfgdef.(tree{2}).(tree{3}).(tree{4}).(tree{5}) = job;
        case 6
            cfgdef.(tree{2}).(tree{3}).(tree{4}).(tree{5}).(tree{6}) = job;
        case 7
            cfgdef.(tree{2}).(tree{3}).(tree{4}).(tree{5}).(tree{6}).(tree{7}) = job;
        case 8
            cfgdef.(tree{2}).(tree{3}).(tree{4}).(tree{5}).(tree{6}).(tree{7}).(tree{8}) = job;
    end
    jobstr = gencode(cfgdef,tree{1})';
    
else
    jobstr = gencode(job,strjoin(cellfun(@genvarname,lower(tree),'uni',0),'.'))';
end

function job = rmdep(job)
for ff = fieldnames(job)'
    switch class(job.(ff{1}))
        case 'cell'
            for ic = 1:length(job.(ff{1}))
                job.(ff{1}){ic} = rmdep(job.(ff{1}){ic});
            end
        case 'struct'
            job.(ff{1}) = rmdep(job.(ff{1}));
        case 'cfg_dep'
            job = rmfield(job,ff{1});
    end
end