function tri_pascal(filename)
    nRows = 10;
    T = zeros(nRows);
    for i = 1:nRows
        T(i,1) = 1;
        T(i,i) = 1;
        for j = 2:i-1
            T(i,j) = T(i-1,j-1) + T(i-1,j);
        end
    end

    fid = fopen(filename, 'w');
    if fid == -1
        error('Could not open file %s for writing.', filename);
    end

    lastRow = T(nRows,1:nRows);
    lastStrs = arrayfun(@(x) sprintf('%d',x), lastRow, 'UniformOutput', false);
    lastLine = strjoin(lastStrs, '   ');
    maxWidth = length(lastLine);

    for i = 1:nRows
        row = T(i,1:i);
        strs = arrayfun(@(x) sprintf('%d',x), row, 'UniformOutput', false);
        line = strjoin(strs, '   ');
        pad = floor((maxWidth - length(line))/2);
        fprintf(fid, '%*s%s\n', pad, '', line);
    end

    fclose(fid);
end
