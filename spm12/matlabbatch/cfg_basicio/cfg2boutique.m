function json = cfg2boutique(job,parentfolder)


cmdcell = strsplit(job.cmd);
Name = ['Boutiques.' cmdcell{1}];
% get user pref
prompt = {'Module name:', 'Author', 'Documentation:'};
title = 'Save Command configuration';
dims = [1 35; 1 35; 12 100];
definput = {Name, '', ''};
try
[~,desc] = system_docker(job.usedocker_.dockerimg,[cmdcell{1} ' -h']);
listbalise = strfind(desc,sprintf('\b')); % in Mrtrix3
definput{3} = desc(setdiff(1:length(desc),[listbalise listbalise-1]));
end
answer = inputdlg(prompt,title,dims,definput);
if isempty(answer), return; end
tree = strsplit(answer{1},'.');
tree{1} = 'Boutiques';

% Tool Description
json.tool_0x2D_version      = '1.0.0';
json.name                   = tree{end};
json.author                 = answer{2};
json.description            = answer{3};

% Container field
if isfield(job,'usedocker_')
    if isfield(job.usedocker_,'dockerimg')
        json.container_0x2D_image.image   = job.usedocker_.dockerimg;
        json.container_0x2D_image.type    = 'docker';
    end
end

% Inputs
cmdfinal = job.cmd;
for ii = 1:length(job.inputs_)
    type = fieldnames(job.inputs_{ii}); type = type{1};
    description = job.inputs_{ii}.(type).help;
    name = strsplit(description, ':'); name = name{1};
    Default = job.inputs_{ii}.(type).(strrep(type,'branch',''));
    KEY =  strrep(upper(name),' ','_');
    KEY = ['[' KEY ']'];
    switch type
        case 'anyfilebranch'
            type = 'File';
        case 'stringbranch'
            type = 'String';
        case 'evaluatedbranch'
            type = 'Number';
        case 'directorybranch'
            type = 'String'; % directory not in Boutiques...
    end
    
    json.inputs{ii}.description          = description;
    if ~strcmp(Default,'<UNDEFINED>')
    json.inputs{ii}.default_0x2D_value   = Default;
    end
    json.inputs{ii}.value_0x2D_key       = KEY;
    json.inputs{ii}.type                 = type;
    json.inputs{ii}.optional             = 0;
    json.inputs{ii}.id                   = lower(KEY(2:end-1));
    json.inputs{ii}.name                 = name;
    
    cmdfinal = strrep(strrep(cmdfinal,['%i' num2str(ii)],KEY),[' i' num2str(ii)],[' ' KEY]);
end

% Outputs
for ii = 1:length(job.outputs_)
    description = job.outputs_{ii}.outputs.help;
    name = strsplit(description, ':'); name = name{1};
    if iscell(job.outputs_{ii}.outputs.directory), job.outputs_{ii}.outputs.directory = job.outputs_{ii}.outputs.directory{1}; end
    odir = strrep(job.outputs_{ii}.outputs.directory,'<UNDEFINED>','');
    ofile = strrep(job.outputs_{ii}.outputs.string,'<UNDEFINED>','');
    Default = fullfile(odir,ofile);
    for io = 1:length(job.inputs_)
        Default = strrep(Default,['%i' num2str(io)],json.inputs{io}.value_0x2D_key);
    end
    KEY =  strrep(upper(name),' ','_');
    KEY = ['[' KEY ']'];
    
    json.output_0x2D_files{ii}.description          = description;
    json.output_0x2D_files{ii}.value_0x2D_key       = KEY;
    json.output_0x2D_files{ii}.path_0x2D_template	= Default;
    json.output_0x2D_files{ii}.optional             = 0;
    json.output_0x2D_files{ii}.id                   = lower(KEY(2:end-1));
    json.output_0x2D_files{ii}.name                 = name;
    
    cmdfinal = strrep(strrep(cmdfinal,['%o' num2str(ii)],KEY),[' o' num2str(ii)],[' ' KEY]);

end


% ff = figure;
% TT = checkJson(ff,json);

json.command_0x2D_line      = cmdfinal;

% save json
folder = fullfile(parentfolder,tree{1:end-1});
mkdir(folder)
fname = fullfile(folder,[tree{end} '.json']);
savejson([],json,fname)
end

function TT = checkJson(ff,json)
TT = []; % important to allocate here!

in = [json.inputs{:}];
Tin = uitable(gcf,'Units','Normalized','Position',[0 0.5 1 0.5],'Data',[{in.description}', {in.value_0x2D_key}', {in.type}', {in.id}', {in.name}'],'ColumnName',{'Description                  ', 'value-key                ', 'type', 'id', 'name'});
Tin.ColumnEditable=true;
out = [json.output_0x2D_files{:}];
Tout = uitable(gcf,'Units','Normalized','Position',[0 0 1 0.5],'Data',[{out.description}', {out.value_0x2D_key}', {out.path_0x2D_template}', {out.id}', {out.name}'],'ColumnName',{'Description                  ', 'value-key                ', 'path-template                  ', 'id', 'name'});
Tout.ColumnEditable=true;

set(ff, 'CloseRequestFcn',@(h,e) myClose(h,e,Tin,Tout))
waitfor(ff)
%
    function myClose(h,e,Tin,Tout)
        TT.in = get(Tin, 'Data');
        TT.out = get(Tout, 'Data');
        delete(h)
    end

end

