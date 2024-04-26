function update_queue_data(obj, maps)
    intersection_struct_map = maps("intersection_struct_map");
    road_link_map = maps("road_link_map");
    link_queue_map = maps("link_queue_map");
    
    for intersection_struct = values(intersection_struct_map)'
        
        tmp_queue_struct = [];
        for input_road_id = intersection_struct.input_road_ids
            input_road_direction = intersection_struct.input_road_directions(input_road_id);


            tmp_queue_length = 0;
            input_road_link_ids = road_link_map(input_road_id);
            for link_id = input_road_link_ids{1}
                if isKey(link_queue_map, link_id)
                    queue_counter_id = link_queue_map(link_id);
                    queue_counter_obj = obj.vis_obj.Net.QueueCounters.ItemByKey(queue_counter_id);
                    tmp_queue_length = tmp_queue_length + queue_counter_obj.get('AttValue', 'QLen(Current, Last)');
                end
            end

            if ~ismember(intersection_struct.id, keys(obj.queue_data_map))
                if strcmp(input_road_direction, "north")
                    tmp_queue_struct.north = [tmp_queue_length];
                elseif strcmp(input_road_direction, "south")
                    tmp_queue_struct.south = [tmp_queue_length];
                elseif strcmp(input_road_direction, "east")
                    tmp_queue_struct.east = [tmp_queue_length];
                elseif strcmp(input_road_direction, "west")
                    tmp_queue_struct.west = [tmp_queue_length];
                end

            else
                if strcmp(input_road_direction, "north")
                    tmp_queue_struct.north = [obj.queue_data_map(intersection_struct.id).north, tmp_queue_length];
                elseif strcmp(input_road_direction, "south")
                    tmp_queue_struct.south = [obj.queue_data_map(intersection_struct.id).south, tmp_queue_length];
                elseif strcmp(input_road_direction, "east")
                    tmp_queue_struct.east = [obj.queue_data_map(intersection_struct.id).east, tmp_queue_length];
                elseif strcmp(input_road_direction, "west")
                    tmp_queue_struct.west = [obj.queue_data_map(intersection_struct.id).west, tmp_queue_length];
                end
            end
        end
        

        obj.queue_data_map(intersection_struct.id) = tmp_queue_struct;
    end

    
end