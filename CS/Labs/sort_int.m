function [m] = sort_int(m)

  if m(2)>m(1)
    buf = m(2); m(2) = m(1); m(1) = buf;
  end
  if length(m) == 2, return; end

  k = 3;
  while k <= length(m)
    if m(k) < m(k-1)
      p = k-2;
      while (p>0) && (m(k)<m(p))   %процесс поиска
        p = p -1;
      end
      buf = m(k);
      m(p+2:k) = m(p+1:k-1); %сдвигаем массив на одну позицию вправо
      m(p+1) = buf;
    end
    k = k + 1;
  end

end