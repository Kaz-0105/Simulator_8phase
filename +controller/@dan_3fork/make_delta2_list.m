function make_delta2_list(obj)
    route_vehs = obj.route_vehs;
    last_index = obj.u_length + obj.z_length;
    delta2_list = [];

    if isfield(route_vehs, 'north')
        for veh_id = 1:length(route_vehs.north)
            if veh_id == 1
                last_index = last_index + 4;

                if route_vehs.north(veh_id) == 1 || route_vehs.north(veh_id) == 2
                    first_veh_route = "straight";
                elseif route_vehs.north(veh_id) == 3
                    first_veh_route = "right";
                end
            elseif route_vehs.north(veh_id) == 1 || route_vehs.north(veh_id) == 2
                if strcmp(first_veh_route, "right")
                    delta2_list = [delta2_list, last_index + 6];
                    first_veh_route = "done";
                    last_index = last_index + 7;
                else
                    delta2_list = [delta2_list, last_index + 7];
                    last_index = last_index + 9;
                end
            elseif route_vehs.north(veh_id) == 3
                if strcmp(first_veh_route, "straight")
                    delta2_list = [delta2_list, last_index + 6];
                    first_veh_route = "done";
                    last_index = last_index + 7;
                else
                    delta2_list = [delta2_list, last_index + 7];
                    last_index = last_index + 9;
                end
            end
        end
    end

    if isfield(route_vehs, 'south')
        for veh_id = 1:length(route_vehs.south)
            if veh_id == 1
                last_index = last_index + 4;

                if route_vehs.south(veh_id) == 1 || route_vehs.south(veh_id) == 2
                    first_veh_route = "straight";
                elseif route_vehs.south(veh_id) == 3
                    first_veh_route = "right";
                end
            elseif route_vehs.south(veh_id) == 1 || route_vehs.south(veh_id) == 2
                if strcmp(first_veh_route, "right")
                    delta2_list = [delta2_list, last_index + 6];
                    first_veh_route = "done";
                    last_index = last_index + 7;
                else
                    delta2_list = [delta2_list, last_index + 7];
                    last_index = last_index + 9;
                end
            elseif route_vehs.south(veh_id) == 3
                if strcmp(first_veh_route, "straight")
                    delta2_list = [delta2_list, last_index + 6];
                    first_veh_route = "done";
                    last_index = last_index + 7;
                else
                    delta2_list = [delta2_list, last_index + 7];
                    last_index = last_index + 9;
                end
            end
        end
    end

    if isfield(route_vehs, 'east')
        for veh_id = 1:length(route_vehs.east)
            if veh_id == 1
                last_index = last_index + 4;

                if route_vehs.east(veh_id) == 1 || route_vehs.east(veh_id) == 2
                    first_veh_route = "straight";
                elseif route_vehs.east(veh_id) == 3
                    first_veh_route = "right";
                end
            elseif route_vehs.east(veh_id) == 1 || route_vehs.east(veh_id) == 2
                if strcmp(first_veh_route, "right")
                    delta2_list = [delta2_list, last_index + 6];
                    first_veh_route = "done";
                    last_index = last_index + 7;
                else
                    delta2_list = [delta2_list, last_index + 7];
                    last_index = last_index + 9;
                end
            elseif route_vehs.east(veh_id) == 3
                if strcmp(first_veh_route, "straight")
                    delta2_list = [delta2_list, last_index + 6];
                    first_veh_route = "done";
                    last_index = last_index + 7;
                else
                    delta2_list = [delta2_list, last_index + 7];
                    last_index = last_index + 9;
                end
            end
        end
    end

    if isfield(route_vehs, 'west')
        for veh_id = 1:length(route_vehs.west)
            if veh_id == 1
                last_index = last_index + 4;

                if route_vehs.west(veh_id) == 1 || route_vehs.west(veh_id) == 2
                    first_veh_route = "straight";
                elseif route_vehs.west(veh_id) == 3
                    first_veh_route = "right";
                end
            elseif route_vehs.west(veh_id) == 1 || route_vehs.west(veh_id) == 2
                if strcmp(first_veh_route, "right")
                    delta2_list = [delta2_list, last_index + 6];
                    first_veh_route = "done";
                    last_index = last_index + 7;
                else
                    delta2_list = [delta2_list, last_index + 7];
                    last_index = last_index + 9;
                end
            elseif route_vehs.west(veh_id) == 3
                if strcmp(first_veh_route, "straight")
                    delta2_list = [delta2_list, last_index + 6];
                    first_veh_route = "done";
                    last_index = last_index + 7;
                else
                    delta2_list = [delta2_list, last_index + 7];
                    last_index = last_index + 9;
                end
            end
        end
    end

    obj.variables_list_map("delta_2") = {delta2_list};


end