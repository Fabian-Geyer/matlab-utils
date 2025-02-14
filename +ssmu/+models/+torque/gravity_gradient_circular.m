function [tau_GG_B] = gravity_gradient_circular(z_T_B, J, omega0)
% Returns gravity gradient torque based on [Wertz78] as a (symbolic)
% expression
arguments
    z_T_B (3,1) % 3x1 unit vector z of tangential frame expressed in Body 
    % frame (can be symexpr)
    J (3,3) % Inertia matrix expressed in B frame
    omega0 (1,1) % scalar orbital rate for circular orbit omega^2=mu/(r^3)
end

tau_GG_B = 3*omega0*(ssmu.cpm(z_T_B)*J*z_T_B);

end