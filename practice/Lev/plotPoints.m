function plotPoints(points)
    xs = arrayfun(@(p) p.x, points);
    ys = arrayfun(@(p) p.y, points);
    figure;
    plot(xs, ys, 'bo', 'MarkerFaceColor', 'b');
    xlabel('X');
    ylabel('Y');
    title('Распределение точек');
    grid on;
end