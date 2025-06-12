function readSpiralBinaryPolarAndPlot(filename)
    fid = fopen(filename, 'rb');                  
    if fid == -1
        error('Could not open file %s for reading.', filename);
    end
    raw = fread(fid, [2, Inf], 'double');
    fclose(fid);

    phi = raw(1, :);
    r   = raw(2, :);
    figure;
    polarplot(phi, r, 'LineWidth', 1.5);
    title('Logarithmic Spiral (Polar)');
    grid on;
end
