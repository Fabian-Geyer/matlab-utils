function [t, y] = simulate(duration, x0, dynamics)
% DESCRIPTION: Checks dynamics function handle (assuming autonomous system)
% for number of inputs and outputs and propagates dynamics for a desired
% duration using matlabs ode45 function. Returns time vector and state
% values as (:,n) numerical matrix
arguments
    duration double
    x0 (:,1) {mustBeNumeric} % initial state vector (column vector)
    dynamics function_handle % function handle with one vector as input
end
    n = numel(x0);

    % symbolic variable
    x = sym("x", [n, 1], "real");

    % Define the ODE function for ode45
    % Wrap the dynamics function to accept (t, x) and split x into individual variables
    ode_fun = @(t, x) dynamics(x); % Adjust for the number of states

    % Solve the ODE
    tspan = [0, duration];
    [t, y] = ode45(ode_fun, tspan, x0);
end