function matlabbatch = cfg_check_call_system(matlabbatch)
% replace missing apps by default one

for ii = 1:length(matlabbatch)
    missingcmd = false;
    hascmdfields = cell2mat(cellfun(@(x) ~isempty(regexp(x,'(.cmd = |.inputs_|.outputs_|.usedocker_)', 'once')), gencode(matlabbatch{ii})','uni',0));
    if all(hascmdfields)
        hascmdfields = unique(cell2mat(cellfun(@(x) regexp(x,'(.cmd = |.inputs_|.outputs_|.usedocker_)', 'once'), gencode(matlabbatch{ii})','uni',0)));
        tree =  gencode(matlabbatch{ii})';
        tree = strsplit(tree{1}(5:hascmdfields-1),'.');
        cfgfname = which(['cfg_' tree{1}]);
        if ~isempty(cfgfname)
            [~,cfgfname] = fileparts(cfgfname);
            cfg = feval(cfgfname);
            for it = 2:length(tree)
                existtag = strcmpi(tagnames(cfg,1),tree{it});
                if  ~any(existtag)
                    missingcmd = true;
                else
                    cfg = cfg.values{existtag};
                end
            end
        else
            missingcmd = true;
        end
    end
    if missingcmd
        matlabbatchcode = gencode(matlabbatch)';
        matlabbatchcode = strrep(matlabbatchcode,strjoin(tree,'.'),'cfg_basicio.run_ops.call_system');
        clear matlabbatch
        eval(sprintf('%s\n',matlabbatchcode{:}));
    end
end