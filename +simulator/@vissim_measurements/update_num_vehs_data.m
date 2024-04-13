function update_num_vehs_data(obj, controllers)
    
    for intersection_id = keys(controllers)'
        num_vehs = controllers(intersection_id).get_num_vehs();

        if isempty(num_vehs)
            num_vehs_all = 0;
        else
            num_vehs_all = sum([num_vehs.north, num_vehs.east, num_vehs.south, num_vehs.west]);
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