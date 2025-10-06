L = 1;
Lmin = 0.01;

P = [0, 0; 0.5, sqrt(3)/2; 1, 0; 0, 0];

while true
    newP = [];
    N = size(P,1);
    subdivide = false;
    for i = 1:N-1
        A = P(i, :);
        B = P(i+1, :);
        segLen = norm(B - A);
        if segLen > Lmin
            subdivide = true;
            C = A + (B - A)/3;
            D = A + 2*(B - A)/3;
            angle = pi/3; 
            v = D - C;
            R = [cos(angle), -sin(angle); sin(angle), cos(angle)];
            E = C + (v * R');
            newP = [newP; A; C; E; D];
        else
            newP = [newP; A];
        end
    end
    newP = [newP; P(end, :)];
    P = newP;
    if ~subdivide
        break;
    end
end

figure;
plot(P(:,1), P(:,2), '-b', 'LineWidth', 1);
axis equal off;
title('Koch Snowflake');
