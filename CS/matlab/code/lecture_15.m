x = 0:pi/16:pi;
y = sin(x);
[fid] = fopen("example.txt", "wt");

if fid ~= -1
    fprintf(fid, '-----------------------------------\n');
    fprintf(fid, '|      x      | sin(x)            |\n');
    fprintf(fid, '-----------------------------------\n');
    fprintf(fid, "|    %9.5f  | %+10.3e       | \n", [x;y]);
    fprintf(fid, '-----------------------------------\n');
    fclose(fid);
end
