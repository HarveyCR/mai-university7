function m = sort_heap(m)
  if nargin<1
    str = 'error: Нет массива';
    fprintf(2,str);  
    return;
  end

  if length(m) <2
    return;
  end
  len = uint32(length(m));
  half = bitshift(len,-1);  
  head = half;  
  while len > 1
    parent = head;
    element = m(parent);  
    while parent<=half
      child = 2*parent;
      if child + 1 <= len && m(child)<m(child+1)
        child = child + 1;
      end
      if element >= m(child)
        break
      end
      m(parent) = m(child);
      parent = child;
    end

    if head ~= parent
      m(parent) = element;
    end
    if head >1
      head = head - 1; 
    else 
      tmp = m(1);
      m(1) = m(len);
      m(len) = tmp;
      len = len - 1;
      half = bitshift(len,-1);
    end
  end
end