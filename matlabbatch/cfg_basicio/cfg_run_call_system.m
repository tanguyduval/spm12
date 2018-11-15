function varargout = cfg_run_call_system(cmd, varargin)
% A generic interface to call any system command through the batch system
% and make its output arguments available as dependencies.
% varargout = cfg_run_call_matlab(cmd, varargin)
% where cmd is one of
% 'run'      - out = cfg_run_call_system('run', job)
%              Run the command, and return the specified output arguments
% 'vout'     - dep = cfg_run_call_system('vout', job)
%              Return dependencies as specified via the output cfg_repeat.
% 'check'    - str = cfg_run_call_system('check', subcmd, subjob)
%              Examine a part of a fully filled job structure. Return an empty
%              string if everything is ok, or a string describing the check
%              error. subcmd should be a string that identifies the part of
%              the configuration to be checked.
% 'defaults' - defval = cfg_run_call_system('defaults', key)
%              Retrieve defaults value. key must be a sequence of dot
%              delimited field names into the internal def struct which is
%              kept in function local_def. An error is returned if no
%              matching field is found.
%              cfg_run_call_system('defaults', key, newval)
%              Set the specified field in the internal def struct to a new
%              value.
% Application specific code needs to be inserted at the following places:
% 'run'      - main switch statement: code to compute the results, based on
%              a filled job
% 'vout'     - main switch statement: code to compute cfg_dep array, based
%              on a job structure that has all leafs, but not necessarily
%              any values filled in
% 'check'    - create and populate switch subcmd switchyard
% 'defaults' - modify initialisation of defaults in subfunction local_defs
% Callbacks can be constructed using anonymous function handles like this:
% 'run'      - @(job)cfg_run_call_system('run', job)
% 'vout'     - @(job)cfg_run_call_system('vout', job)
% 'check'    - @(job)cfg_run_call_system('check', 'subcmd', job)
% 'defaults' - @(val)cfg_run_call_system('defaults', 'defstr', val{:})
%              Note the list expansion val{:} - this is used to emulate a
%              varargin call in this function handle.
%
% This code is part of a batch job configuration system for MATLAB. See 
%      help matlabbatch
% for a general overview.
%_______________________________________________________________________
% Copyright (C) 2018 Toulouse Neuroimaging Center

% Tanguy Duval

