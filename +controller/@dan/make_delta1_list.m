function make_delta1_list(obj)
    route_vehs = obj.route_vehs;
    last_index = 0;
    delta1_list = [];

    for veh_id = 1:length(route_vehs.north)
        if veh_id == 1
            delta1_list = [delta1_list, last_index + 4];
            last_index = last_index + 5;

            if route_vehs.north(veh_id) == 1 || route_vehs.north(veh_id) == 2
                first_veh_route = 's';
            elseif route_vehs.north(veh_id) == 3
                first_veh_route = 'r';
            end
        elseif route_vehs.north(veh_id) == 1 || route_vehs.north(veh_id) == 2
            if first_veh_route == 'r'
                delta1_list = [delta1_list, last_index + 8];
                first_veh_route = 'd';
                last_index = last_index + 10;
            else
                delta1_list = [delta1_list, last_index + 11];
                last_index = last_index + 14;
            end
        elseif route_vehs.north(veh_id) == 3
            if first_veh_route == 's'
                delta1_list = [delta1_list, last_index + 8];
                first_veh_route = 'd';
                last_index = last_index + 10;
            else
                delta1_list = [delta1_list, last_index + 11];
                last_index = last_index + 14;
            end
        end
    end

    for veh_id = 1:length(route_vehs.south)
        if veh_id == 1
            delta1_list = [delta1_list, last_index + 4];
            last_index = last_index + 5;

            if route_vehs.south(veh_id) == 1 || route_vehs.south(veh_id) == 2
                first_veh_route = 's';
            elseif route_vehs.south(veh_id) == 3
                first_veh_route = 'r';
            end
        elseif route_vehs.south(veh_id) == 1 || route_vehs.south(veh_id) == 2
            if first_veh_route == 'r'
                delta1_list = [delta1_list, last_index + 8];
                first_veh_route = 'd';
                last_index = last_index + 10;
            else
                delta1_list = [delta1_list, last_index + 11];
                last_index = last_index + 14;
            end
        elseif route_vehs.south(veh_id) == 3
            if first_veh_route == 's'
                delta1_list = [delta1_list, last_index + 8];
                first_veh_route = 'd';
                last_index = last_index + 10;
            else
                delta1_list = [delta1_list, last_index + 11];
                last_index = last_index + 14;
            end
        end
    end

    for veh_id = 1:length(route_vehs.east)
        if veh_id == 1
            delta1_list = [delta1_list, last_index + 4];
            last_index = last_index + 5;

            if route_vehs.east(veh_id) == 1 || route_vehs.east(veh_id) == 2
                first_veh_route = 's';
            elseif route_vehs.east(veh_id) == 3
                first_veh_route = 'r';
            end
        elseif route_vehs.east(veh_id) == 1 || route_vehs.east(veh_id) == 2
            if first_veh_route == 'r'
                delta1_list = [delta1_list, last_index + 8];
                first_veh_route = 'd';
                last_index = last_index + 10;
            else
                delta1_list = [delta1_list, last_index + 11];
                last_index = last_index + 14;
            end
        elseif route_vehs.east(veh_id) == 3
            if first_veh_route == 's'
                delta1_list = [delta1_list, last_index + 8];
                first_veh_route = 'd';
                last_index = last_index + 10;
            else
                delta1_list = [delta1_list, last_index + 11];
                last_index = last_index + 14;
            end
        end
    end

    for veh_id = 1:length(route_vehs.west)
        if veh_id == 1
            delta1_list = [delta1_list, last_index + 4];
            last_index = last_index + 5;

            if route_vehs.west(veh_id) == 1 || route_vehs.west(veh_id) == 2
                first_veh_route = 's';
            elseif route_vehs.west(veh_id) == 3
                first_veh_route = 'r';
            end
        elseif route_vehs.west(veh_id) == 1 || route_vehs.west(veh_id) == 2
            if first_veh_route == 'r'
                delta1_list = [delta1_list, last_index + 8];
                first_veh_route = 'd';
                last_index = last_index + 10;
            else
                delta1_list = [delta1_list, last_index + 11];
                last_index = last_index + 14;
            end
        elseif route_vehs.west(veh_id) == 3
            if first_veh_route == 's'
                delta1_list = [delta1_list, last_index + 8];
                first_veh_route = 'd';
                last_index = last_index + 10;
            else
                delta1_list = [delta1_list, last_index + 11];
                last_index = last_index + 14;
            end
        end
    end

    obj.delta1_list = delta1_list;


end