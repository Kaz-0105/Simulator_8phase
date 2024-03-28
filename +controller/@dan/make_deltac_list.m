function make_deltac_list(obj)
    route_vehs = obj.route_vehs;
    last_index = 0;
    deltac_list = [];

    for veh_id = 1:length(route_vehs.north)
        if veh_id == 1
            deltac_list = [deltac_list, last_index + 5];
            last_index = last_index + 5;

            if route_vehs.north(veh_id) == 1 || route_vehs.north(veh_id) == 2
                first_veh_route = "straight";
            elseif route_vehs.north(veh_id) == 3
                first_veh_route = "right";
            end
        elseif route_vehs.north(veh_id) == 1 || route_vehs.north(veh_id) == 2
            if strcmp(first_veh_route, "right")
                deltac_list = [deltac_list, last_index + 10];
                first_veh_route = "done";
                last_index = last_index + 10;
            else
                deltac_list = [deltac_list, last_index + 14];
                last_index = last_index + 14;
            end
        elseif route_vehs.north(veh_id) == 3
            if strcmp(first_veh_route, "straight")
                deltac_list = [deltac_list, last_index + 10];
                first_veh_route = "done";
                last_index = last_index + 10;
            else
                deltac_list = [deltac_list, last_index + 14];
                last_index = last_index + 14;
            end
        end
    end

    for veh_id = 1:length(route_vehs.south)
        if veh_id == 1
            deltac_list = [deltac_list, last_index + 5];
            last_index = last_index + 5;

            if route_vehs.south(veh_id) == 1 || route_vehs.south(veh_id) == 2
                first_veh_route = "straight";
            elseif route_vehs.south(veh_id) == 3
                first_veh_route = "right";
            end
        elseif route_vehs.south(veh_id) == 1 || route_vehs.south(veh_id) == 2
            if strcmp(first_veh_route, "right")
                deltac_list = [deltac_list, last_index + 10];
                first_veh_route = "done";
                last_index = last_index + 10;
            else
                deltac_list = [deltac_list, last_index + 14];
                last_index = last_index + 14;
            end
        elseif route_vehs.south(veh_id) == 3
            if strcmp(first_veh_route, "straight")
                deltac_list = [deltac_list, last_index + 10];
                first_veh_route = "done";
                last_index = last_index + 10;
            else
                deltac_list = [deltac_list, last_index + 14];
                last_index = last_index + 14;
            end
        end
    end

    for veh_id = 1:length(route_vehs.east)
        if veh_id == 1
            deltac_list = [deltac_list, last_index + 5];
            last_index = last_index + 5;

            if route_vehs.east(veh_id) == 1 || route_vehs.east(veh_id) == 2
                first_veh_route = "straight";
            elseif route_vehs.east(veh_id) == 3
                first_veh_route = "right";
            end
        elseif route_vehs.east(veh_id) == 1 || route_vehs.east(veh_id) == 2
            if strcmp(first_veh_route, "right")
                deltac_list = [deltac_list, last_index + 10];
                first_veh_route = "done";
                last_index = last_index + 10;
            else
                deltac_list = [deltac_list, last_index + 14];
                last_index = last_index + 14;
            end
        elseif route_vehs.east(veh_id) == 3
            if strcmp(first_veh_route, "straight")
                deltac_list = [deltac_list, last_index + 10];
                first_veh_route = "done";
                last_index = last_index + 10;
            else
                deltac_list = [deltac_list, last_index + 14];
                last_index = last_index + 14;
            end
        end
    end

    for veh_id = 1:length(route_vehs.west)
        if veh_id == 1
            deltac_list = [deltac_list, last_index + 5];
            last_index = last_index + 5;

            if route_vehs.west(veh_id) == 1 || route_vehs.west(veh_id) == 2
                first_veh_route = "straight";
            elseif route_vehs.west(veh_id) == 3
                first_veh_route = "right";
            end
        elseif route_vehs.west(veh_id) == 1 || route_vehs.west(veh_id) == 2
            if strcmp(first_veh_route, "right")
                deltac_list = [deltac_list, last_index + 10];
                first_veh_route = "done";
                last_index = last_index + 10;
            else
                deltac_list = [deltac_list, last_index + 14];
                last_index = last_index + 14;
            end
        elseif route_vehs.west(veh_id) == 3
            if strcmp(first_veh_route, "straight")
                deltac_list = [deltac_list, last_index + 10];
                first_veh_route = "done";
                last_index = last_index + 10;
            else
                deltac_list = [deltac_list, last_index + 14];
                last_index = last_index + 14;
            end
        end
    end

    obj.variables_list_map("delta_c") = {deltac_list};


end