function [B,nodInfo,Y] = Neglect_subgraph(D,nodInfo,B,Y)

    isolated_buses = find(diag(D)==0);
    nodInfo(isolated_buses,:) = [];
    B(isolated_buses, :) = [];
    B(:, isolated_buses) = [];
    Y(isolated_buses, :) = [];
    Y(:, isolated_buses) = [];
end
