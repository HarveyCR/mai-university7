function [] = circle (r, x0, y0)
    if (nargin < 1)
        error("Too less enterence data")
    end
    if (nargin < 3), y0 = 0; end
    if (nargin < 2), x0 = 0; endS
    
    t = 0:pi/64:2*pi;
    x = x0 + r*cos(t);
    y = y0 + r*sin(t);

    plot(x, y), axis equal, grid on, hold on
    xlabel('x'), ylabel('y'), title('çircle')
end