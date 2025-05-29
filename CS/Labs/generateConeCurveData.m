function generateConeCurveData(a, b, c, h, numPoints, filename)
    t = linspace(0, 4*pi, numPoints)';
    y = (h / (4*pi)) * t;
    x = (a / b) * y .* cos(t);
    z = (c / b) * y .* sin(t);

    fid = fopen(filename, 'w');
    if fid == -1
        error('Cannot open file: %s', filename);
    end
    fprintf(fid, '%% Cone spiral data: a=%.3f, b=%.3f, c=%.3f, h=%.3f\n', a, b, c, h);
    fprintf(fid, '%%t(radians)      x           y           z\n');

    for i = 1:numPoints
        fprintf(fid, '%10.4f %12.6f %12.6f %12.6f\n', t(i), x(i), y(i), z(i));
    end

    fclose(fid);
end
