function call_matlab = cfg_cfg_call_matlab

% ---------------------------------------------------------------------
% evaluated Evaluated Input
% ---------------------------------------------------------------------
evaluated         = cfg_entry;
evaluated.tag     = 'evaluated';
evaluated.name    = 'Evaluated Input';
evaluated.strtype = 'e';
evaluated.num     = [];
% ---------------------------------------------------------------------
% string String
% ---------------------------------------------------------------------
string         = cfg_entry;
string.tag     = 'string';
string.name    = 'String';
string.strtype = 's';
string.num     = [];
% ---------------------------------------------------------------------
% anyfile Any File
% ---------------------------------------------------------------------
anyfile         = cfg_files;
anyfile.tag     = 'anyfile';
anyfile.name    = 'Any File';
anyfile.filter = {'any'};
anyfile.ufilter = '.*';
anyfile.num     = [0 Inf];
% ---------------------------------------------------------------------
% images NIfTI Image(s)
% ---------------------------------------------------------------------
images         = cfg_files;
images.tag     = 'images';
images.name    = 'NIfTI Image(s)';
images.filter = {'image'};
images.ufilter = '.*';
images.num     = [0 Inf];
% ---------------------------------------------------------------------
% directory Directory
% ---------------------------------------------------------------------
directory         = cfg_files;
directory.tag     = 'directory';
directory.name    = 'Directory';
directory.filter = {'dir'};
directory.ufilter = '.*';
directory.num     = [0 Inf];
% ---------------------------------------------------------------------
% inputs Inputs
% ---------------------------------------------------------------------
inputs         = cfg_repeat;
inputs.tag     = 'inputs_';
inputs.name    = 'Inputs';
inputs.help    = {'Assemble the inputs to the called function in their correct order.'};
inputs.values  = {evaluated string anyfile images directory };
inputs.num     = [0 Inf];
inputs.forcestruct = true;
% ---------------------------------------------------------------------
% s String
% ---------------------------------------------------------------------
s         = cfg_const;
s.tag     = 's';
s.name    = 'String';
s.val = {true};
% ---------------------------------------------------------------------
% e Evaluated
% ---------------------------------------------------------------------
e         = cfg_const;
e.tag     = 'e';
e.name    = 'Evaluated';
e.val = {true};
% ---------------------------------------------------------------------
% n Natural number
% ---------------------------------------------------------------------
n         = cfg_const;
n.tag     = 'n';
n.name    = 'Natural number';
n.val = {true};
% ---------------------------------------------------------------------
% w Whole number
% ---------------------------------------------------------------------
w         = cfg_const;
w.tag     = 'w';
w.name    = 'Whole number';
w.val = {true};
% ---------------------------------------------------------------------
% i Integer
% ---------------------------------------------------------------------
i         = cfg_const;
i.tag     = 'i';
i.name    = 'Integer';
i.val = {true};
% ---------------------------------------------------------------------
% r Real number
% ---------------------------------------------------------------------
r         = cfg_const;
r.tag     = 'r';
r.name    = 'Real number';
r.val = {true};
% ---------------------------------------------------------------------
% strtype Type of output variable
% ---------------------------------------------------------------------
strtype         = cfg_choice;
strtype.tag     = 'strtype';
strtype.name    = 'Type of output variable';
strtype.values  = {s e n w i r };
% ---------------------------------------------------------------------
% any Any file
% ---------------------------------------------------------------------
any         = cfg_const;
any.tag     = 'any';
any.name    = 'Any file';
any.val = {true};
% ---------------------------------------------------------------------
% batch Batch file
% ---------------------------------------------------------------------
batch         = cfg_const;
batch.tag     = 'batch';
batch.name    = 'Batch file';
batch.val = {true};
% ---------------------------------------------------------------------
% dir Directory
% ---------------------------------------------------------------------
dir         = cfg_const;
dir.tag     = 'dir';
dir.name    = 'Directory';
dir.val = {true};
% ---------------------------------------------------------------------
% image Image(s)
% ---------------------------------------------------------------------
image         = cfg_const;
image.tag     = 'image';
image.name    = 'Image(s)';
image.val = {true};
% ---------------------------------------------------------------------
% mat MATLAB .mat file
% ---------------------------------------------------------------------
mat         = cfg_const;
mat.tag     = 'mat';
mat.name    = 'MATLAB .mat file';
mat.val = {true};
% ---------------------------------------------------------------------
% mesh Mesh file
% ---------------------------------------------------------------------
mesh         = cfg_const;
mesh.tag     = 'mesh';
mesh.name    = 'Mesh file';
mesh.val = {true};
% ---------------------------------------------------------------------
% nifti NIfTI file
% ---------------------------------------------------------------------
nifti         = cfg_const;
nifti.tag     = 'nifti';
nifti.name    = 'NIfTI file';
nifti.val = {true};
% ---------------------------------------------------------------------
% xml XML File
% ---------------------------------------------------------------------
xml         = cfg_const;
xml.tag     = 'xml';
xml.name    = 'XML File';
xml.val = {true};
% ---------------------------------------------------------------------
% filter Type of output file
% ---------------------------------------------------------------------
filter         = cfg_choice;
filter.tag     = 'filter';
filter.name    = 'Type of output file';
filter.values  = {any batch dir image mat mesh nifti xml };
% ---------------------------------------------------------------------
% outputs Outputs
% ---------------------------------------------------------------------
outputs         = cfg_repeat;
outputs.tag     = 'outputs_';
outputs.name    = 'Outputs';
outputs.values  = {strtype filter };
outputs.num     = [0 Inf];
outputs.forcestruct = true;
% ---------------------------------------------------------------------
% fun Function to be called
% ---------------------------------------------------------------------
fun         = cfg_entry;
fun.tag     = 'fun';
fun.name    = 'Function to be called';
fun.strtype = 'f';
fun.num     = [1  1];
% ---------------------------------------------------------------------
% call_matlab Call MATLAB function
% ---------------------------------------------------------------------
call_matlab         = cfg_exbranch;
call_matlab.tag     = 'call_matlab';
call_matlab.name    = 'Call MATLAB function';
call_matlab.val     = {inputs outputs fun };
call_matlab.prog = @(job)cfg_run_call_matlab('run',job);
call_matlab.vout = @(job)cfg_run_call_matlab('vout',job);
call_matlab.preview = @(job)cfg_run_call_matlab('save',job);
