function update_calc_time_data(obj, controllers)
    for intersection_id = keys(controllers)'
        controller = controllers(intersection_id);
        controller = controller{1};
        if ~ismember(intersection_id, keys(obj.calc_time_data_map))
            obj.calc_time_data_map(intersection_id) = {[controller.get_calc_time()]};
        else
            tmp_calc_time_data = obj.calc_time_data_map(intersection_id);
            tmp_calc_time_data = tmp_calc_time_data{1};
            tmp_calc_time_data = [tmp_calc_time_data, controller.get_calc_time()];

            obj.calc_time_data_map(intersection_id) = {tmp_calc_time_data};
        end
    end

end