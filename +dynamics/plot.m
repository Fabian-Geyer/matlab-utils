function [fig_handle] = plot(t, y, labels, options)
% Inputs:
%   - y: k*n matrix where k is the number of time steps and n is the number of states
%   - labels: cell array with string labels for each state
%   - t: time vector corresponding to the rows of y

arguments
    t (:,1) double
    y (:,:) double
    labels cell
    options.figID char = 'dynamics plot'
end

% Check that the number of columns in y matches the number of labels
if size(y, 2) ~= numel(labels)
    error('The number of columns in y must match the number of labels.');
end

% Plot results
fig_handle = hfigure(options.figID);
plot(t, y, 'LineWidth', 1.5);
grid on;
xlabel('Time (s)', 'Interpreter','latex'); xlim([min(t), max(t)])
ylabel('State variables', 'Interpreter','latex');
title('System Dynamics', 'Interpreter','latex');
legend(labels, 'Location', 'best', 'Interpreter','latex');
end