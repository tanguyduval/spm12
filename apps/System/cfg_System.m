function cfg = cfg_System(varargin)

% ---------------------------------------------------------------------
% help Description:
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
% evaluated value
% ---------------------------------------------------------------------
evaluated         = cfg_entry;
evaluated.tag     = 'evaluated';
evaluated.name    = 'value';
evaluated.strtype = 'e';
evaluated.num     = [];
% ---------------------------------------------------------------------
% evaluatedbranch Evaluated Input
% ---------------------------------------------------------------------
evaluatedbranch         = cfg_branch;
evaluatedbranch.tag     = 'evaluatedbranch';
evaluatedbranch.name    = 'Evaluated Input';
evaluatedbranch.val     = {help evaluated };
evaluatedbranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% help Description:
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
% help Description:
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
anyfilebranch.name    = 'anyfile Input';
anyfilebranch.val     = {help anyfile };
anyfilebranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% help Description:
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
directorybranch.name    = 'directory Input';
directorybranch.val     = {help directory };
directorybranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% inputs_ Inputs
% ---------------------------------------------------------------------
inputs_         = cfg_repeat;
inputs_.tag     = 'inputs_';
inputs_.name    = 'Inputs';
inputs_.help    = {'Assemble the inputs to the called function in their correct order.'};
inputs_.values  = {evaluatedbranch stringbranch anyfilebranch directorybranch };
inputs_.num     = [0 Inf];
inputs_.forcestruct = true;
% ---------------------------------------------------------------------
% help Description:
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
outputs         = cfg_branch;
outputs.tag     = 'outputs';
outputs.name    = 'Output file';
outputs.val     = {help directory string };
outputs.help    = {'Assemble the outputs to the called function in their correct order.'};
% ---------------------------------------------------------------------
% outputs_ Outputs
% ---------------------------------------------------------------------
outputs_         = cfg_repeat;
outputs_.tag     = 'outputs_';
outputs_.name    = 'Outputs';
outputs_.help    = {'Assemble the outputs to the called function in their correct order.'};
outputs_.values  = {outputs };
outputs_.num     = [0 Inf];
outputs_.forcestruct = true;
% ---------------------------------------------------------------------
% cmd Command to be called
% ---------------------------------------------------------------------
cmd         = cfg_entry;
cmd.tag     = 'cmd';
cmd.name    = 'Command to be called';
%%
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
%%
cmd.strtype = 's';
cmd.num     = [1  Inf];
% ---------------------------------------------------------------------
% dockerimg docker image
% ---------------------------------------------------------------------
dockerimg         = cfg_entry;
dockerimg.tag     = 'dockerimg';
dockerimg.name    = 'docker image';
dockerimg.def     = @(defval)'bids/mrtrix3_connectome';
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
% usedocker_ Use Docker
% ---------------------------------------------------------------------
usedocker_         = cfg_choice;
usedocker_.tag     = 'usedocker_';
usedocker_.name    = 'Use Docker';
usedocker_.help    = {
                      'Run command on a docker image?'
                      'Docker needs to be installed and running.'
                      }';
