function [cpm] = cpm(v)
% Calculate cross product matrix from arbitrary 3x1 vector input. Allows
% for symbolic or numerical inputs.
% Inputs:
%   v: 3x1 numerical/symbolic vector
% Outputs:
%   cpm: 3x3 numerical/symbolic matrix
%
% Example:
% v = sym('v', [3 1])
% cpm = cpm(v)

arguments
    v (3,1) % vector input symbolic or numerical
end

cpm = [0, -v(3), v(2); ...
       v(3), 0, -v(1); ...
       -v(2), v(1), 0];

end