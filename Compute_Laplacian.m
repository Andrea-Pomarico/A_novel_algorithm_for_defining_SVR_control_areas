function [L,D] = Compute_Laplacian(B)
    L = abs(B); %Some values are negative ?
    L(logical(eye(size(L)))) = 0; % Don't take into account just x of the lines
    L = - L;
    % Sum of the rows
    sum_rows = sum(abs(L), 2);
    % Add diagonal elements
    for i = 1:size(L, 1)
        L(i, i) = sum_rows(i);
    end
    D = diag(diag(L));
end
