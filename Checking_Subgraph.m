function a = Checking_Subgraph(D)
    % Find diagolan zero elements 
    diagonal_D = diag(D);
    a = find(diagonal_D == 0);
end