function [q_BI_dot, omega_BI_B_dot] = rigid_body_BI(q_BI, omega_BI_B, ...
    J, tau_B)
% returns the basic dynamics of a rigid body with respect to the inertial
% frame.
% Inputs:
%   - q_BI: 4x1 attitude quaternion describing rotation of B frame w.r.t.
%   inertial frame I. q = (q0,q1,q2,q3)^T with scalar part q0
%   - omega_BI_B: 3x1 angular rate vector of B frame w.r.t. I frame
%   expressed in B
%   - J: 3x3 (potentially symbolic) inertia matrix
%   - tau_B: 3x1 (symbolic) sum of torques acting on the satellite

arguments
    q_BI (4,1)
    omega_BI_B (3,1) 
    J (3,3)
    tau_B (3,1)
end

om = omega_BI_B;

q_BI_dot = 1/2*[0, -om'; om, -ssmu.cpm(om)]*q_BI; % quaternion kinematics
omega_BI_B_dot = inv(J)*( -ssmu.cpm(om)*J*om + tau_B ); % dynamics

end