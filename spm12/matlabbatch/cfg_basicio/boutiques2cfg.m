function [cfg,def] = boutiques2cfg(parentfolder)
% load Boutiques jsons in entire folder

cfg = [];
def = struct;
list = dir(fullfile(parentfolder,'**','*.json'));
for ifile = 1:length(list)
    % load boutique json
    tree = strsplit(strrep(list(ifile).folder,parentfolder,''),filesep);
    json = loadjson(fullfile(list(ifile).folder,list(ifile).name));
    % convert boutique to cfg
    [icfg, idef] = boutique2cfg(json);
    tree{end+1} = json.name;
    
    % generate full tree
    cfg = assigntree(cfg, icfg, tree);
    
    % compute def
    tree{1} = 'def'; 
    code = gencode(idef,strjoin(cellfun(@genvarname,lower(tree),'uni',0),'.'))';
    for iii = 1:length(code); eval(code{iii}); end

end