if ischar(cmd)
    switch lower(cmd)
        case 'run'
            job = local_getjob(varargin{1},true);
            % do computation, return results in variable out
            in     = cell(size(job.inputs));
            inhelp = cell(size(job.inputs));
            for k = 1:numel(in)
                intmp = job.inputs{k}.(char(fieldnames(job.inputs{k})));
                inhelp{k} = intmp.help;
                intmp = intmp.(char(setdiff(fieldnames(intmp),'help')));

                switch char(fieldnames(job.inputs{k}))
                    case 'evaluatedbranch'
                        in{k} = {char(string(intmp))};
                    case 'anyfilebranch'
                        in{k} = intmp;
                    case 'stringbranch'
                        in{k} = {char(intmp)};
                    otherwise
                        in{k} = {char(string(intmp))};
                end
            end
                        
            % Check if all outputs already exists
            out.outputs = cell(size(job.outputs));
            out.outputs = job.outputs;
            if ~isempty(job.outputs)
                alreadyexist = true;
                for io = 1:length(job.outputs)
                    % replace token
                    tokens = regexp(job.outputs{io}.outputs.string,'(%i\d)','match');
                    for itok = 1:length(tokens)
                        job.outputs{io}.outputs.string = strrep(job.outputs{io}.outputs.string,tokens{itok},in{str2double(tokens{itok}(3:end))}{1});
                    end
                    out.outputs{io} = {fullfile(job.outputs{io}.outputs.directory{1},job.outputs{io}.outputs.string)};
                    alreadyexist = alreadyexist & exist(out.outputs{io}{1},'file');
                end
                if alreadyexist
                    disp(['<strong>output file already exists, assuming that the processing was already done... skipping</strong>'])
                    disp(['Delete output file to restart this job = ' out.outputs{1}{1}])
                end
            else
                alreadyexist = false;
            end
            
            % DOCKERIFY
            mountdir = '';
            for k = 1:numel(in)
                type = fieldnames(job.inputs{k});
                if strcmp(type{1},'directorybranch')
                mountdir = [mountdir '-v "' in{k}{1} ':/i' num2str(k) '" '];
                dockerinfname{k} = ['/i' num2str(k) '/'];
                else
                mountdir = [mountdir '-v "' fileparts(in{k}{1}) ':/i' num2str(k) '" '];
                dockerinfname{k} = strrep(in{k}{1},[fileparts(in{k}{1}) filesep],['/i' num2str(k) '/']);
                end
            end
            for k = 1:numel(job.outputs)
                mountdir = [mountdir '-v "' fullfile(job.outputs{k}.outputs.directory{1},fileparts(job.outputs{k}.outputs.string)) ':/o' num2str(k) '" '];
                dockeroutfname{k} = strrep(fullfile(job.outputs{io}.outputs.directory{1},job.outputs{k}.outputs.string),[fileparts(fullfile(job.outputs{io}.outputs.directory{1},job.outputs{k}.outputs.string)) filesep],['/o' num2str(k) '/']);
            end

            
            if ~alreadyexist
                % Replace token i%d and o%d by filenames
                cmd = job.cmd;
                for ii=1:length(in)
                    if isfield(job.usedocker,'dockerimg') 
                        cmd = strrep(cmd,sprintf('%%i%d',ii),dockerinfname{ii});
                        cmd = strrep(cmd,[' ' sprintf('i%d',ii)],[' ' dockerinfname{ii} ' ']);
                    else
                        cmd = strrep(cmd,sprintf('%%i%d',ii),in{ii}{1});
                        cmd = strrep(cmd,[' ' sprintf('i%d',ii)],[' ' in{ii}{1} ' ']);
                    end
                end
                for ii=1:length(job.outputs)
                    if isfield(job.usedocker,'dockerimg')
                        cmd = strrep(cmd,sprintf('%%o%d',ii),dockeroutfname{ii});
                        cmd = strrep(cmd,[' ' sprintf('o%d',ii)],[' ' dockeroutfname{ii} ' ']);
                    else
                        cmd = strrep(cmd,sprintf('%%i%d',ii),out.outputs{ii}{1});
                        cmd = strrep(cmd,[' ' sprintf('o%d',ii)],[' ' out.outputs{ii}{1} ' ']);
                    end
                end
                
                % RUN SYSTEM COMMAND
                if ~isfield(job.usedocker,'dockerimg')
                    disp(['Running terminal command: ' cmd])
                    [status, stdout]=system(cmd,'-echo');
                    if status, error(sprintf('%s\n\nLocal command:\n%s\n',stdout,cmd)); end
                else % docker
                    cmdcell = strsplit(cmd);
                    cmddocker = ['docker run --entrypoint ' cmdcell{1} ' ' mountdir job.usedocker.dockerimg ' ' strjoin(cmdcell(2:end))];
                    disp(['Running terminal command: ' cmddocker])
                    [status, stdout]=system(cmddocker,'-echo');
                    if status, error(sprintf('%s\nLocal command: \n%s\n\nCorresponding Docker command:\n%s\n',stdout,cmd,cmddocker)); end
                end
                
                
                
                % gunzip output for FSL if .nii was used
                for io=1:length(out.outputs)
                    if ~exist(out.outputs{io}{1},'file') && exist([out.outputs{io}{1} '.gz'],'file')
                        gunzip([out.outputs{io}{1} '.gz'])
                        delete([out.outputs{io}{1} '.gz'])
                    end
                end
            end
            
            if nargout > 0
                varargout{1} = out;
            end
        case 'vout'
            job = local_getjob(varargin{1},true);
            % initialise empty cfg_dep array
            dep = cfg_dep;
            dep = dep(false);
            % determine outputs, return cfg_dep array in variable dep
            if isfield(job,'outputs')
                for k = 1:numel(job.outputs)
                    dep(k)            = cfg_dep;
                    cmdstring = strsplit(job.cmd);
                    dep(k).sname      = sprintf('%s: output %d - %s',cmdstring{1}, k, char(job.outputs{k}.outputs.string));
                    dep(k).src_output = substruct('.','outputs','{}',{k});
                    dep(k).tgt_spec   = cfg_findspec({{'filter', char(fieldnames(job.outputs{k}))}});
                end
            end
            varargout{1} = dep;
        case 'check'
            if ischar(varargin{1})
                subcmd = lower(varargin{1});
                subjob = varargin{2};
                str = '';
                switch subcmd
                    % implement checks, return status string in variable str
                    otherwise
                        cfg_message('unknown:check', ...
                            'Unknown check subcmd ''%s''.', subcmd);
                end
                varargout{1} = str;
            else
                cfg_message('ischar:check', 'Subcmd must be a string.');
            end
        case 'save'
            job = local_getjob(varargin{1},false);
            cmdcell = strsplit(job.cmd);
            % get user pref
            prompt = {'Module name:'};
            title = 'Save Command configuration';
            dims = [1 35];
            definput = {['System.',cmdcell{1}]};
            answer = inputdlg(prompt,title,dims,definput);
            if isempty(answer), return; end
            tree = strsplit(answer{1},'.');
            % create output dir
            directory = fullfile(fileparts(mfilename('fullpath')),tree{1});
            if ~exist(directory)
                mkdir(directory);
                new = true;
            else
                new = false;
            end
            
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
            cfg_new     = cfg_exbranch;
            cfg_new.tag = genvarname(lower(tree{end}));
            cfg_new.name = tree{end};
            
            jj=2;
            iscfg_exbranch=false;
            if ~new
                jobstr = fileread(fullfile(directory,['cfg_' tree{1} '.m']));
                jobstr = strrep(jobstr,'cfg_cfg_call_system','cfg_exbranch');
                fid = fopen(fullfile(directory,['cfg_' tree{1} '2.m']),'wt');
                fprintf(fid,'%s',jobstr);
                fclose(fid);
                cfg = feval(['cfg_' tree{1} '2']);
                delete(fullfile(directory,['cfg_' tree{1} '2.m']))
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
                                    iscfg_exbranch = true;
                                    break
                                otherwise
                                    return
                            end
                        end
                    else
                        break
                    end
                end
                if ~iscfg_exbranch
                    subs = [subs, {'.','values','{}',{length(cfg_tmp.values)+1}}];
                    subs = substruct(subs{:});
                end
            end
            
            if ~iscfg_exbranch
                
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
            jobstr = strrep(jobstr,'cfg_exbranch','cfg_cfg_call_system');
            
            %write
            fid = fopen(fullfile(directory,['cfg_' tree{1} '.m']),'wt');
            fprintf(fid, 'function cfg = %s(varargin)\n\n',['cfg_' tree{1}]);
            fprintf(fid, '%s\n',jobstr{:});
            fclose(fid);
            end
            
            % generate cfg_CML_def
            cfg_def_fname = fullfile(directory,['cfg_' tree{1} '_def.m']);
            if ~new
                addpath(directory)
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
            fid = fopen(cfg_def_fname,'wt');
            fprintf(fid, 'function %s = cfg_%s_def\n',lower(tree{1}),tree{1});
            fprintf(fid, '%s\n',jobstr{:});
            fclose(fid);
            disp(['files added in ' directory])
        otherwise
            cfg_message('unknown:cmd', 'Unknown command ''%s''.', cmd);
    end
else
    cfg_message('ischar:cmd', 'Cmd must be a string.');
end

function job = local_getjob(job,rename)
if ~isstruct(job)
    cfg_message('isstruct:job', 'Job must be a struct.');
end
if nargin>1 && rename
if isfield(job,'inputs_SetDefaultValOnLoad'), job.inputs=job.inputs_SetDefaultValOnLoad; job = rmfield(job,'inputs_SetDefaultValOnLoad');   end
if isfield(job,'outputs_SetDefaultValOnLoad'), job.outputs=job.outputs_SetDefaultValOnLoad; job = rmfield(job,'outputs_SetDefaultValOnLoad'); end
if isfield(job,'usedocker_SetDefaultValOnLoad'), job.usedocker=job.usedocker_SetDefaultValOnLoad; job = rmfield(job,'usedocker_SetDefaultValOnLoad'); end
end
