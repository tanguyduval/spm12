function cfg_preview_parsebids(bids_dir)
if iscell(bids_dir), bids_dir = bids_dir{1}; end
BIDS = bids_parser(bids_dir);
hh = figure('Name',['BIDS directory (' bids_dir ')']);
set(hh,'MenuBar','none')
uitable('Data',[{BIDS.subjects.name}', {BIDS.subjects.session}'],'ColumnName',{'subject', 'session'},'Units', 'Normalized', 'Position',[0, 0, 1, 1])