x = 2 - 4 * rand(1, 1e6);
y = 2 - 4 * rand(1, 1e6);

l = ((x >= 0) & (y >= 0) & ((x - 0.5).^2 + (y).^2 <= 0.25)) | ((x <= 0) & (y <= 0) & ((x + 0.5).^2 + (y).^2 <= 0.25)) | ((x >= 0) & (y <= 0) & (y >= x - 1)) | ((x <= 0) & (y >= 0) & (y <= x + 1));
plot(x(l), y(l), '.k')
axis equal, axis([-1, 1, -1, 1])
xlabel('x'), ylabel("y"), title('The logical area')
grid on


