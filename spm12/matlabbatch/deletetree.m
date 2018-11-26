function deletetree(job)

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