usedocker_.values  = {dockerimg nodocker };
% ---------------------------------------------------------------------
% dwidenoise dwidenoise
% ---------------------------------------------------------------------
dwidenoise         = cfg_cfg_call_system;
dwidenoise.tag     = 'dwidenoise';
dwidenoise.name    = 'dwidenoise';
dwidenoise.val     = {inputs_ outputs_ cmd usedocker_ };
dwidenoise.prog = @(job)cfg_run_call_system('run',job);
dwidenoise.vout = @(job)cfg_run_call_system('vout',job);
% ---------------------------------------------------------------------
% help Description:
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
% evaluated value
% ---------------------------------------------------------------------
evaluated         = cfg_entry;
evaluated.tag     = 'evaluated';
evaluated.name    = 'value';
evaluated.strtype = 'e';
evaluated.num     = [];
% ---------------------------------------------------------------------
% evaluatedbranch Evaluated Input
% ---------------------------------------------------------------------
evaluatedbranch         = cfg_branch;
evaluatedbranch.tag     = 'evaluatedbranch';
evaluatedbranch.name    = 'Evaluated Input';
evaluatedbranch.val     = {help evaluated };
evaluatedbranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% help Description:
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
% help Description:
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
anyfilebranch.name    = 'anyfile Input';
anyfilebranch.val     = {help anyfile };
anyfilebranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% help Description:
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
directorybranch.name    = 'directory Input';
directorybranch.val     = {help directory };
directorybranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% inputs_ Inputs
% ---------------------------------------------------------------------
inputs_         = cfg_repeat;
inputs_.tag     = 'inputs_';
inputs_.name    = 'Inputs';
inputs_.help    = {'Assemble the inputs to the called function in their correct order.'};
inputs_.values  = {evaluatedbranch stringbranch anyfilebranch directorybranch };
inputs_.num     = [0 Inf];
inputs_.forcestruct = true;
% ---------------------------------------------------------------------
% help Description:
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
outputs         = cfg_branch;
outputs.tag     = 'outputs';
outputs.name    = 'Output file';
outputs.val     = {help directory string };
outputs.help    = {'Assemble the outputs to the called function in their correct order.'};
% ---------------------------------------------------------------------
% outputs_ Outputs
% ---------------------------------------------------------------------
outputs_         = cfg_repeat;
outputs_.tag     = 'outputs_';
outputs_.name    = 'Outputs';
outputs_.help    = {'Assemble the outputs to the called function in their correct order.'};
outputs_.values  = {outputs };
outputs_.num     = [0 Inf];
outputs_.forcestruct = true;
% ---------------------------------------------------------------------
% cmd Command to be called
% ---------------------------------------------------------------------
cmd         = cfg_entry;
cmd.tag     = 'cmd';
cmd.name    = 'Command to be called';
%%
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
%%
cmd.strtype = 's';
cmd.num     = [1  Inf];
% ---------------------------------------------------------------------
% dockerimg docker image
% ---------------------------------------------------------------------
dockerimg         = cfg_entry;
dockerimg.tag     = 'dockerimg';
dockerimg.name    = 'docker image';
dockerimg.def     = @(defval)'bids/mrtrix3_connectome';
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
% usedocker_ Use Docker
% ---------------------------------------------------------------------
usedocker_         = cfg_choice;
usedocker_.tag     = 'usedocker_';
usedocker_.name    = 'Use Docker';
usedocker_.help    = {
                      'Run command on a docker image?'
                      'Docker needs to be installed and running.'
                      }';
usedocker_.values  = {dockerimg nodocker };
% ---------------------------------------------------------------------
% dwi2mask dwi2mask
% ---------------------------------------------------------------------
dwi2mask         = cfg_cfg_call_system;
dwi2mask.tag     = 'dwi2mask';
dwi2mask.name    = 'dwi2mask';
dwi2mask.val     = {inputs_ outputs_ cmd usedocker_ };
dwi2mask.prog = @(job)cfg_run_call_system('run',job);
dwi2mask.vout = @(job)cfg_run_call_system('vout',job);
% ---------------------------------------------------------------------
% help Description:
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
% evaluated value
% ---------------------------------------------------------------------
evaluated         = cfg_entry;
evaluated.tag     = 'evaluated';
evaluated.name    = 'value';
evaluated.strtype = 'e';
evaluated.num     = [];
% ---------------------------------------------------------------------
% evaluatedbranch Evaluated Input
% ---------------------------------------------------------------------
evaluatedbranch         = cfg_branch;
evaluatedbranch.tag     = 'evaluatedbranch';
evaluatedbranch.name    = 'Evaluated Input';
evaluatedbranch.val     = {help evaluated };
evaluatedbranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% help Description:
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
% help Description:
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
anyfilebranch.name    = 'anyfile Input';
anyfilebranch.val     = {help anyfile };
anyfilebranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% help Description:
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
directorybranch.name    = 'directory Input';
directorybranch.val     = {help directory };
directorybranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% inputs_ Inputs
% ---------------------------------------------------------------------
inputs_         = cfg_repeat;
inputs_.tag     = 'inputs_';
inputs_.name    = 'Inputs';
inputs_.help    = {'Assemble the inputs to the called function in their correct order.'};
inputs_.values  = {evaluatedbranch stringbranch anyfilebranch directorybranch };
inputs_.num     = [0 Inf];
inputs_.forcestruct = true;
% ---------------------------------------------------------------------
% help Description:
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
outputs         = cfg_branch;
outputs.tag     = 'outputs';
outputs.name    = 'Output file';
outputs.val     = {help directory string };
outputs.help    = {'Assemble the outputs to the called function in their correct order.'};
% ---------------------------------------------------------------------
% outputs_ Outputs
% ---------------------------------------------------------------------
outputs_         = cfg_repeat;
outputs_.tag     = 'outputs_';
outputs_.name    = 'Outputs';
outputs_.help    = {'Assemble the outputs to the called function in their correct order.'};
outputs_.values  = {outputs };
outputs_.num     = [0 Inf];
outputs_.forcestruct = true;
% ---------------------------------------------------------------------
% cmd Command to be called
% ---------------------------------------------------------------------
cmd         = cfg_entry;
cmd.tag     = 'cmd';
cmd.name    = 'Command to be called';
%%
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
%%
cmd.strtype = 's';
cmd.num     = [1  Inf];
% ---------------------------------------------------------------------
% dockerimg docker image
% ---------------------------------------------------------------------
dockerimg         = cfg_entry;
dockerimg.tag     = 'dockerimg';
dockerimg.name    = 'docker image';
dockerimg.def     = @(defval)'bids/mrtrix3_connectome';
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
% usedocker_ Use Docker
% ---------------------------------------------------------------------
usedocker_         = cfg_choice;
usedocker_.tag     = 'usedocker_';
usedocker_.name    = 'Use Docker';
usedocker_.help    = {
                      'Run command on a docker image?'
                      'Docker needs to be installed and running.'
                      }';
