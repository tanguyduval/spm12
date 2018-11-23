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

            [directory, tree] = generatetree(['System.' cmdcell{1}],cfg_cfg_call_system);
            if isempty(tree), return; end
            
            % generate cfg_CML_def
            jobstr = generatecfgdef(tree,job);
            cfg_def_fname = fullfile(directory,['cfg_' tree{1} '_def.m']);
            fid = fopen(cfg_def_fname,'wt');
            fprintf(fid, 'function %s = cfg_%s_def\n',lower(tree{1}),tree{1});
            fprintf(fid, '%s\n',jobstr{:});
            fclose(fid);
            disp(['files added in ' directory])
            
        case 'delete'
            job = varargin{1};
            deffile = fieldnames(job);
            [directory, cfgfile] = fileparts(which(['cfg_' deffile{1} '.m']));
            cfg = feval(cfgfile);

            subs=[];
            cfg_tmp = cfg;
            subjob = job.(deffile{1});
            while length(fieldnames(subjob))==1
                tag = fieldnames(subjob);
                tag = tag{1};
                ind = ismember(tagnames(cfg_tmp,1),tag);
                subs = [subs, {'.','values','{}',{find(ind)}}];
                cfg_tmp = cfg_tmp.values{find(ind)};
                subjob = subjob.(tag);
            end
            subs = substruct(subs{:});
            newsubcfg = subsref(cfg,subs(1:end-1));
            newsubcfg(subs(end).subs{1}) = [];
            cfg_new = subsasgn(cfg,subs(1:end-1),newsubcfg);
            
            %write
            fid = fopen(fullfile(directory,[cfgfile '.m']),'wt');
            fprintf(fid, 'function cfg = %s(varargin)\n\n',cfgfile);
            jobstr = gencode(cfg_new,'cfg')';
            fprintf(fid, '%s\n',jobstr{:});
            fclose(fid);
            
            % read def
            defstr = gencode(job.(deffile{1}),deffile{1})';
            loc = cell2mat(strfind(defstr,'.cmd = '));
            pattern = defstr{1}(1:loc);
            func = str2func([cfgfile '_def']);
            cfgdef = feval(func);
            jobdefstr = gencode(cfgdef,deffile{1})';
            jobdefstr = jobdefstr(cell2mat(cellfun(@isempty,strfind(jobdefstr,pattern),'uni',0)));
            fid = fopen(fullfile(directory,[cfgfile '_def.m']),'wt');
            fprintf(fid, 'function %s = cfg_%s_def\n',lower(deffile{1}),deffile{1});
            fprintf(fid, '%s\n',jobdefstr{:});
            fclose(fid);
            
            disp(['module ' pattern(1:end-1) ' deleted'])
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
if isfield(job,'inputs_'), job.inputs=job.inputs_; job = rmfield(job,'inputs_');   end
if isfield(job,'outputs_'), job.outputs=job.outputs_; job = rmfield(job,'outputs_'); end
if isfield(job,'usedocker_'), job.usedocker=job.usedocker_; job = rmfield(job,'usedocker_'); end
end

function tree = local_tag2cfgtree(cfg,tag)
if strcmpi(gettag(cfg),tag)
    tree = gettag(cfg);
elseif ~isa(cfg,'cfg_exbranch')
    tags = tagnames(cfg,1);
    for ii=1:length(tags)
        tree = local_tag2cfgtree(cfg.values{ii},tag);
        if ~isempty(tree)
            tree = [gettag(cfg) '.' tree];
            break;
        end
    end
else
    tree = [];
end