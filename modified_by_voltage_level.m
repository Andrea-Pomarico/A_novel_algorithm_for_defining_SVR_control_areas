function [bus_400,branch_400,newNodInfo] = modified_by_voltage_level(bus,branch,nodInfo,voltage_level_input)

newNodInfo = nodInfo;


bus_400 = bus;

v_400 = zeros(size(bus, 1),1);

for i = 1:size(bus, 1)
    if bus(i, 10) > voltage_level_input
        v_400(i) = 1;
    end
end
bus_400=bus_400(v_400 == 1, :);
newNodInfo = newNodInfo(v_400 == 1, :);
bus_400=bus_400(italianRows == 1, :);
newNodInfo = newNodInfo(italianRows == 1, :);

branch_400 = branch;
valid_rows = ismember(branch_400(:, 1), bus_400) & ismember(branch_400(:, 2), bus_400);

branch_400 = branch_400(valid_rows, :);


num_rows = size(bus_400, 1);

Key_400 = [bus_400(:, 1), (1:num_rows)'];

for i = 1:size(branch_400, 1)
    index = find(Key_400(:, 1) == bus_400(i));
    
    if ~isempty(index)
        bus_400(i) = Key_400(index, 2);
    end
end

for i = 1:size(branch_400, 1)
    index_col1 = find(branch_400(i, 1) == Key_400(:,1));
    
    if ~isempty(index_col1)
        branch_400(i, 1) = Key_400(index_col1, 2);
    end
end

for i = 1:size(branch_400, 1)
    index_col1 = find(branch_400(i, 2) == Key_400(:,1));
    
    if ~isempty(index_col1)
        branch_400(i, 2) = Key_400(index_col1, 2);
    end
end

for i=1:height(newNodInfo)
    newNodInfo.Bus(i)=i;
end


end
