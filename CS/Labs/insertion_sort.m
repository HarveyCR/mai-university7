function s = insertion_sort(mass)
    for i = 2:length(mass)
        tmp = mass(i);
        j = i - 1;
        while j >= 1 && (tmp < mass(j))
            mass(j+1) = mass(j);
            j =  j - 1;
        end
        mass(j+1) = tmp;
    end
    s = mass;
end
