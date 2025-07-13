function centroid = findCentroid(points)
    xs = arrayfun(@(p) p.x, points);
    ys = arrayfun(@(p) p.y, points);
    centroid = Point(mean(xs), mean(ys));
end