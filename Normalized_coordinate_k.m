function k_coordinate_1_normalized = Normalized_coordinate_k(k,v)

    k_coordinate_0 = v(:, 1:k);
    k_coordinate_1 = k_coordinate_0; 
    % Compute the number of the rows
    n_rows = size(k_coordinate_1, 1);
    % new matrix
    k_coordinate_1_normalized = zeros(size(k_coordinate_1));
    % Normalization of each rows
    for i = 1:n_rows
        vettore = k_coordinate_1(i, :);
        modulo = norm(vettore);
        k_coordinate_1_normalized(i, :) = vettore / modulo;
    end

end