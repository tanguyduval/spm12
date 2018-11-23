function jobstr = generatecfgdef(tree, job)

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
