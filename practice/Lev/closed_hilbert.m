function closed_hilbert(n)
    axiom = 'A';
    rules = @(ch) switcher(ch, ...
        'A', '+BF-AFA-FB+', ...
        'B', '-AF+BF B+FA-', ...
        ch,   ch);
    iter_str = axiom;
    for k = 1:n
        s = '';
        for i = 1:length(iter_str)
            s = [s, rules(iter_str(i))];  %#ok<AGROW>
        end
        iter_str = s;
    end

    N = length(iter_str);

    L = 1/(2^n - 1);

    x = zeros(N+1,1);
    y = zeros(N+1,1);
    dir = 0;
    for i = 1:N
        c = iter_str(i);
        switch c
            case 'F'
                x(i+1) = x(i) + L*cosd(dir);
                y(i+1) = y(i) + L*sind(dir);
            case '+'
                dir = mod(dir + 90,360);
                x(i+1)=x(i); y(i+1)=y(i);
            case '-'
                dir = mod(dir - 90,360);
                x(i+1)=x(i); y(i+1)=y(i);
            otherwise
                x(i+1)=x(i); y(i+1)=y(i);
        end
    end

    figure; hold on; axis equal off;
    plot(x, y, 'b-');

    xm = 1 - x;
    plot([x(end); xm(end:-1:1)], [y(end); y(end:-1:1)], 'r-');

    title(sprintf('Замкнутая кривая Гилберта порядка %d', n));
end

function out = switcher(ch, patA, repA, patB, repB, patDefault, repDefault)
    if ch == patA
        out = repA;
    elseif ch == patB
        out = repB;
    else
        out = repDefault;
    end
end
