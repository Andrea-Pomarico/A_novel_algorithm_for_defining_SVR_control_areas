function [eigenvalues_sorted,eigenvectors_sorted] = Eigendecomposition(Ln)

    [eigenvectors, eigenvalues] = eig(Ln);
    
    % Just real part since imag part should be really small
    eigenvectors = real(eigenvectors);
    eigenvalues = real(eigenvalues);

    % Sort the eigenvalues and eigenvectors
    [eigenvalues_sorted, index_eigenvalues_sorted] = sort(diag(eigenvalues));
    eigenvectors_sorted = eigenvectors(:, index_eigenvalues_sorted);
end