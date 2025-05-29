function transform(filename)
fid_r = fopen(filename,'rt');
if fid_r == -1
  error ('ОШИБКА ПРИ ОТКРЫТИИ ФАЙЛА')
end
fid_w = fopen('konec.txt' , 'wt');
while ~feof(fid_r)
  str = fgetl(fid_r);
  if length(str) < 80
    pos = 80-length(str)-1;
    b = blanks(pos);
    str1 = [str, b];
    fprintf(fid_w, '%s\n', str1)
  endif
end
end
fclose (fid_r); fclose(fid_w);
copyfile('konec.txt',filename)
%filename = 'obras.txt';
%transform(filename)
