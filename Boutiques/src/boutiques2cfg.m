function [cfg,def] = boutiques2cfg(parentfolder)
% load Boutiques jsons in entire folder

cfg = [];
def = struct;
[list,path] = sct_tools_ls(fullfile(parentfolder,'*.json'),1,1,2,1);
for ifile = 1:length(list)
    % load boutique json
    tree = strsplit(strrep(path{ifile}(1:end-1),[fileparts(parentfolder) filesep],''),filesep);
    json = loadjson(list{ifile});
    % convert boutique to cfg
    if isfield(json,'matlab_0x2D_version')
        [icfg, idef] = boutiquematlab2cfg(json);
    else
        [icfg, idef] = boutique2cfg(json);
    end
    tree{end+1} = json.name;
    
    % generate full tree
    cfg = assigntree(cfg, icfg, tree);
    
    % compute def
    tree{1} = 'def'; 
    code = gencode(idef,strjoin(cellfun(@genvarname,lower(tree),'uni',0),'.'))';
    for iii = 1:length(code); eval(code{iii}); end

end
