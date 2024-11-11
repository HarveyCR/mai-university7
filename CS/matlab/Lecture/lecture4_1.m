hFig1 = figure;
get(hFig1)

set(hFig1, 'Color', [1 0 0])
set(hFig1, 'Color', 'k')

set(hFig1, 'NumberTitle', 'off')
set(hFig1, 'Name', 'Example')

get(0, 'ScreenSize')

hFig = figure(...
    'NumberTitle', 'off',...
    'Name', 'Example',...
    'Position', [0 0 0 0], ...
    'Color', [0.8 0.8 0.8]);

hAxes = axes;
get(hAxes)

set(hAxes, 'XGrid', 'on', 'YGrid', 'on')
xlabel('X')
ylabel('Y')
yLbl = ylabel('Y');
set(yLbl, 'FontSize', 20)
set(xlabel('X'), 'FontSize', 20)
hTitle = title('TITLE');
set(hTitle, 'FontSize', 20)
set(hTitle, 'FontSize', 50, 'color', 'red')

x = -2*pi:pi/16:2*pi;
y_cos = cos(x);
y_sin = sin(x);
hLineSize = line(...
    'XData', x,...
    'YData', y_sin,...
    'LineWidth', 3,... ...
    'Color', 'red');

set(hAxes, 'XLim', [-2*pi, 2*pi], 'Ylim', [-1/2, 1/2])
axis([-2*pi 2*pi -1 1])

hLineSize.set('LineWidth', 3)

hLineCosine = line(x, y_cos, 'LineWidth', 3, 'Color', 'g');
set(hLineCosine, 'LineStyle', ':');

set(hLineSize, 'LineStyle', 'none')
set(hLineSize, 'Marker', 'o')

hTxt = text(-3,0.5,'sine(x)');
set(hTxt, 'FontAngle', 'Italic')

set(hTxt, 'FontName', 'Times')
A = -5; B = -4; C = -8;
x = -2:1/2:2;
y = (-C - A*x)/B;
plot(x, y, ':ro')

hLine = findobj('Type', 'Line');

% New Title 
b = 0.5;
x = -2:0.5:2;
alpha = [pi /8; pi/4; 3*pi/8];
k = tan(alpha);

set()