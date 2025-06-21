function s = sort_simple_selec(mass)
    for i = 1:length(mass)-1
      k = i;
      tmp = mass(i);
      for j = i:length(mass)
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
