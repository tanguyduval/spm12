% FT_POSTAMBLE_DEBUG is a helper script for debugging problems with FieldTrip
% functions. It is executed at normal termination of the calling function and
% disables the "onCleanup" function.
%
% Use as
%   ft_preamble debug
%   .... regular code goes here ...
%   ft_postamble debug
%
% See also FT_PREAMBLE_DEBUG DEBUGCLEANUP

% these variables are shared by the three debug handlers
global Ce9dei2ZOo_debug Ce9dei2ZOo_funname Ce9dei2ZOo_argin

if ~isfield(cfg, 'debug')
  % do not provide extra debugging facilities
  return
end

switch cfg.debug
  case {'displayonsuccess' 'saveonsuccess'}
    % do not clean up the global variables yet
    % these are still needed by the cleanup function
    
  otherwise
    % this results in the cleanup function doing nothing
    Ce9dei2ZOo_debug   = 'no';
    Ce9dei2ZOo_funname = [];
    Ce9dei2ZOo_argin   = [];
end
