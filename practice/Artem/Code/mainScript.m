numPoints = 20;
points = arrayfun(@(i) Point(rand()*10, rand()*10), 1:numPoints);

xs = arrayfun(@(p) p.x, points);
ys = arrayfun(@(p) p.y, points);
figure;
plot(xs, ys, 'bo', 'MarkerFaceColor', 'b');
xlabel('X');
ylabel('Y');
title('Распределение точек');
grid on;

xs = arrayfun(@(p) p.x, points);
ys = arrayfun(@(p) p.y, points);
centroid = Point(mean(xs), mean(ys));
hold on;
plot(centroid.x, centroid.y, 'rx', 'MarkerSize', 12, 'LineWidth', 2);
legend('Points', 'Centroid', 'Location', 'Best');

maxDist = 0;
pairIdx = [1, 2];
for i = 1:numPoints-1
    for j = i+1:numPoints
        d = distance(points(i), points(j));
        if d > maxDist
            maxDist = d;
            pairIdx = [i, j];
        end
    end
end
fprintf('Самые удаленные точки #%d  (%.2f, %.2f) и #%d (%.2f, %.2f). Дистанция - %.2f\n', ...
    pairIdx(1), points(pairIdx(1)).x, points(pairIdx(1)).y, ...
    pairIdx(2), points(pairIdx(2)).x, points(pairIdx(2)).y, maxDist);

minDist = inf;
closestIdx = 1;
for i = 1:numPoints
    d = distance(points(i), centroid);
    if d < minDist
        minDist = d;
        closestIdx = i;
    end
end
fprintf('Точка, ближайшую к центроиду - #%d (%.2f, %.2f). Дистанция - %.2f\n', ...
    closestIdx, points(closestIdx).x, points(closestIdx).y, minDist);
