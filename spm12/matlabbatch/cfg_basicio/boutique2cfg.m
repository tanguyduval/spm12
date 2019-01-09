function [cfg, def] = boutique2cfg(json)
% Load single boutiques json

% CFG
cfg = cfg_cfg_call_system;
cfg.name = json.name;
cfg.tag = genvarname(lower(json.name));
if isfield(json,'description')
    cfg.help = cellstr(json.description);
end

% DEF
def.cmd = json.command_0x2D_line;

% groups
if isfield(json,'groups')
for ig = 1:length(json.groups)
    if isfield(json.groups{ig},'one_0x2D_is_0x2D_required') && json.groups{ig}.one_0x2D_is_0x2D_required
        if isfield(json.groups{ig},'mutually_0x2D_exclusive') && json.groups{ig}.mutually_0x2D_exclusive % set first as mandatory
%             newchoice        = cfg_choice;
%             newchoice.name   = json.groups{ig}.name;
%             newchoice.help   = {json.groups{ig}.description};
%             newchoice.tag    = json.groups{ig}.id;
            for ic = 1:length(json.groups{ig}.members)
                inputic = strcmp(json.groups{ig}.members{ic},cellfun(@(x) x.id,json.inputs,'uni',0));
%                 switch json.inputs{inputic}.type
%                     case 'File'
%                         Nval = cellfun(@(x) strcmp(x.tag,'anyfilebranch'),cfg.val{1}.values);
%                     case 'String'
%                          Nval = cellfun(@(x) strcmp(x.tag,'stringbranch'),cfg.val{1}.values);
%                     case 'Number'
%                          Nval = cellfun(@(x) strcmp(x.tag,'evaluatedbranch'),cfg.val{1}.values);
%                 end
%                 tmp = cfg.val{1}.values{Nval};
%                 tmp.name = json.inputs{inputic}.name;
%                 tmp.tag  =  json.inputs{inputic}.id;
%                 newchoice.values{end+1} = tmp;
                if ic==1
                    json.inputs{inputic}.optional = 0;
                end
            end
            
          %  cfg.val{1}.values{end+1} = newchoice;
            
        else % set all as mandatory
            for ic = 1:length(json.groups{ig}.members)
                inputic = strcmp(json.groups{ig}.members{ic},cellfun(@(x) x.id,json.inputs,'uni',0));
                json.inputs{inputic}.optional = 0;
            end
        end
    end
end
end

% Mandatory inputs
inKey = {};
if isfield(json,'inputs')
def.inputs_ = {};
for ii = 1:length(json.inputs)
    if ~json.inputs{ii}.optional
        inKey{end+1} = json.inputs{ii}.value_0x2D_key;
        % help
        switch json.inputs{ii}.type
            case 'File'
                type = 'anyfilebranch';
            case 'String'
                if strfind(lower(json.inputs{ii}.name),'directory')
                    type = 'directorybranch';
                else
                    type = 'stringbranch';
                end
            case 'Number'
                type = 'evaluatedbranch';
        end
        if isfield(json.inputs{ii},'value_0x2D_choices')
            json.inputs{ii}.value_0x2D_choices = cellfun(@char,json.inputs{ii}.value_0x2D_choices,'uni',0);
            json.inputs{ii}.name = [json.inputs{ii}.name ': {' json.inputs{ii}.value_0x2D_choices{:} '}'];
        end
        def.inputs_{end+1}.(type).help  = json.inputs{ii}.name;

        % default-value
        if isfield(json.inputs{ii},'default_0x2D_value')
            def.inputs_{end}.(type).(strrep(type,'branch','')) = json.inputs{ii}.default_0x2D_value;
        else
            def.inputs_{end}.(type).(strrep(type,'branch','')) = '<UNDEFINED>';
        end
        % replace flag [FLAG] --> %i1
        if ~isfield(json.inputs{ii},'command_0x2D_line_0x2D_flag'), json.inputs{ii}.command_0x2D_line_0x2D_flag = ''; end
        def.cmd = strrep(def.cmd,json.inputs{ii}.value_0x2D_key,[json.inputs{ii}.command_0x2D_line_0x2D_flag '%i' num2str(length(def.inputs_))]);
    else
        def.cmd = strrep(def.cmd,json.inputs{ii}.value_0x2D_key,'');
    end
end
end

% Outputs
if isfield(json,'output_0x2D_files')
    def.outputs_ = {};
    for io = 1:length(json.output_0x2D_files)
        if json.output_0x2D_files{io}.optional == 0
            def.outputs_{end+1}.outputs.help      = json.output_0x2D_files{io}.name;
            if isfield(json.output_0x2D_files{io},'path_0x2D_template')
                for ikey = 1:length(inKey)
                    json.output_0x2D_files{io}.path_0x2D_template = strrep(json.output_0x2D_files{io}.path_0x2D_template,inKey{ikey},['%i' num2str(ikey)]);
                end
                [path,file,ext]                     = fileparts(json.output_0x2D_files{io}.path_0x2D_template);
                if isempty(path)
                    def.outputs_{end}.outputs.directory = '<UNDEFINED>';
                else
                    def.outputs_{end}.outputs.directory = {path};
                end
                if isempty(file)
                    def.outputs_{end}.outputs.string    = '<UNDEFINED>';
                else
                    def.outputs_{end}.outputs.string    = [file ext];
                end
            else
                def.outputs_{end}.outputs.directory = '<UNDEFINED>';
                def.outputs_{end}.outputs.string = '<UNDEFINED>';
            end
            if isfield(json.output_0x2D_files{io},'value_0x2D_key')
                if ~isfield(json.output_0x2D_files{io},'command_0x2D_line_0x2D_flag'), json.output_0x2D_files{io}.command_0x2D_line_0x2D_flag = ''; end
                def.cmd = strrep(def.cmd,json.output_0x2D_files{io}.value_0x2D_key,[json.output_0x2D_files{io}.command_0x2D_line_0x2D_flag '%o' num2str(length(def.outputs_))]);
            end
        else
            if isfield(json.output_0x2D_files{io},'value_0x2D_key')
                def.cmd = strrep(def.cmd,json.output_0x2D_files{io}.value_0x2D_key,'');
            end
        end
    end
end

if isfield(json,'container_0x2D_image') && strcmp(json.container_0x2D_image.type,'docker')
    def.usedocker_.dockerimg = json.container_0x2D_image.image;
end
        
        