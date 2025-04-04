function Ln = Normalized_Laplacian(Laplacian,D)
    Ln = D^(-0.5)*Laplacian*D^(-0.5); % Normalized laplacian
end