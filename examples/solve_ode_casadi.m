import casadi.*

% Symbolic variable (state)
x = SX.sym('x', 6);

% Cross product matrix as CasADi function
v = SX.sym('v', 3);
cpm = Function('cpm', {v}, { ...
    [0, -v(3), v(2); ...
    v(3), 0, -v(1); ...
    -v(2), v(1), 0] ...
    });

% Dynamics for satellite rotation (x = [s, omega])
s = x(1:3);                 % Direction
om = x(4:6);                % Body rates
u = SX.sym('u', 3);         % Torque input
s_ref = [1; 0; 0];          % Reference direction (not used in dynamics)
J = diag([1; 2; 2]);        % Inertia matrix

% Dynamics equations
s_dot = cpm(s) * om;                           % Direction rate of change
omega_dot = inv(J) * (-cpm(om) * J * om - u);  % Angular acceleration

% Open-loop dynamics as function
xdot = Function('xdot', {x, u}, {[s_dot; omega_dot]}, {'x', 'u'}, {'xdot'});

% Initial conditions
w0 = [0.5; 0.5; 0]; w0 = w0 / norm(w0);  % Normalized initial direction
omega0 = [0.1; 0; 0.1];                  % Initial angular velocity
x0 = [w0; omega0];                       % Initial state


% Control Law
uc = J*1.*eye(3)*om;

% Closed-loop dynamics (u = 0 for simulation)
f = Function('f', {x}, {xdot(x, uc)}, {'x'}, {'xdot'});

% Set up the integrator
T = 10;  % Total simulation time
N = 100; % Number of steps
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
X = zeros(6, N+1);
X(:, 1) = x0;  % Set initial state

% Perform the integration
for k = 1:N
    % Integrate one step
    res = integrator('x0', X(:, k));
    X(:, k+1) = full(res.xf);  % Update state
end

% Plot the results
t = linspace(0, T, N+1);
fig = hfigure('Satellite Simulation using CasADi');
subplot(2, 1, 1);
plot(t, X(1:3, :));
xlabel('Time');
ylabel('Direction (s)');
legend('s_1', 's_2', 's_3');
title('Satellite Direction');

subplot(2, 1, 2);
plot(t, X(4:6, :));
xlabel('Time');
ylabel('Angular Velocity (\omega)');
legend('\omega_1', '\omega_2', '\omega_3');
title('Satellite Angular Velocity');