function [out, found] = depname2src_output(cjval,name)
if isempty(cjval), out = {}; found = false; return; end
for iii = 1:length(cjval)
    if iscell(cjval)
        if ischar(cjval{iii}), out = {}; found = false; return; end;
        if any(strcmp(fieldnames(cjval{iii}),'name'))
        if strcmp(cjval{iii}.name,name)
            found = true;
            out = {'.','val','{}', {iii}};
            return
        else
            [out, found] = depname2src_output(cjval{iii}.val,name);
            if found
                out = {'.','val','{}',{iii},out{:}};
                return
            end
        end
        else
            found = false;
            out = {};
        end
        
    elseif isstruct(cjval)
       disp('not implemented') 
    end
end