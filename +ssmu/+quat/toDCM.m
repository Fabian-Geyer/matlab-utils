function [DCM] = toDCM(attitude_quat)
% Convert 4x1 attitude quaternion (q0 q1 q2 q3) to DCM where q0 denotes the 
% scalar part
% Input: 
%   Quaternion (4x1): numerical or symbolic
% Output:
%   Direction Cosine Matrix as expression of Quaternion (3x3): numerical or
%   symbolic

arguments
    attitude_quat (4,1)
end


% Extract quaternion components
q0 = attitude_quat(1);
q1 = attitude_quat(2);
q2 = attitude_quat(3);
q3 = attitude_quat(4);

% Compute the Direction Cosine Matrix (DCM)
DCM = [ 2*(q0^2 + q1^2) - 1,  2*(q1*q2 + q0*q3),  2*(q1*q3 - q0*q2);
        2*(q1*q2 - q0*q3),  2*(q0^2 + q2^2) - 1,  2*(q2*q3 + q0*q1);
        2*(q1*q3 + q0*q2),  2*(q2*q3 - q0*q1),  2*(q0^2 + q3^2) - 1 ];
% DCM = [ q0^2 + q1^2 - q2^2 - q3^2,  2*(q1*q2 + q0*q3),  2*(q1*q3 - q0*q2);
%         2*(q1*q2 - q0*q3),  q0^2 - q1^2 + q2^2 - q3^2,  2*(q2*q3 + q0*q1);
%         2*(q1*q3 + q0*q2),  2*(q2*q3 - q0*q1),  q0^2 - q1^2 - q2^2 + q3^2 ];
end