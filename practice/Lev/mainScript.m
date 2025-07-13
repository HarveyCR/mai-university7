% mainScript.m
% Main script to demonstrate Point class and functions
% Generate 20 random points within [0,10] x [0,10]
numPoints = 20;
points = arrayfun(@(i) Point(rand()*10, rand()*10), 1:numPoints);

% Plot points and centroid
plotPoints(points);
centroid = findCentroid(points);
hold on;
plot(centroid.x, centroid.y, 'rx', 'MarkerSize', 12, 'LineWidth', 2);
legend('Points', 'Centroid', 'Location', 'Best');

% Find two most distant points
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
fprintf('Most distant points: #%d at (%.2f, %.2f) and #%d at (%.2f, %.2f) with distance %.2f\n', ...
    pairIdx(1), points(pairIdx(1)).x, points(pairIdx(1)).y, ...
    pairIdx(2), points(pairIdx(2)).x, points(pairIdx(2)).y, maxDist);

% Find the point closest to the centroid
minDist = inf;
closestIdx = 1;
for i = 1:numPoints
    d = distance(points(i), centroid);
    if d < minDist
        minDist = d;
        closestIdx = i;
    end
end
fprintf('Point closest to centroid: #%d at (%.2f, %.2f) with distance %.2f\n', ...
    closestIdx, points(closestIdx).x, points(closestIdx).y, minDist);
