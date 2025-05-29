function plotConeCurveData(filename)
    fid = fopen(filename, 'r');
    if fid == -1
        error('Cannot open file: %s', filename);
    end
    dataCell = textscan(fid, '%f%f%f%f', 'CommentStyle', '%');
    fclose(fid);
    data = [dataCell{:}];

    if size(data,2) ~= 4
        error('Data file must contain four columns: t, x, y, z.');
    end

    x = data(:,2);
    y = data(:,3);
    z = data(:,4);

    figure;
    plot3(x, y, z, 'LineWidth', 2);
    grid on;
    axis equal;
    xlabel('x');
    ylabel('y');
    zlabel('z');
    title('Spiral Curve on Cone Surface');
end