r = 8.8;
H = 13 - 1.2 - 1.8;
R = 10.8;

tg = 10 / (10.8-8.8); 

x = (0:1:10.8);
y = -tg * x + 52.8;

plot(x, y)
grid on
axis equal

yf = @(x) -tg * x + 52.8;