function get_vehicle_data(obj, v_obj, maps)
    road_struct_map = maps('road_struct_map');
    road_link_map = maps('road_link_map');
    link_type_map = maps('link_type_map');

    for road_id = keys(road_link_map)'

        % road_vehs_map の作成
        road_struct = road_struct_map(road_id);
        link_ids = road_link_map(road_id);
        link_ids = link_ids{1};

        vehs_data = [];

        for link_id = link_ids
            link_obj = v_obj.Net.Links.ItemByKey(link_id);
            vehs_pos = link_obj.Vehs.GetMultiAttValues('Pos');
            vehs_route = link_obj.Vehs.GetMultiAttValues('RouteNo');
            [num_veh,~] = size(vehs_pos);


            link_type = link_type_map(link_id);

            if strcmp(link_type, "main") || strcmp(link_type, "out")
                for veh_id = 1:num_veh
                    vehs_data = [vehs_data; vehs_pos{veh_id,2}, cast(vehs_route{veh_id,2},'double')];
                end
            elseif strcmp(link_type, "sub")
                for veh_id = 1:num_veh
                    vehs_data = [vehs_data; vehs_pos{veh_id,2} + road_struct.from_pos + road_struct.con - road_struct.to_pos, cast(vehs_route{veh_id,2}, 'double')];
                end
            elseif strcmp(link_type, "connector")
                for veh_id = 1:num_veh
                    vehs_data = [vehs_data; vehs_pos{veh_id,2} + road_struct.from_pos, cast(vehs_route{veh_id,2}, 'double')];
                end
            end

            if ~isempty(vehs_data)
                vehs_data = sortrows(vehs_data, 1, 'descend');
            end
        end
        
        obj.road_vehs_map(road_id) = {vehs_data};

        % road_first_veh_map の作成

        first_straight_id = 0;
        first_right_id = 0;
        first_ids = [];

        if ~isempty(vehs_data)
            for veh_id = 1: length(vehs_data(:,2))
                route = vehs_data(veh_id,2);
                if route == 1 || route == 2
                    if first_straight_id == 0
                        first_straight_id = veh_id;
                    end
                elseif route == 3
                    if first_right_id == 0
                        first_right_id = veh_id;
                    end
                end
            end
        end

        first_ids.straight = first_straight_id;
        first_ids.right = first_right_id;

        obj.road_first_veh_map(road_id) = first_ids;

    end

end