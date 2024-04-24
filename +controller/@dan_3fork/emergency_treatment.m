function emergency_treatment(obj)

    if isfield(obj.route_vehs, 'north')
        route_vehs_north = obj.route_vehs.north;
    end
    if isfield(obj.route_vehs, 'south')
        route_vehs_south = obj.route_vehs.south;
    end
    if isfield(obj.route_vehs, 'east')
        route_vehs_east = obj.route_vehs.east;
    end
    if isfield(obj.route_vehs, 'west')
        route_vehs_west = obj.route_vehs.west;
    end

    phases_struct = [];
    if ~isfield(obj.route_vehs, 'north')
        phases_struct.south_left = [1, 2, 4];
        phases_struct.south_right = [1];
        phases_struct.east_left = [1, 3, 4];
        phases_struct.east_right = [3];
        phases_struct.west_left = [2, 3, 4];
        phases_struct.west_right = [2];
    elseif ~isfield(obj.route_vehs, 'south')
        phases_struct.north_left = [1, 2, 4];
        phases_struct.north_right = [1];
        phases_struct.east_left = [2, 3, 4];
        phases_struct.east_right = [2];
        phases_struct.west_left = [1, 3, 4];
        phases_struct.west_right = [3];
    elseif ~isfield(obj.route_vehs, 'east')
        phases_struct.north_left = [2, 3, 4];
        phases_struct.north_right = [2];
        phases_struct.south_left = [1, 3, 4];
        phases_struct.south_right = [3];
        phases_struct.west_left = [1, 2, 4];
        phases_struct.west_right = [1];
    elseif ~isfield(obj.route_vehs, 'west')
        phases_struct.north_left = [1, 3, 4];
        phases_struct.north_right = [3];
        phases_struct.south_left = [2, 3, 4];
        phases_struct.south_right = [2];
        phases_struct.east_left = [1, 2, 4];
        phases_struct.east_right = [1];
    end
    
    num_vehs_struct = [];
    num_vehs_struct.phase_1 = 0;
    num_vehs_struct.phase_2 = 0;
    num_vehs_struct.phase_3 = 0;
    num_vehs_struct.phase_4 = 0;

    if isfield(obj.route_vehs, 'north')   
        if ~isempty(route_vehs_north)
            for veh_id = 1:length(route_vehs_north)
                if route_vehs_north(veh_id) == 1
                    for phase_id = phases_struct.north_left
                        if phase_id == 1
                            num_vehs_struct.phase_1 = num_vehs_struct.phase_1 + 1;
                        elseif phase_id == 2
                            num_vehs_struct.phase_2 = num_vehs_struct.phase_2 + 1;
                        elseif phase_id == 3
                            num_vehs_struct.phase_3 = num_vehs_struct.phase_3 + 1;
                        elseif phase_id == 4
                            num_vehs_struct.phase_4 = num_vehs_struct.phase_4 + 1;
                        end
                    end
                elseif route_vehs_north(veh_id) == 2
                    for phase_id = phases_struct.north_right
                        if phase_id == 1
                            num_vehs_struct.phase_1 = num_vehs_struct.phase_1 + 1;
                        elseif phase_id == 2
                            num_vehs_struct.phase_2 = num_vehs_struct.phase_2 + 1;
                        elseif phase_id == 3
                            num_vehs_struct.phase_3 = num_vehs_struct.phase_3 + 1;
                        elseif phase_id == 4
                            num_vehs_struct.phase_4 = num_vehs_struct.phase_4 + 1;
                        end
                    end
                end
            end
        end
    end

    if isfield(obj.route_vehs, 'south')   
        if ~isempty(route_vehs_south)
            for veh_id = 1:length(route_vehs_south)
                if route_vehs_south(veh_id) == 1
                    for phase_id = phases_struct.south_left
                        if phase_id == 1
                            num_vehs_struct.phase_1 = num_vehs_struct.phase_1 + 1;
                        elseif phase_id == 2
                            num_vehs_struct.phase_2 = num_vehs_struct.phase_2 + 1;
                        elseif phase_id == 3
                            num_vehs_struct.phase_3 = num_vehs_struct.phase_3 + 1;
                        elseif phase_id == 4
                            num_vehs_struct.phase_4 = num_vehs_struct.phase_4 + 1;
                        end
                    end
                elseif route_vehs_south(veh_id) == 2
                    for phase_id = phases_struct.south_right
                        if phase_id == 1
                            num_vehs_struct.phase_1 = num_vehs_struct.phase_1 + 1;
                        elseif phase_id == 2
                            num_vehs_struct.phase_2 = num_vehs_struct.phase_2 + 1;
                        elseif phase_id == 3
                            num_vehs_struct.phase_3 = num_vehs_struct.phase_3 + 1;
                        elseif phase_id == 4
                            num_vehs_struct.phase_4 = num_vehs_struct.phase_4 + 1;
                        end
                    end
                end
            end
        end
    end

    if isfield(obj.route_vehs, 'east')   
        if ~isempty(route_vehs_east)
            for veh_id = 1:length(route_vehs_east)
                if route_vehs_east(veh_id) == 1
                    for phase_id = phases_struct.east_left
                        if phase_id == 1
                            num_vehs_struct.phase_1 = num_vehs_struct.phase_1 + 1;
                        elseif phase_id == 2
                            num_vehs_struct.phase_2 = num_vehs_struct.phase_2 + 1;
                        elseif phase_id == 3
                            num_vehs_struct.phase_3 = num_vehs_struct.phase_3 + 1;
                        elseif phase_id == 4
                            num_vehs_struct.phase_4 = num_vehs_struct.phase_4 + 1;
                        end
                    end
                elseif route_vehs_east(veh_id) == 2
                    for phase_id = phases_struct.east_right
                        if phase_id == 1
                            num_vehs_struct.phase_1 = num_vehs_struct.phase_1 + 1;
                        elseif phase_id == 2
                            num_vehs_struct.phase_2 = num_vehs_struct.phase_2 + 1;
                        elseif phase_id == 3
                            num_vehs_struct.phase_3 = num_vehs_struct.phase_3 + 1;
                        elseif phase_id == 4
                            num_vehs_struct.phase_4 = num_vehs_struct.phase_4 + 1;
                        end
                    end
                end
            end
        end
    end

    if isfield(obj.route_vehs, 'west')   
        if ~isempty(route_vehs_west)
            for veh_id = 1:length(route_vehs_west)
                if route_vehs_west(veh_id) == 1
                    for phase_id = phases_struct.west_left
                        if phase_id == 1
                            num_vehs_struct.phase_1 = num_vehs_struct.phase_1 + 1;
                        elseif phase_id == 2
                            num_vehs_struct.phase_2 = num_vehs_struct.phase_2 + 1;
                        elseif phase_id == 3
                            num_vehs_struct.phase_3 = num_vehs_struct.phase_3 + 1;
                        elseif phase_id == 4
                            num_vehs_struct.phase_4 = num_vehs_struct.phase_4 + 1;
                        end
                    end
                elseif route_vehs_west(veh_id) == 2
                    for phase_id = phases_struct.west_right
                        if phase_id == 1
                            num_vehs_struct.phase_1 = num_vehs_struct.phase_1 + 1;
                        elseif phase_id == 2
                            num_vehs_struct.phase_2 = num_vehs_struct.phase_2 + 1;
                        elseif phase_id == 3
                            num_vehs_struct.phase_3 = num_vehs_struct.phase_3 + 1;
                        elseif phase_id == 4
                            num_vehs_struct.phase_4 = num_vehs_struct.phase_4 + 1;
                        end
                    end
                end
            end
        end
    end



    [~, phase_id] = max([num_vehs_struct.phase_1, num_vehs_struct.phase_2, num_vehs_struct.phase_3, num_vehs_struct.phase_4]);


    u_future_data = obj.u_results.get_future_data();
    obj.u_opt = u_future_data(:,1);

    if ~isfield(obj.route_vehs, 'north')
        if phase_id == 1
            tmp_u = [1; 1; 1; 0; 0; 0];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        elseif phase_id == 2
            tmp_u = [1; 0; 0; 0; 1; 1];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        elseif phase_id == 3
            tmp_u = [0; 0; 1; 1; 1; 0];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        elseif phase_id == 4
            tmp_u = [1; 0; 1; 0; 1; 0];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        end
    elseif ~isfield(obj.route_vehs, 'south')
        if phase_id == 1
            tmp_u = [1; 1; 0; 0; 1; 0];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        elseif phase_id == 2
            tmp_u = [1; 0; 1; 1; 0; 0];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        elseif phase_id == 3
            tmp_u = [0; 0; 1; 0; 1; 1];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        elseif phase_id == 4
            tmp_u = [1; 0; 1; 0; 1; 0];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        end
    elseif ~isfield(obj.route_vehs, 'east')
        if phase_id == 1
            tmp_u = [0; 0; 1; 0; 1; 1];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        elseif phase_id == 2
            tmp_u = [1; 1; 0; 0; 1; 0];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        elseif phase_id == 3
            tmp_u = [1; 0; 1; 1; 0; 0];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        elseif phase_id == 4
            tmp_u = [1; 0; 1; 0; 1; 0];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        end
    elseif ~isfield(obj.route_vehs, 'west')
        if phase_id == 1
            tmp_u = [1; 0; 0; 0; 1; 1];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        elseif phase_id == 2
            tmp_u = [0; 0; 1; 1; 1; 0];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        elseif phase_id == 3
            tmp_u = [1; 1; 1; 0; 0; 0];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        elseif phase_id == 4
            tmp_u = [1; 0; 1; 0; 1; 0];
            for step = 2: obj.N_p
                obj.u_opt = [obj.u_opt, tmp_u];
            end
        end
    end

    obj.phi_opt = zeros(1, obj.N_p-1);

    




end