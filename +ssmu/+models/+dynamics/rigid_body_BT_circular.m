function [q_BT_dot, omega_BT_B_dot] = rigid_body_BT_circular(q_BT, ...
    omega_BT_B, J, tau_B, omega0)
% returns the basic dynamics of a rigid body with respect to the tangential
% frame T assuming a circular orbit
% Inputs:
%   - q_BT: 4x1 attitude quaternion describing rotation of B frame w.r.t.
%   tangential frame T. q_BT = (q0,q1,q2,q3)^T with scalar part q0
%   - omega_BT_B: 3x1 angular rate vector of B frame w.r.t. T frame
%   expressed in B
%   - J: 3x3 (potentially symbolic) inertia matrix
%   - tau_B: 3x1 (symbolic) sum of torques acting on the satellite
%   - omega0: scalar orbital rate for circular orbit omega^2=mu/(r^3)

arguments
    q_BT (4,1)
    omega_BT_B (3,1) 
    J (3,3)
    tau_B (3,1)
    omega0 (1,1)
end

om = omega_BT_B;

T_BT = ssmu.quat.toDCM(q_BT);
y_T_B = T_BT(:,2); % unit vector of y_T expressed in B frame 

q_BT_dot = 1/2*[0, -om'; om, -ssmu.cpm(om)]*q_BT; % quaternion kinematics
omega_BT_B_dot = inv(J)* ( ...
    -ssmu.cpm(om - omega0*y_T_B)*J*(om - omega0*y_T_B)...
    -omega0*J*ssmu.cpm(om)*y_T_B + tau_B...
    );

end