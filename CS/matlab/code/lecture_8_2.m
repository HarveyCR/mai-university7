A = (1:5)';
x = -2*pi:pi/8:2*pi;
X = ones(length(A), 1)*x;
Y = A * sin(x);

hold on
L = line("XData", [0, 0], "YData", [0, 0], "LineWidth", 3);
axis([x(1) x(end) min(Y(5,:)) max(Y(5,:))])
while true
for k = [1:5 4:-1:1] 
    switch (A(k))
        case 1 
            color ="red";
        case 2 
            color = "yellow";
        case 3 
            color = "green";
        case 4 
            color = "blue";
        otherwise
            color = "black";
    end

set(L, "XData", x, "YData", Y(k, :), "color", color)
pause(0.2)
end
end