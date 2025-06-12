fid = fopen('spiral.bin', 'rb');
raw = fread(fid, [2, Inf], 'double');
fclose(fid);

phi = raw(1, :);
r   = raw(2, :);

% Показать как таблицу
T = table(phi.', r.', 'VariableNames', {'Phi', 'R'})
