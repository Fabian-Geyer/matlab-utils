function [T2] = T2(alpha)
% Return (symbolic) T1(alpha) for a rotation about the third rotation axis

arguments
    alpha (1,1) {ssmu.input_validation.mustBeNumericOrSymbolicOrCasadi}
end

T2 = [cos(alpha), 0, -sin(alpha);
      0,          1,          0;
      sin(alpha), 0,  cos(alpha)];

end