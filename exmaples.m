%% Write vector data to .dat file
% sample data
x = linspace(-4,4,100);
y1 = sin(x);
y2 = cos(x);

% create .dat file
df = datafile('example');
df.writeHeader('x', 'y1', 'y2');
df.writeData(x, y1, y2);

df.close();

%% Hfigure
hfigure('Plot sin'); clf;
hold on;
plot(x, y1)
plot(x, y2)
hold off;

%% Write matrix data to .dat file
n = 20;
x = linspace(-1,1,n); y = x;
[X, Y] = meshgrid(x,y);
hfigure('example 3D plot')
Z = X.^2 + Y.^2;
surf(X,Y,Z)
axis equal;

df = datafile('matrix');
df.writeHeader('X','Y','Z');
df.writeMatrix(X,Y,Z)
% the parameters in the writematrix function are only needed for parametric
% plots (such as a helix).
% keep in mind: When using this data in pgfplots make sure to use the 3D
% plot with correct ordering and mesh/rows:
% [surf,mesh/ordering=y varies,mesh/rows=40] table[x=...] {datafile.dat};