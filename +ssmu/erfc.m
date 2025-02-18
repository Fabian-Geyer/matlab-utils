function [erfc_val] = erfc(x)
% Computes the complementary error function (erfc) for numerical, symbolic,
% or CasADi inputs.
% Supports scalars and vectors/matrices.
%
% Inputs:
%   x: Scalar, vector, or matrix (numerical, symbolic, or CasADi SX/MX)
% Outputs:
%   erfc_val: Same size as x, with computed erfc values
%
% Example:
%   x = sym('x', [3,1]);
%   erfc_val = ssmu.erfc(x);
%
%   x_cas = casadi.SX.sym('x', 3, 1);
%   erfc_casadi = ssmu.erfc(x_cas);

arguments
    x {ssmu.input_validation.mustBeNumericOrSymbolicOrCasadi}
end

% Define erfc using built-in functions where available
if isa(x, 'double') || isa(x, 'sym')
    erfc_val = erfc(x); % Use Matlab implementation
elseif isa(x, 'casadi.SX') || isa(x, 'casadi.MX')
    erfc_val = 1 - erf(x); % CasADi supports element-wise operations
else
    error('Unsupported input type.');
end

end