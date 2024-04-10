function update_input_output_data(obj, maps)
    link_input_output_map = maps("link_input_output_map");
    link_road_map = maps("link_road_map");

    for link_id = keys(link_input_output_map)'
        if strcmp(link_input_output_map(link_id),"input")
            road_id = link_road_map(link_id);

            DC_measurement_id = obj.link_DC_measurement_map(link_id);
            DC_measurement_obj = obj.vis_obj.Net.DataCollectionMeasurement.ItemByKey(DC_measurement_id);

            if ~ismember(road_id, keys(obj.input_data_map))
                obj.input_data_map(road_id) = {[DC_measurement_obj.get('AttValue', 'Vehs(Current, Last, All)')]};
            else
                tmp_input_data = obj.input_data_map(road_id);
                tmp_input_data = tmp_input_data{1};
                tmp_input_data = [tmp_input_data, DC_measurement_obj.get('AttValue', 'Vehs(Current, Last, All)')];
                obj.input_data_map(road_id) = {tmp_input_data};
            end

        elseif strcmp(link_input_output_map(link_id),"output")
            road_id = link_road_map(link_id);

            DC_measurement_id = obj.link_DC_measurement_map(link_id);
            DC_measurement_obj = obj.vis_obj.Net.DataCollectionMeasurement.ItemByKey(DC_measurement_id);

            if ~ismember(road_id, keys(obj.output_data_map))
                obj.output_data_map(road_id) = {[DC_measurement_obj.get('AttValue', 'Vehs(Current, Last, All)')]};
            else
                tmp_output_data = obj.output_data_map(road_id);
                tmp_output_data = tmp_output_data{1};
                tmp_output_data = [tmp_output_data, DC_measurement_obj.get('AttValue', 'Vehs(Current, Last, All)')];
                obj.output_data_map(road_id) = {tmp_output_data};
            end
        end
    end
end