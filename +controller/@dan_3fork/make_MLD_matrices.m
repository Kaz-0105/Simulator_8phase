function make_MLD_matrices(obj)
    pos_vehs = obj.pos_vehs;
    route_vehs = obj.route_vehs;
    first_veh_ids = obj.first_veh_ids;
    road_prms = obj.road_prms;

    obj.MLD_matrices.A = [];
    obj.MLD_matrices.B1 = [];
    obj.MLD_matrices.B2 = [];
    obj.MLD_matrices.B3 = [];
    obj.MLD_matrices.C = [];
    obj.MLD_matrices.D1 = [];
    obj.MLD_matrices.D2 = [];
    obj.MLD_matrices.D3 = [];
    obj.MLD_matrices.E = [];

    if ~isfield(pos_vehs, 'north')
        if isempty(pos_vehs.south)
            if isempty(pos_vehs.east)
                if isempty(pos_vehs.west)
                    return;
                end
            end
        end
    end

    if ~isfield(pos_vehs, 'south')
        if isempty(pos_vehs.north)
            if isempty(pos_vehs.east)
                if isempty(pos_vehs.west)
                    return;
                end
            end
        end
    end


    if ~isfield(pos_vehs, 'east')
        if isempty(pos_vehs.north)
            if isempty(pos_vehs.south)
                if isempty(pos_vehs.west)
                    return;
                end
            end
        end
    end

    if ~isfield(pos_vehs, 'west')
        if isempty(pos_vehs.north)
            if isempty(pos_vehs.south)
                if isempty(pos_vehs.east)
                    return;
                end
            end
        end
    end

    % Aの計算
    if isfield(pos_vehs, 'north')
        obj.make_A_matrix(pos_vehs.north);
    end
    if isfield(pos_vehs, 'south')
        obj.make_A_matrix(pos_vehs.south);
    end
    if isfield(pos_vehs, 'east')
        obj.make_A_matrix(pos_vehs.east);
    end
    if isfield(pos_vehs, 'west')
        obj.make_A_matrix(pos_vehs.west);
    end

    % B1の計算
    if isfield(pos_vehs, 'north')
        obj.make_B1_matrix(pos_vehs.north);
    end
    if isfield(pos_vehs, 'south')
        obj.make_B1_matrix(pos_vehs.south);
    end
    if isfield(pos_vehs, 'east')
        obj.make_B1_matrix(pos_vehs.east);
    end
    if isfield(pos_vehs, 'west')
        obj.make_B1_matrix(pos_vehs.west);
    end

    % B2の計算
    if isfield(route_vehs, 'north')
        obj.make_B2_matrix(route_vehs.north, first_veh_ids.north, road_prms.north);
    end
    if isfield(route_vehs, 'south')
        obj.make_B2_matrix(route_vehs.south, first_veh_ids.south, road_prms.south);
    end
    if isfield(route_vehs, 'east')
        obj.make_B2_matrix(route_vehs.east, first_veh_ids.east, road_prms.east);
    end
    if isfield(route_vehs, 'west')
        obj.make_B2_matrix(route_vehs.west, first_veh_ids.west, road_prms.west);
    end


    % B3の計算
    if isfield(route_vehs, 'north')
        obj.make_B3_matrix(route_vehs.north, first_veh_ids.north, road_prms.north);
    end
    if isfield(route_vehs, 'south')
        obj.make_B3_matrix(route_vehs.south, first_veh_ids.south, road_prms.south);
    end
    if isfield(route_vehs, 'east')
        obj.make_B3_matrix(route_vehs.east, first_veh_ids.east, road_prms.east);
    end
    if isfield(route_vehs, 'west')
        obj.make_B3_matrix(route_vehs.west, first_veh_ids.west, road_prms.west);
    end

    % Cの計算
    if isfield(route_vehs, 'north')
        obj.make_C_matrix(route_vehs.north, first_veh_ids.north);
    end
    if isfield(route_vehs, 'south')
        obj.make_C_matrix(route_vehs.south, first_veh_ids.south);
    end
    if isfield(route_vehs, 'east')
        obj.make_C_matrix(route_vehs.east, first_veh_ids.east);
    end
    if isfield(route_vehs, 'west')
        obj.make_C_matrix(route_vehs.west, first_veh_ids.west);
    end

    % D1の計算
    if isfield(route_vehs, 'north')
        obj.make_D1_matrix(route_vehs.north, first_veh_ids.north, "north");
    end
    if isfield(route_vehs, 'south')
        obj.make_D1_matrix(route_vehs.south, first_veh_ids.south, "south");
    end
    if isfield(route_vehs, 'east')
        obj.make_D1_matrix(route_vehs.east, first_veh_ids.east, "east");
    end
    if isfield(route_vehs, 'west')
        obj.make_D1_matrix(route_vehs.west, first_veh_ids.west, "west");
    end

    % D2の計算
    if isfield(pos_vehs, 'north')
        obj.make_D2_matrix(pos_vehs.north, first_veh_ids.north);
    end
    if isfield(pos_vehs, 'south')
        obj.make_D2_matrix(pos_vehs.south, first_veh_ids.south);
    end
    if isfield(pos_vehs, 'east')
        obj.make_D2_matrix(pos_vehs.east, first_veh_ids.east);
    end
    if isfield(pos_vehs, 'west')
        obj.make_D2_matrix(pos_vehs.west, first_veh_ids.west);
    end

    % D3の計算
    if isfield(pos_vehs, 'north')
        obj.make_D3_matrix(pos_vehs.north, first_veh_ids.north, road_prms.north);
    end
    if isfield(pos_vehs, 'south')
        obj.make_D3_matrix(pos_vehs.south, first_veh_ids.south, road_prms.south);
    end
    if isfield(pos_vehs, 'east')
        obj.make_D3_matrix(pos_vehs.east, first_veh_ids.east, road_prms.east);
    end
    if isfield(pos_vehs, 'west')
        obj.make_D3_matrix(pos_vehs.west, first_veh_ids.west, road_prms.west);
    end

    % Eの計算
    if isfield(pos_vehs, 'north')
        obj.make_E_matrix(pos_vehs.north, first_veh_ids.north, road_prms.north);
    end
    if isfield(pos_vehs, 'south')
        obj.make_E_matrix(pos_vehs.south, first_veh_ids.south, road_prms.south);
    end
    if isfield(pos_vehs, 'east')
        obj.make_E_matrix(pos_vehs.east, first_veh_ids.east, road_prms.east);
    end
    if isfield(pos_vehs, 'west')
        obj.make_E_matrix(pos_vehs.west, first_veh_ids.west, road_prms.west);
    end
end