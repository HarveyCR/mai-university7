x = 2 - 4 * rand(1, 1e6);
y = 2 - 4 * rand(1, 1e6);

q1 = (x >= 0) & (y >= 0) & ((x - 0.5).^2 + (y).^2 <= 0.25);
q2 = (x <= 0) & (y <= 0) & ((x + 0.5).^2 + (y).^2 <= 0.25);
q3 = (x >= 0) & (y <= 0) & (y >= x - 1);
q4 = (x <= 0) & (y >= 0) & (y <= x + 1);
plot(x(q1|q2|q3|q4), y(q1|q2|q3|q4), '.k')
axis equal, axis([-1, 1, -1, 1])
xlabel('x'), ylabel("y"), title('The logical area')
grid on


