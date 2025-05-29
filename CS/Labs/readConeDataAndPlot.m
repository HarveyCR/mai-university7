% Function: plotConeCurveData
% Description:
%   Reads the curve data from a formatted text file and plots the 3D curve.
%
% Usage:
%   plotConeCurveData(filename)

function plotConeCurveData(filename)
    % Open file for reading
    fid = fopen(filename, 'r');
    if fid == -1
        error('Cannot open file: %s', filename);
    end

    % Skip header lines starting with '%'
    headerLines = 0;
    while true
        str = fgetl(fid);
        if isempty(str) || str(1) ~= '%'
            % Move file position back one line
            frewind(fid);
            for k = 1:headerLines
                fgetl(fid);
            end
            break;
        end
        headerLines = headerLines + 1;
    end

    % Read numeric data: t, x, y, z
    data = textscan(fid, '%f %f %f %f');
    fclose(fid);

    t = data{1};
    x = data{2};
    y = data{3};
    z = data{4};

    % Plot the 3D curve
    figure;
    plot3(x, y, z, 'LineWidth', 2);
    grid on;
    axis equal;
    xlabel('x');
    ylabel('y');
    zlabel('z');
    title('Spiral Curve on Cone Surface');
end