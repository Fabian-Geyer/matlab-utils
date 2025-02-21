function [T3] = T3(alpha)
% Return (symbolic) T1(alpha) for a rotation about the third rotation axis

arguments
    alpha (1,1) {ssmu.input_validation.mustBeNumericOrSymbolicOrCasadi}
end

T3 = [cos(alpha), sin(alpha), 0;
     -sin(alpha), cos(alpha), 0;
     0,           0,          1];

end