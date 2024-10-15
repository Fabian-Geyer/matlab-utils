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