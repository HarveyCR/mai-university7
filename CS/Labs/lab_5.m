x = 3.741;
y = -0.825;
z = 0.160;

str1 = char('Фельдман', 'Лев', 'Борисович');
str1 = char(str1, 'x = 3.741; y = -0.825; z = 0.160');
str1 = char(str1, 'a = (1 + sinh(x + y)) / (x - ((2 * y) / 1 + x^2 * y^2))');
str1 = char(str1, 'b = cos(atan(1 /z))^2')

[deblank(str1(1, :)), ' ', deblank(str1(2, :)), ' ', deblank(str1(3, :))], ...
    eval(str1(5, :)), eval(str1(6, :));

clear('x', 'y')

str2 = char('Фельдман Лев Борисович');
str2 = char(str2, 'x = 2 - 4 * rand(1, 1e6);');
str2 = char(str2, 'y = 2 - 4 * rand(1, 1e6);');
str2 = char(str2, 'l = ((x >= 0) & (y >= 0) & ((x - 0.5).^2 + (y).^2 <= 0.25)) | ((x <= 0) & (y <= 0) & ((x + 0.5).^2 + (y).^2 <= 0.25)) | ((x >= 0) & (y <= 0) & (y >= x - 1)) | ((x <= 0) & (y >= 0) & (y <= x + 1))')
% eval([str2(2, 1:end), str2(3, 1:end), str2(4, 1:end)]);

%plot(x(l), y(l), '.k')
%axis equal, axis([-1, 1, -1, 1])
%xlabel('x'), ylabel("y"), title('The logical area')
%grid on
