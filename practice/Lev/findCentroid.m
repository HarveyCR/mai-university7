% findCentroid.m
function centroid = findCentroid(points)
    % findCentroid - Compute the centroid (mean position) of Points
    %   centroid = findCentroid(points)
    xs = arrayfun(@(p) p.x, points);
    ys = arrayfun(@(p) p.y, points);
    centroid = Point(mean(xs), mean(ys));
end