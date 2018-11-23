function [directory, tree, new] = generatetree(Name, base_cfg)
% Generate a default tree in folder described in apps_savepath.txt
% [directory, tree, new] = generatetree(Name, base_cfg)
%
% Example:
%   generatetree('Test.Ants.Registration.rigid',cfg_cfg_call_system)

directory = [];
tree = [];
% get user pref
prompt = {'Module name:'};
title = 'Save Command configuration';
dims = [1 35];
definput = {Name};
answer = inputdlg(prompt,title,dims,definput);
if isempty(answer), return; end
tree = strsplit(answer{1},'.');
% create output dir
appssavepath = textread('apps_savepath.txt','%s');
directory = fullfile(appssavepath{1},tree{1});
if ~exist(directory)
    mkdir(directory);
    new = true;
else
    new = false;
end
addpath(genpath(directory))

% generate cfg_mlbatch_appcfg
if ~exist(fullfile(directory,'cfg_mlbatch_appcfg.m'),'file')
    new = true;
end
if new
    fid = fopen(fullfile(directory,'cfg_mlbatch_appcfg.m'),'wt');
    fprintf(fid, 'function [cfg, def] = cfg_mlbatch_appcfg(varargin)\n');
    fprintf(fid, ...
        ['%% ''%s'' - MATLABBATCH cfg_util initialisation\n' ...
        '%% This MATLABBATCH initialisation file can be used to load application\n' ...
        '%%              ''%s''\n' ...
        '%% into cfg_util. This can be done manually by running this file from\n' ...
        '%% MATLAB command line or automatically when cfg_util is initialised.\n' ...
        '%% The directory containing this file and the configuration file\n' ...
        '%%              ''%s''\n' ...
        '%% must be in MATLAB''s path variable.\n' ...
        '%% Created at %s.\n\n'], ...
        tree{1}, tree{1}, ['cfg_' tree{1} '_def'], datestr(now, 31));
    
    fprintf(fid, 'if ~isdeployed\n');
    fprintf(fid, '    %% Get path to this file and add it to MATLAB path.\n');
    fprintf(fid, ['    %% If the configuration file is stored in another place, the ' ...
        'path must be adjusted here.\n']);
    fprintf(fid, '    p = fileparts(mfilename(''fullpath''));\n');
    fprintf(fid, '    addpath(p);\n');
    fprintf(fid, 'end\n');
    fprintf(fid, '%% run configuration main & def function, return output\n');
    fprintf(fid, 'cfg = %s;\n', ['cfg_' tree{1}]);
    
    fprintf(fid, 'def = %s;\n',['cfg_' tree{1} '_def']);
    
    fclose(fid);
end

% generate cfg_CML
cfg_new     = base_cfg;
cfg_new.tag = genvarname(lower(tree{end}));
cfg_new.name = tree{end};

jj=2;
iscfg_callsystem=false;
if ~new
    cfg = feval(['cfg_' tree{1}]);
    subs = {};
    cfg_tmp = cfg;
    for jj=2:length(tree)
        ind = cell2mat(cellfun(@(x) strcmpi(x.tag,tree{jj}), cfg_tmp.values,'uni',0));
        if any(ind)
            subs = [subs, {'.','values','{}',{find(ind,1)}}];
            cfg_tmp = subsref(cfg,substruct(subs{:}));
            if isa(cfg_tmp,'cfg_exbranch')
                answ = questdlg([answer{1} ' already exists... override?'],'Override?');
                switch answ
                    case 'Yes'
                        iscfg_callsystem = true;
                        break
                    otherwise
                        return
                end
            end
        else
            break
        end
    end
    if ~iscfg_callsystem
        subs = [subs, {'.','values','{}',{length(cfg_tmp.values)+1}}];
        subs = substruct(subs{:});
    end
end

if ~iscfg_callsystem
    
    for ii=length(tree)-1:-1:(jj-1)
        cfg_tmp         = cfg_choice;
        cfg_tmp.tag     = genvarname(lower(tree{ii}));
        cfg_tmp.name    = tree{ii};
        cfg_tmp.values  = {cfg_new};
        cfg_new = cfg_tmp;
    end
    if new
        cfg = cfg_new;
    else
        cfg = subsasgn(cfg,subs,cfg_new.values{1});
    end
    jobstr = gencode(cfg);
    
    %write
    fid = fopen(fullfile(directory,['cfg_' tree{1} '.m']),'wt');
    fprintf(fid, 'function cfg = %s(varargin)\n\n',['cfg_' tree{1}]);
    fprintf(fid, '%s\n',jobstr{:});
    fclose(fid);
end
