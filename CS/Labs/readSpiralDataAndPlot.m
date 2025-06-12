function readSpiralDataAndPlot(filename)
    fid = fopen(filename, 'r');
    if fid == -1
        error('Could not open file %s for reading.', filename);
    end
    
    data = textscan(fid, '%f %f %f', 'CommentStyle', '%');
    fclose(fid);

    phi = data{1};   % phi values
    x   = data{2};   % x-coordinates
    y   = data{3};   % y-coordinates

    % Plot
    figure;
    plot(x, y, 'LineWidth', 1.5);
    axis equal;
    grid on;
    title('Logarithmic Spiral');
    xlabel('x');
    ylabel('y');
end