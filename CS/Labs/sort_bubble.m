function s = sort_bubble(mass)
    for i = 1:length(mass)-1
        for j = 1:length(mass)-i
            if mass(j) > mass(j+1)
                temp = mass(j);
                mass(j) = mass(j+1);
                mass(j+1) = temp;
            end
        end
    end
    s = mass;
end