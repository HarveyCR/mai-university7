function sorted_massive =  test2(massive)
    for i = 1:length(massive)
        massive = [massive(massive < massive(i)) massive(i) massive(massive > massive(i))];
    end
    sorted_massive = massive;
end