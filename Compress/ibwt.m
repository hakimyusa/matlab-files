function result = ibwt(seq, index)

T = [];
for i = 1:numel(seq)
    T = [seq(:) T]; %#ok<AGROW>
    T = sortrows(T);
end

result = cast(T(index, :), class(seq));
