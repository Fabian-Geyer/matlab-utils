function [t, y] = simulate(duration, x0, dynamics, options)
% DESCRIPTION: Checks dynamics function handle (assuming autonomous system)
% for number of inputs and outputs and propagates dynamics for a desired
% duration using matlabs ode45 function. Returns time vector and state
% values as (:,n) numerical matrix
arguments
    duration double
    x0 (:,1) {mustBeNumeric} % initial state vector (column vector)
    dynamics function_handle % function handle with one vector as input
    options.solver (1,1) string {mustBeMember(options.solver, ["ode45", "casadi_idas"])} = "ode45"
end

switch options.solver
    case "ode45"
        n = numel(x0);
    
        % symbolic variable
        x = sym("x", [n, 1], "real");
    
        % Define the ODE function for ode45
        % Wrap the dynamics function to accept (t, x) and split x into individual variables
        ode_fun = @(t, x) dynamics(x); % Adjust for the number of states
    
        % Solve the ODE
        tspan = [0, duration];
        [t, y] = ode45(ode_fun, tspan, x0);
    case "casadi_idas"
        x = casadi.SX.sym('x', numel(x0));

        f = casadi.Function('f', {x}, {dynamics(x)}, {'x'}, {'xdot'});

        % Set up the integrator
        T = duration;  % Total simulation time
        N = 500; % Number of steps
        h = T / N; % Time step

        % Define the ODE structure for the integrator
        ode = struct;
        ode.x = x;                  % State variables
        ode.ode = f(x);             % ODE function

        % Create the integrator
        integrator_opts = struct;
        integrator_opts.tf = h;     % Time step for integration
        integrator = casadi.integrator('integrator', 'idas', ode, integrator_opts);

        % Initialize the solution vector
        y = zeros(6, N+1);
        y(:, 1) = x0;  % Set initial state

        % Perform the integration
        for k = 1:N
            % Integrate one step
            res = integrator('x0', y(:, k));
            y(:, k+1) = full(res.xf);  % Update state
        end
        y = y';
        t = linspace(0,T,N+1);
end
end