usedocker_.values  = {dockerimg nodocker };
% ---------------------------------------------------------------------
% dwi2tensor dwi2tensor
% ---------------------------------------------------------------------
dwi2tensor         = cfg_cfg_call_system;
dwi2tensor.tag     = 'dwi2tensor';
dwi2tensor.name    = 'dwi2tensor';
dwi2tensor.val     = {inputs_ outputs_ cmd usedocker_ };
dwi2tensor.prog = @(job)cfg_run_call_system('run',job);
dwi2tensor.vout = @(job)cfg_run_call_system('vout',job);
% ---------------------------------------------------------------------
% help Description:
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
% evaluated value
% ---------------------------------------------------------------------
evaluated         = cfg_entry;
evaluated.tag     = 'evaluated';
evaluated.name    = 'value';
evaluated.strtype = 'e';
evaluated.num     = [];
% ---------------------------------------------------------------------
% evaluatedbranch Evaluated Input
% ---------------------------------------------------------------------
evaluatedbranch         = cfg_branch;
evaluatedbranch.tag     = 'evaluatedbranch';
evaluatedbranch.name    = 'Evaluated Input';
evaluatedbranch.val     = {help evaluated };
evaluatedbranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% help Description:
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
% help Description:
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
anyfilebranch.name    = 'anyfile Input';
anyfilebranch.val     = {help anyfile };
anyfilebranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% help Description:
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
directorybranch.name    = 'directory Input';
directorybranch.val     = {help directory };
directorybranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% inputs_ Inputs
% ---------------------------------------------------------------------
inputs_         = cfg_repeat;
inputs_.tag     = 'inputs_';
inputs_.name    = 'Inputs';
inputs_.help    = {'Assemble the inputs to the called function in their correct order.'};
inputs_.values  = {evaluatedbranch stringbranch anyfilebranch directorybranch };
inputs_.num     = [0 Inf];
inputs_.forcestruct = true;
% ---------------------------------------------------------------------
% help Description:
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
outputs         = cfg_branch;
outputs.tag     = 'outputs';
outputs.name    = 'Output file';
outputs.val     = {help directory string };
outputs.help    = {'Assemble the outputs to the called function in their correct order.'};
% ---------------------------------------------------------------------
% outputs_ Outputs
% ---------------------------------------------------------------------
outputs_         = cfg_repeat;
outputs_.tag     = 'outputs_';
outputs_.name    = 'Outputs';
outputs_.help    = {'Assemble the outputs to the called function in their correct order.'};
outputs_.values  = {outputs };
outputs_.num     = [0 Inf];
outputs_.forcestruct = true;
% ---------------------------------------------------------------------
% cmd Command to be called
% ---------------------------------------------------------------------
cmd         = cfg_entry;
cmd.tag     = 'cmd';
cmd.name    = 'Command to be called';
%%
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
%%
cmd.strtype = 's';
cmd.num     = [1  Inf];
% ---------------------------------------------------------------------
% dockerimg docker image
% ---------------------------------------------------------------------
dockerimg         = cfg_entry;
dockerimg.tag     = 'dockerimg';
dockerimg.name    = 'docker image';
dockerimg.def     = @(defval)'bids/mrtrix3_connectome';
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
% usedocker_ Use Docker
% ---------------------------------------------------------------------
usedocker_         = cfg_choice;
usedocker_.tag     = 'usedocker_';
usedocker_.name    = 'Use Docker';
usedocker_.help    = {
                      'Run command on a docker image?'
                      'Docker needs to be installed and running.'
                      }';
