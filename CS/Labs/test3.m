function sorted_massive =  test3(massive)
    for i = 1:length(massive) - 1
        for j = 1:length(massive)-i
            a = massive(j) > massive(j + 1);
            massive([j, j+1]) = massive([j + a, j + 1 - a]);
        end
    end
    sorted_massive = massive;
end