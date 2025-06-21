function m = sort_merge(m)
  temp = zeros(1,length(m));
  partition(1,length(m));

  function partition(first,last)
    half = fix((first+last)/2)+1; 

    if first+1 ~=half
      partition(first,half-1);
    end
    if half~=last
      partition(half,last);
    end
    merge(first,half,last);
end

  function merge(first,half,last)
    k = first;
    p = half;
    t = 1;
    len = last - first+1;
    while (k<=half-1)&&(p<=last)
      if m(k)<m(p)
        temp(t) = m(k);
        k = k + 1;
      else
        temp(t) = m(p);
        p = p + 1;
      end
      t = t + 1;
    end
    if p>last
      temp(t:len) = m(k:half-1);
    else
      temp(t:len) = m(p:last);
    end
    m(first:last) = temp(1:len);
    end
end