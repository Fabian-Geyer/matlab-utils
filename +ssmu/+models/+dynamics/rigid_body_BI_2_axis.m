function [s_dot,omega_BI_B_dot] = rigid_body_BI_2_axis(s_BI,...
    omega_BI_B, J, tau_B)
% returns the basic dynamics of a rigid body with respect to the inertial
% frame for 2-axis acquisition.
% Inputs:
%   - s_BI: 3x1 attitude direction vector expressed in body frame w.r.t.
%   inertial frame I. s_BI = (s1,s2,s3)^T
%   - omega_BI_B: 3x1 angular rate vector of B frame w.r.t. I frame
%   expressed in B
%   - J: 3x3 (potentially symbolic) inertia matrix
%   - tau_B: 3x1 (symbolic) sum of torques acting on the satellite

arguments
    s_BI (3,1)
    omega_BI_B (3,1)
    J (3,3)
    tau_B (3,1)
end

om = omega_BI_B;

s_dot = ssmu.cpm(s_BI)*omega_BI_B; % Kinematics
omega_BI_B_dot = inv(J)*( -ssmu.cpm(om)*J*om + tau_B ); % dynamics

end

