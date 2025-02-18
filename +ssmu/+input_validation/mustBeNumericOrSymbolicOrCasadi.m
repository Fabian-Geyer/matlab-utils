function mustBeNumericOrSymbolicOrCasadi(x)
% Custom validation function to allow numerical, symbolic, or CasADi types
if ~(isa(x, 'double') || isa(x, 'sym') || isa(x, 'casadi.SX') || isa(x, 'casadi.MX'))
    error('Input must be numeric, symbolic, or CasADi (SX/MX).');
end