usedocker_.values  = {dockerimg nodocker };
% ---------------------------------------------------------------------
% tensor2metric tensor2metric
% ---------------------------------------------------------------------
tensor2metric         = cfg_cfg_call_system;
tensor2metric.tag     = 'tensor2metric';
tensor2metric.name    = 'tensor2metric';
tensor2metric.val     = {inputs_ outputs_ cmd usedocker_ };
tensor2metric.prog = @(job)cfg_run_call_system('run',job);
tensor2metric.vout = @(job)cfg_run_call_system('vout',job);
% ---------------------------------------------------------------------
% mrtrix3 MRtrix3
% ---------------------------------------------------------------------
mrtrix3         = cfg_choice;
mrtrix3.tag     = 'mrtrix3';
mrtrix3.name    = 'MRtrix3';
mrtrix3.values  = {dwidenoise dwi2mask dwi2tensor tensor2metric };
% ---------------------------------------------------------------------
% help Description:
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
% evaluated value
% ---------------------------------------------------------------------
evaluated         = cfg_entry;
evaluated.tag     = 'evaluated';
evaluated.name    = 'value';
evaluated.strtype = 'e';
evaluated.num     = [];
% ---------------------------------------------------------------------
% evaluatedbranch Evaluated Input
% ---------------------------------------------------------------------
evaluatedbranch         = cfg_branch;
evaluatedbranch.tag     = 'evaluatedbranch';
evaluatedbranch.name    = 'Evaluated Input';
evaluatedbranch.val     = {help evaluated };
evaluatedbranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% help Description:
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
% help Description:
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
anyfilebranch.name    = 'anyfile Input';
anyfilebranch.val     = {help anyfile };
anyfilebranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% help Description:
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
directorybranch.name    = 'directory Input';
directorybranch.val     = {help directory };
directorybranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% inputs_ Inputs
% ---------------------------------------------------------------------
inputs_         = cfg_repeat;
inputs_.tag     = 'inputs_';
inputs_.name    = 'Inputs';
inputs_.help    = {'Assemble the inputs to the called function in their correct order.'};
inputs_.values  = {evaluatedbranch stringbranch anyfilebranch directorybranch };
inputs_.num     = [0 Inf];
inputs_.forcestruct = true;
% ---------------------------------------------------------------------
% help Description:
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
outputs         = cfg_branch;
outputs.tag     = 'outputs';
outputs.name    = 'Output file';
outputs.val     = {help directory string };
outputs.help    = {'Assemble the outputs to the called function in their correct order.'};
% ---------------------------------------------------------------------
% outputs_ Outputs
% ---------------------------------------------------------------------
outputs_         = cfg_repeat;
outputs_.tag     = 'outputs_';
outputs_.name    = 'Outputs';
outputs_.help    = {'Assemble the outputs to the called function in their correct order.'};
outputs_.values  = {outputs };
outputs_.num     = [0 Inf];
outputs_.forcestruct = true;
% ---------------------------------------------------------------------
% cmd Command to be called
% ---------------------------------------------------------------------
cmd         = cfg_entry;
cmd.tag     = 'cmd';
cmd.name    = 'Command to be called';
%%
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
%%
cmd.strtype = 's';
cmd.num     = [1  Inf];
% ---------------------------------------------------------------------
% dockerimg docker image
% ---------------------------------------------------------------------
dockerimg         = cfg_entry;
dockerimg.tag     = 'dockerimg';
dockerimg.name    = 'docker image';
dockerimg.def     = @(defval)'bids/mrtrix3_connectome';
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
% usedocker_ Use Docker
% ---------------------------------------------------------------------
usedocker_         = cfg_choice;
usedocker_.tag     = 'usedocker_';
usedocker_.name    = 'Use Docker';
usedocker_.help    = {
                      'Run command on a docker image?'
                      'Docker needs to be installed and running.'
                      }';
