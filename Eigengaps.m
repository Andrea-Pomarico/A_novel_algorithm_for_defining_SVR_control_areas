function eigengaps = Eigengaps(lambda)

    lambda_difference = zeros(size(lambda));
    Relative_eigengaps= zeros(size(lambda));
    % Difference
    for i = 2:length(lambda)
        lambda_difference(i) = lambda(i) - lambda(i-1);
        Relative_eigengaps(i) = lambda_difference(i)/lambda(i);
    end
    eigengaps = Relative_eigengaps;
end