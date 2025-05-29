function generateConeCurveData(a, b, c, h, numPoints, filename)
    % Parameter t for spiral (0 to 4*pi)
    t = linspace(0, 4*pi, numPoints)';
    % Linear growth of y from 0 to h
    y = (h / (4*pi)) * t;
    % Corresponding x and z on the cone surface
    x = (a / b) * y .* cos(t);
    z = (c / b) * y .* sin(t);

    % Open file for writing
    fid = fopen(filename, 'w');
    if fid == -1
        error('Cannot open file: %s', filename);
    end

    % Write header
    fprintf(fid, '%% Cone spiral data: a=%.3f, b=%.3f, c=%.3f, h=%.3f\n', a, b, c, h);
    fprintf(fid, '%% Columns:    t(radians)      x           y           z\n');

    % Write formatted data
    for i = 1:numPoints
        fprintf(fid, '%%10.4f %12.6f %12.6f %12.6f\n', t(i), x(i), y(i), z(i));
    end

    fclose(fid);
end


