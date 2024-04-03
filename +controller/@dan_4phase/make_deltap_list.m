function make_deltap_list(obj)
    route_vehs = obj.route_vehs;
    last_index = obj.u_length + obj.z_length;
    deltap_list = [];

    for veh_id = 1:length(route_vehs.north)
        if veh_id == 1
            deltap_list = [deltap_list, last_index + 2];
            last_index = last_index + 4;

            if route_vehs.north(veh_id) == 1 || route_vehs.north(veh_id) == 2
                first_veh_route = "straight";
            elseif route_vehs.north(veh_id) == 3
                first_veh_route = "right";
            end
        elseif route_vehs.north(veh_id) == 1 || route_vehs.north(veh_id) == 2
            if strcmp(first_veh_route, "right")
                deltap_list = [deltap_list, last_index + 2];
                first_veh_route = "done";
                last_index = last_index + 7;
            else
                deltap_list = [deltap_list, last_index + 2];
                last_index = last_index + 9;
            end
        elseif route_vehs.north(veh_id) == 3
            if strcmp(first_veh_route, "straight")
                deltap_list = [deltap_list, last_index + 2];
                first_veh_route = "done";
                last_index = last_index + 7;
            else
                deltap_list = [deltap_list, last_index + 2];
                last_index = last_index + 9;
            end
        end
    end

    for veh_id = 1:length(route_vehs.south)
        if veh_id == 1
            deltap_list = [deltap_list, last_index + 2];
            last_index = last_index + 4;

            if route_vehs.south(veh_id) == 1 || route_vehs.south(veh_id) == 2
                first_veh_route = "straight";
            elseif route_vehs.south(veh_id) == 3
                first_veh_route = "right";
            end
        elseif route_vehs.south(veh_id) == 1 || route_vehs.south(veh_id) == 2
            if strcmp(first_veh_route, "right")
                deltap_list = [deltap_list, last_index + 2];
                first_veh_route = "done";
                last_index = last_index + 7;
            else
                deltap_list = [deltap_list, last_index + 2];
                last_index = last_index + 9;
            end
        elseif route_vehs.south(veh_id) == 3
            if strcmp(first_veh_route, "straight")
                deltap_list = [deltap_list, last_index + 2];
                first_veh_route = "done";
                last_index = last_index + 7;
            else
                deltap_list = [deltap_list, last_index + 2];
                last_index = last_index + 9;
            end
        end
    end

    for veh_id = 1:length(route_vehs.east)
        if veh_id == 1
            deltap_list = [deltap_list, last_index + 2];
            last_index = last_index + 4;

            if route_vehs.east(veh_id) == 1 || route_vehs.east(veh_id) == 2
                first_veh_route = "straight";
            elseif route_vehs.east(veh_id) == 3
                first_veh_route = "right";
            end
        elseif route_vehs.east(veh_id) == 1 || route_vehs.east(veh_id) == 2
            if strcmp(first_veh_route, "right")
                deltap_list = [deltap_list, last_index + 2];
                first_veh_route = "done";
                last_index = last_index + 7;
            else
                deltap_list = [deltap_list, last_index + 2];
                last_index = last_index + 9;
            end
        elseif route_vehs.east(veh_id) == 3
            if strcmp(first_veh_route, "straight")
                deltap_list = [deltap_list, last_index + 2];
                first_veh_route = "done";
                last_index = last_index + 7;
            else
                deltap_list = [deltap_list, last_index + 2];
                last_index = last_index + 9;
            end
        end
    end

    for veh_id = 1:length(route_vehs.west)
        if veh_id == 1
            deltap_list = [deltap_list, last_index + 2];
            last_index = last_index + 4;

            if route_vehs.west(veh_id) == 1 || route_vehs.west(veh_id) == 2
                first_veh_route = "straight";
            elseif route_vehs.west(veh_id) == 3
                first_veh_route = "right";
            end
        elseif route_vehs.west(veh_id) == 1 || route_vehs.west(veh_id) == 2
            if strcmp(first_veh_route, "right")
                deltap_list = [deltap_list, last_index + 2];
                first_veh_route = "done";
                last_index = last_index + 7;
            else
                deltap_list = [deltap_list, last_index + 2];
                last_index = last_index + 9;
            end
        elseif route_vehs.west(veh_id) == 3
            if strcmp(first_veh_route, "straight")
                deltap_list = [deltap_list, last_index + 2];
                first_veh_route = "done";
                last_index = last_index + 7;
            else
                deltap_list = [deltap_list, last_index + 2];
                last_index = last_index + 9;
            end
        end
    end

    obj.variables_list_map("delta_p") = {deltap_list};
    

end