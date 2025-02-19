%a = randi([1,10], 1, 5);
%a(a > 2);
% t = (a > 2) ? true : false; - тернарная операция
% if (2>1) t = true; end;

x = 3;
if (x < 0)
    y = 0;
elseif (x<5)
        y = x;
    else
        y = 5;
end


%switch (variable)
%    value1 : stataments1
%    value2 : stataments2
%     overwise : statemets3

A = (1:5)';
x = -2*pi:pi/8:2*pi;
X = ones(length(A), 1)*x;
Y = A * sin(x);

k=1;
switch (A(k))
    case 1 : color ="red";
    case 2 : color = "yellow";
    case 3 : cololr = "green";
    case 4 : cololr = "blue";
    otherwise : color = "black";
end