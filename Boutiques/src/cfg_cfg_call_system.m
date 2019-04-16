function call_system = cfg_cfg_call_system

% evaluated value
% ---------------------------------------------------------------------
evaluated         = cfg_entry;
evaluated.tag     = 'evaluated';
evaluated.name    = 'value';
evaluated.strtype = 'e';
evaluated.num     = [];
% ---------------------------------------------------------------------
% help Help Paragraph
% ---------------------------------------------------------------------
help         = cfg_entry;
help.tag     = 'help';
help.name    = 'Description:';
help.val     = {''};
help.help    = {
                'Help paragraph on this input/output/option.'
                'Enter a Text.'
                }';
help.strtype = 's';
help.num     = [0  Inf];
% ---------------------------------------------------------------------
% evaluatedbranch Evaluated Input
% ---------------------------------------------------------------------
evaluatedbranch         = cfg_branch;
evaluatedbranch.tag     = 'evaluatedbranch';
evaluatedbranch.name    = 'Evaluated';
evaluatedbranch.val     = {help evaluated};
evaluatedbranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% string value
% ---------------------------------------------------------------------
string         = cfg_entry;
string.tag     = 'string';
string.name    = 'value';
string.strtype = 's';
string.num     = [];

% ---------------------------------------------------------------------
% stringbranch String
% ---------------------------------------------------------------------
stringbranch         = cfg_branch;
stringbranch.tag     = 'stringbranch';
stringbranch.name    = 'String';
stringbranch.val     = {help string };
stringbranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% anyfile value
% ---------------------------------------------------------------------
anyfile         = cfg_files;
anyfile.tag     = 'anyfile';
anyfile.name    = 'value';
anyfile.filter = {'any'};
anyfile.ufilter = '.*';
anyfile.num     = [0 Inf];

% ---------------------------------------------------------------------
% anyfilebranch anyfile Input
% ---------------------------------------------------------------------
anyfilebranch         = cfg_branch;
anyfilebranch.tag     = 'anyfilebranch';
anyfilebranch.name    = 'anyfile';
anyfilebranch.val     = {help anyfile };
anyfilebranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% directory value
% ---------------------------------------------------------------------
directory         = cfg_files;
directory.tag     = 'directory';
directory.name    = 'value';
directory.filter = {'dir'};
directory.ufilter = '.*';
directory.num     = [0 Inf];

% ---------------------------------------------------------------------
% directorybranch directory Input
% ---------------------------------------------------------------------
directorybranch         = cfg_branch;
directorybranch.tag     = 'directorybranch';
directorybranch.name    = 'directory';
directorybranch.val     = {help directory };
directorybranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% inputs Inputs
% ---------------------------------------------------------------------
inputs         = cfg_repeat;
inputs.tag     = 'inputs_';
inputs.name    = 'Inputs';
inputs.help    = {'Assemble the inputs to the called function in their correct order.'};
inputs.values  = {evaluatedbranch stringbranch anyfilebranch directorybranch };
inputs.num     = [0 Inf];
inputs.forcestruct = true;
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
% string filename
% ---------------------------------------------------------------------
string         = cfg_entry;
string.tag     = 'string';
string.name    = 'filename';
string.strtype = 's';
string.num     = [];
% ---------------------------------------------------------------------
% outputs Output file
% ---------------------------------------------------------------------
outputs1         = cfg_branch;
outputs1.tag     = 'outputs';
outputs1.name    = 'Output file';
outputs1.val     = {help directory string };
outputs1.help    = {'Assemble the outputs to the called function in their correct order.'};
% ---------------------------------------------------------------------
% outputs Outputs
% ---------------------------------------------------------------------
outputs         = cfg_repeat;
outputs.tag     = 'outputs_';
outputs.name    = 'Outputs';
outputs.help    = {'Assemble the outputs to the called function in their correct order.'};
outputs.values  = {outputs1 };
outputs.num     = [0 Inf];
outputs.forcestruct = true;
% ---------------------------------------------------------------------
% cmd Command to be called
% ---------------------------------------------------------------------
cmd         = cfg_entry;
cmd.tag     = 'cmd';
cmd.name    = 'Command to be called';
cmd.help    = {
                      'Example of command line expression:'
                      '  * fslmerge on three volumes over time:'
                      '        fslmerge -t o1 i1 i2 i3'
                      '     The first word (i.e. fslmerge) IS the binary'
                      '     "i1" will be replaced by first input value'
                      '     "i2" will be replaced by second input value'
                      '     "i3" will be replaced by third input value'
                      '     "o1" will be replaced by first output value and will be avaibable as a virtual output (dependency for next modules)'
                      '  * antsRegistration of moving volume i1 to reference volume i2 with interpolation i3 (=Linear):'
                      '        antsRegistration --dimensionality 3 --metric Mattes[ i2 , i1 ,1,32] --transform Rigid[.5] -c 10x10 -f 10x5 -s 1x1vox --interpolation i3 --output o1'
                      '     second output value (o2) can be used to defined the virtual output *0GenericAffine.mat. Does not need to be part of the cmd'
}';
cmd.strtype = 's';
cmd.num     = [1  Inf];
% ---------------------------------------------------------------------
% dockerimg docker image
% ---------------------------------------------------------------------
dockerimg         = cfg_entry;
dockerimg.tag     = 'dockerimg';
dockerimg.name    = 'docker image';
dockerimg.val     = {'bids/mrtrix3_connectome'};
dockerimg.strtype = 's';
dockerimg.num     = [1  Inf];
% ---------------------------------------------------------------------
% nodocker No
% ---------------------------------------------------------------------
nodocker         = cfg_const;
nodocker.tag     = 'nodocker';
nodocker.name    = 'No';
nodocker.val = {true};
% ---------------------------------------------------------------------
% usedocker Use Docker
% ---------------------------------------------------------------------
usedocker         = cfg_choice;
usedocker.tag     = 'usedocker_';
usedocker.name    = 'Use Docker';
usedocker.help    = {
                     'Run command on a docker image?'
                     'Docker needs to be installed and running.'
                     }';
usedocker.val     = {dockerimg};
usedocker.values  = {dockerimg nodocker };
% ---------------------------------------------------------------------
% call_system Call System command
% ---------------------------------------------------------------------
call_system         = cfg_exbranch;
call_system.tag     = 'call_system';
call_system.name    = 'Generic command';
call_system.val     = {inputs outputs cmd usedocker };
call_system.prog = @(job)cfg_run_call_system('run',job);
call_system.vout = @(job)cfg_run_call_system('vout',job);
call_system.preview = @(job)cfg_run_call_system('save',job);

