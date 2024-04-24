function update_num_vehs_data(obj, controllers)
    
    for intersection_id = keys(controllers)'
        controller = controllers(intersection_id);
        controller = controller{1};
        num_vehs = controller.get_num_vehs();

        if isempty(num_vehs)
            num_vehs_all = 0;
        else
            if ~isfield(num_vehs, 'north')
                num_vehs_all = sum([num_vehs.east, num_vehs.south, num_vehs.west]);
            elseif ~isfield(num_vehs, 'south')
                num_vehs_all = sum([num_vehs.north, num_vehs.east, num_vehs.west]);
            elseif ~isfield(num_vehs, 'east')
                num_vehs_all = sum([num_vehs.north, num_vehs.south, num_vehs.west]);
            elseif ~isfield(num_vehs, 'west')
                num_vehs_all = sum([num_vehs.north, num_vehs.east, num_vehs.south]);
            else
                num_vehs_all = sum([num_vehs.north, num_vehs.east, num_vehs.south, num_vehs.west]);
            end
        end

        if ~ismember(intersection_id, keys(obj.num_vehs_data_map))
            obj.num_vehs_data_map(intersection_id) = {[num_vehs_all]};
        else
            tmp_num_vehs_data = obj.num_vehs_data_map(intersection_id);
            tmp_num_vehs_data = tmp_num_vehs_data{1};
            tmp_num_vehs_data = [tmp_num_vehs_data, num_vehs_all];

            obj.num_vehs_data_map(intersection_id) = {tmp_num_vehs_data};
        end
    end
end