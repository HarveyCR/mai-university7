function s = sort_simple_selection(mass)
    for i = 1:length(mass)-1
      k = i;
      tmp = mass(i);
      for j = i+1:length(mass)
        if mass(j)<tmp
          k = j;
          tmp = mass(j);
        end
      end
      mass(k) = mass(i);
      mass(i) = tmp;
    end
    s = mass;
end
