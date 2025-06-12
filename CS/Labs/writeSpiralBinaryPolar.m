function writeSpiralBinaryPolar(filename, a, b, phiStart, phiEnd, nPoints)

    phi = linspace(phiStart, phiEnd, nPoints);
    r   = a * exp(b * phi);
    data = [phi; r];                              

    fid = fopen(filename, 'wb');                  
    if fid == -1
        error('Could not open file %s for writing.', filename);
    end
    fwrite(fid, data, 'double');                  
    fclose(fid);
end