clear all;
close all;
clc;

%%
% Upload the scenario
maindir = cd;

load('Scenario.mat'); % Here, you can import your scenario based on MATPOWER matrix

addpath(sprintf('%s\\Load_flow', maindir));

%% Hyperparameters setting

voltage_level_input=170; % Minimum voltage level to be consider

K_dimension=5; % Dimension of eigenspace 

num_clusters_input=7; % Number of clusters

%%
% Function to delete bus and lines with rated voltage lower than voltage_level_input
[bus,branch,nodInfo] = modified_by_voltage_level(bus,branch,nodInfo,voltage_level_input);

% Function to create the admittance matrix 
[Ybus, ~, ~] = makeYbus(baseMVA, bus, branch(:, [F_BUS, T_BUS, BR_R, BR_X, BR_B, BR_G, RATE_A, RATE_B, RATE_C, TAP, SHIFT, BR_STATUS]));

Ybus_full=full(Ybus);
B = imag(Ybus_full); 


% Create the Laplacian Matrix
[Laplacian,D] = Compute_Laplacian(B);


%% Checking subgraph 

a = Checking_Subgraph(D);
if isempty(a)
    disp('Graph connected.');
else
    disp('There are some subgraphs.'); 
    [B,nodInfo,Ybus_full]=Neglect_subgraph(D,nodInfo,B,Ybus_full); 
    [Laplacian,D] = Compute_Laplacian(B);
end
%%
% Compute the Normalized Laplacian Ln
Ln=Normalized_Laplacian(Laplacian,D);
%% Eigendecomposition Analysis
[lambda,v]=Eigendecomposition(Ln);

% Plot the eigenvalues of Ln
figure;
plot(lambda, '.', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
xlabel('Index');
ylabel('Eigenvalues');
grid on;

% Eigengaps Analysis
eigengaps = Eigengaps(lambda);

% Plot
figure;
plot(eigengaps, '-', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
xlabel('Eigenvalues');
ylabel('Relative Eigengaps');
grid on;

%% Related Eigenspace R^k

k=K_dimension; % Choose the dimension of the eigenspace based on relative eigengaps

k_coordinate_1_normalized = Normalized_coordinate_k(k,v);

% Hierarchical Clustering in R^k

Z = linkage(k_coordinate_1_normalized, 'ward', 'euclidean');
num_clusters = num_clusters_input; % NUMBER OF CLUSTERS
cluster_indices = cluster(Z, 'maxclust', num_clusters);

% Plot dendrogram
figure;
dendrogram(Z, 'Labels', num2str((1:size(k_coordinate_1_normalized, 1))'), 'ColorThreshold', Z(end-num_clusters+2, 3));
xlabel('Equivalent Buses')
ylabel('Inter-cluster distance')
grid on;

% Quality of the clustering

[max_expansion,Q] = Quality_clustering(k,Laplacian,cluster_indices,lambda,B)

voltage_level=voltage_level_input; % Input: voltage level in consideration

