function [max_expansion,Q] = Quality_clustering(k,Laplacian,cluster_indices,lambda_sorted,B)
    
    % Expansion

    % Volume of the clusters
    num_clusters = max(cluster_indices);
    cluster_volumi = zeros(1, num_clusters);
    
    % Compute the volume for each cluster
    for i = 1:num_clusters
        nodi_cluster_corrente = find(cluster_indices == i);
        volume_cluster_corrente = sum(abs(diag(Laplacian(nodi_cluster_corrente, nodi_cluster_corrente))));
        cluster_volumi(i) = volume_cluster_corrente;
    end
    
    % Compute the boundaries of each cluster
    results_matrix = zeros(num_clusters, 1);
    for i = 1:num_clusters
        laplacian_clusters = Laplacian(cluster_indices == i, cluster_indices ~= i);
        total_sum = sum(laplacian_clusters(:));
        total_sum_modulo = abs(total_sum);
        results_matrix(i) = total_sum_modulo;
    end
    
    expansion = results_matrix./cluster_volumi'; 
    max_expansion = max(expansion);

    %Modularity
    Graphh = (B ~= 0);
    Graphh(logical(eye(size(B)))) = 0; % Not interested in degrees
    G = graph(Graphh);
    m = sum(Graphh(:)) / 2;
    % Gradi dei nodi
    ki = sum(Graphh, 2);
    % Calcolo della modularity
    Q = 0;
    for i = 1:size(Graphh, 1)
        for j = 1:size(Graphh, 2)
            A_ij = Graphh(i, j);
            c_i = cluster_indices(i);
            c_j = cluster_indices(j);

            % delta
            delta_c = (c_i == c_j);

            % modularity
            Q = Q + (A_ij - ki(i) * ki(j) / (2 * m)) * delta_c;
        end
    end
    % Normalization
    Q = Q / (2 * m);

end