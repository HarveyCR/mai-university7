% plotPoints.m
function plotPoints(points)
    % plotPoints - Plot an array of Point objects on a 2D graph
    %   plotPoints(points)
    xs = arrayfun(@(p) p.x, points);
    ys = arrayfun(@(p) p.y, points);
    figure;
    plot(xs, ys, 'bo', 'MarkerFaceColor', 'b');
    xlabel('X');
    ylabel('Y');
    title('Points Distribution');
    grid on;
end