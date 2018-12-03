function call_matlab = cfg_cfg_call_matlab

% ---------------------------------------------------------------------
% help Help Paragraph
% ---------------------------------------------------------------------
help         = cfg_entry;
help.tag     = 'help';
help.name    = 'Description:';
help.val = {''};
help.help    = {
                'Help paragraph on this input/output/option.'
                'Enter a Text.'
                }';
help.strtype = 's';
help.num     = [0  Inf];
% ---------------------------------------------------------------------
% evaluated Value
% ---------------------------------------------------------------------
evaluated         = cfg_entry;
evaluated.tag     = 'evaluated';
evaluated.name    = 'Value';
evaluated.strtype = 'e';
evaluated.num     = [];
% ---------------------------------------------------------------------
% evaluatedbranch Evaluated
% ---------------------------------------------------------------------
evaluatedbranch         = cfg_branch;
evaluatedbranch.tag     = 'evaluatedbranch';
evaluatedbranch.name    = 'Evaluated Input';
evaluatedbranch.val     = {help evaluated};
evaluatedbranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% string String
% ---------------------------------------------------------------------
string         = cfg_entry;
string.tag     = 'string';
string.name    = 'Value';
string.strtype = 's';
string.num     = [];
% ---------------------------------------------------------------------
% stringbranch string
% ---------------------------------------------------------------------
stringbranch         = cfg_branch;
stringbranch.tag     = 'stringbranch';
stringbranch.name    = 'String';
stringbranch.val     = {help string};
stringbranch.help    = {'Detail this input'};
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
% anyfilebranch anyfile
% ---------------------------------------------------------------------
anyfilebranch         = cfg_branch;
anyfilebranch.tag     = 'anyfilebranch';
anyfilebranch.name    = 'anyfile';
anyfilebranch.val     = {help anyfile};
anyfilebranch.help    = {'Detail this input'};
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
% imagesbranch Images
% ---------------------------------------------------------------------
imagesbranch         = cfg_branch;
imagesbranch.tag     = 'imagesbranch';
imagesbranch.name    = 'Images';
imagesbranch.val     = {help images};
imagesbranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% directory Path
% ---------------------------------------------------------------------
directory         = cfg_files;
directory.tag     = 'directory';
directory.name    = 'Directory Path';
directory.filter = {'dir'};
directory.ufilter = '.*';
directory.num     = [0 Inf];
% ---------------------------------------------------------------------
% directorybranch Directory
% ---------------------------------------------------------------------
directorybranch         = cfg_branch;
directorybranch.tag     = 'directorybranch';
directorybranch.name    = 'Directory';
directorybranch.val     = {help directory};
directorybranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% inputs Inputs
% ---------------------------------------------------------------------
inputs         = cfg_repeat;
inputs.tag     = 'inputs_';
inputs.name    = 'Inputs';
inputs.help    = {'Assemble the inputs to the called function in their correct order.'};
inputs.values  = {evaluatedbranch stringbranch anyfilebranch imagesbranch directorybranch };
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
% strtypebranch Type of output variable
% ---------------------------------------------------------------------
strtypebranch         = cfg_branch;
strtypebranch.tag     = 'strtypebranch';
strtypebranch.name    = 'Variable';
strtypebranch.val     = {help strtype};
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
% filename Filename
% ---------------------------------------------------------------------
filename         = cfg_entry;
filename.tag     = 'filename';
filename.name    = 'Filename';
filename.strtype = 's';
filename.num     = [];
% ---------------------------------------------------------------------
% filter Type of output file
% ---------------------------------------------------------------------
filter         = cfg_choice;
filter.tag     = 'filter';
filter.name    = 'Type of output file';
filter.values  = {any batch dir image mat mesh nifti xml };
% ---------------------------------------------------------------------
% filterbranch Type of output file
% ---------------------------------------------------------------------
filterbranch         = cfg_branch;
filterbranch.tag     = 'filterbranch';
filterbranch.name    = 'File';
filterbranch.val     = {help directory filename filter};
% ---------------------------------------------------------------------
% outputs Outputs
% ---------------------------------------------------------------------
outputs         = cfg_repeat;
outputs.tag     = 'outputs_';
outputs.name    = 'Outputs';
outputs.values  = {strtypebranch filterbranch };
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
