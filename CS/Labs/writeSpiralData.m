function writeConeDataText(filename, a, b, c, h, nPoints)

    y = linspace(0, h, nPoints);
    x = (a * c / b) * y;
    z = zeros(size(y));

    fid = fopen(filename, 'w');
    if fid == -1
        error('Could not open file %s for writing.', filename);
    end

    % Header
    fprintf(fid, '%% Quadric Cone Meridian Data\n');
    fprintf(fid, '%% Equation: x^2/%g^2 - y^2/%g^2 + z^2/%g^2 = 0, height h = %g\n', a, b, c, h);
    fprintf(fid, '%% Columns: x | y | z\n');
    fprintf(fid, '%%----------------------------------\n');

    for i = 1:numel(y)
        fprintf(fid, '%10.5f %10.5f %10.5f\n', x(i), y(i), z(i));
    end
    fclose(fid);
end