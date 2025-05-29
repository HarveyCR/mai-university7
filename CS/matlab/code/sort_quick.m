function m = sort_quick()
    function partition(left, right)
        if left == right
            return; 
        end
        i = left; j = left;
        pivot = m(right);

        while j < right
            if m(j) < pivot
                tmp = m(j); m(j)=m(i); m(i) = tmp;
                i = i + 1;
            end
            j = j + 1;
        end
        m(right) = m(i); m(i) = pivot;

        if (i - left < right - i)
            if i - left > 1, partition(left, i-1); end
            if right - i > 1, partition(i+1, right); end
        else
            if right - i > 1, partition(i+1, right); end
            if i - left > 1, partition(left, i -1); end
        end
    end

partition(1, length(m))
end