usedocker_.values  = {dockerimg nodocker };
% ---------------------------------------------------------------------
% eddy_correct eddy_correct
% ---------------------------------------------------------------------
eddy_correct         = cfg_cfg_call_system;
eddy_correct.tag     = 'eddy_correct';
eddy_correct.name    = 'eddy_correct';
eddy_correct.val     = {inputs_ outputs_ cmd usedocker_ };
eddy_correct.prog = @(job)cfg_run_call_system('run',job);
eddy_correct.vout = @(job)cfg_run_call_system('vout',job);
% ---------------------------------------------------------------------
% fsl FSL
% ---------------------------------------------------------------------
fsl         = cfg_choice;
fsl.tag     = 'fsl';
fsl.name    = 'FSL';
fsl.values  = {eddy_correct };
% ---------------------------------------------------------------------
% help Description:
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
% evaluated value
% ---------------------------------------------------------------------
evaluated         = cfg_entry;
evaluated.tag     = 'evaluated';
evaluated.name    = 'value';
evaluated.strtype = 'e';
evaluated.num     = [];
% ---------------------------------------------------------------------
% evaluatedbranch Evaluated Input
% ---------------------------------------------------------------------
evaluatedbranch         = cfg_branch;
evaluatedbranch.tag     = 'evaluatedbranch';
evaluatedbranch.name    = 'Evaluated Input';
evaluatedbranch.val     = {help evaluated };
evaluatedbranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% help Description:
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
% help Description:
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
anyfilebranch.name    = 'anyfile Input';
anyfilebranch.val     = {help anyfile };
anyfilebranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% help Description:
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
directorybranch.name    = 'directory Input';
directorybranch.val     = {help directory };
directorybranch.help    = {'Detail this input'};
% ---------------------------------------------------------------------
% inputs_ Inputs
% ---------------------------------------------------------------------
inputs_         = cfg_repeat;
inputs_.tag     = 'inputs_';
inputs_.name    = 'Inputs';
inputs_.help    = {'Assemble the inputs to the called function in their correct order.'};
inputs_.values  = {evaluatedbranch stringbranch anyfilebranch directorybranch };
inputs_.num     = [0 Inf];
inputs_.forcestruct = true;
% ---------------------------------------------------------------------
% help Description:
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
outputs         = cfg_branch;
outputs.tag     = 'outputs';
outputs.name    = 'Output file';
outputs.val     = {help directory string };
outputs.help    = {'Assemble the outputs to the called function in their correct order.'};
% ---------------------------------------------------------------------
% outputs_ Outputs
% ---------------------------------------------------------------------
outputs_         = cfg_repeat;
outputs_.tag     = 'outputs_';
outputs_.name    = 'Outputs';
outputs_.help    = {'Assemble the outputs to the called function in their correct order.'};
outputs_.values  = {outputs };
outputs_.num     = [0 Inf];
outputs_.forcestruct = true;
% ---------------------------------------------------------------------
% cmd Command to be called
% ---------------------------------------------------------------------
cmd         = cfg_entry;
cmd.tag     = 'cmd';
cmd.name    = 'Command to be called';
%%
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
%%
cmd.strtype = 's';
cmd.num     = [1  Inf];
% ---------------------------------------------------------------------
% dockerimg docker image
% ---------------------------------------------------------------------
dockerimg         = cfg_entry;
dockerimg.tag     = 'dockerimg';
dockerimg.name    = 'docker image';
dockerimg.def     = @(defval)'bids/mrtrix3_connectome';
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
% usedocker_ Use Docker
% ---------------------------------------------------------------------
usedocker_         = cfg_choice;
usedocker_.tag     = 'usedocker_';
usedocker_.name    = 'Use Docker';
usedocker_.help    = {
                      'Run command on a docker image?'
                      'Docker needs to be installed and running.'
                      }';
usedocker_.values  = {dockerimg nodocker };
% ---------------------------------------------------------------------
% rigid Rigid
% ---------------------------------------------------------------------
rigid         = cfg_cfg_call_system;
rigid.tag     = 'rigid';
rigid.name    = 'Rigid';
rigid.val     = {inputs_ outputs_ cmd usedocker_ };
rigid.prog = @(job)cfg_run_call_system('run',job);
rigid.vout = @(job)cfg_run_call_system('vout',job);
% ---------------------------------------------------------------------
% antsregistration antsRegistration
% ---------------------------------------------------------------------
antsregistration         = cfg_choice;
antsregistration.tag     = 'antsregistration';
antsregistration.name    = 'antsRegistration';
antsregistration.values  = {rigid };
% ---------------------------------------------------------------------
% ants ANTS
% ---------------------------------------------------------------------
ants         = cfg_choice;
ants.tag     = 'ants';
ants.name    = 'ANTS';
ants.values  = {antsregistration };
% ---------------------------------------------------------------------
% system System
% ---------------------------------------------------------------------
cfg         = cfg_choice;
cfg.tag     = 'system';
cfg.name    = 'System';
cfg.values  = {mrtrix3 fsl ants };
