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

    if isempty(pos_vehs.north)
        if isempty(pos_vehs.south)
            if isempty(pos_vehs.east)
                if isempty(pos_vehs.west)
                    return
                end
            end
        end
    end

    % Aの計算
    obj.make_A_matrix(pos_vehs.north);
    obj.make_A_matrix(pos_vehs.south);
    obj.make_A_matrix(pos_vehs.east);
    obj.make_A_matrix(pos_vehs.west);

    % B1の計算
    obj.make_B1_matrix(pos_vehs.north);
    obj.make_B1_matrix(pos_vehs.south);
    obj.make_B1_matrix(pos_vehs.east);
    obj.make_B1_matrix(pos_vehs.west);

    % B2の計算
    obj.make_B2_matrix(route_vehs.north, first_veh_ids.north, road_prms.north);
    obj.make_B2_matrix(route_vehs.south, first_veh_ids.south, road_prms.south);
    obj.make_B2_matrix(route_vehs.east, first_veh_ids.east, road_prms.east);
    obj.make_B2_matrix(route_vehs.west, first_veh_ids.west, road_prms.west);

    % B3の計算
    obj.make_B3_matrix(route_vehs.north, first_veh_ids.north, road_prms.north);
    obj.make_B3_matrix(route_vehs.south, first_veh_ids.south, road_prms.south);
    obj.make_B3_matrix(route_vehs.east, first_veh_ids.east, road_prms.east);
    obj.make_B3_matrix(route_vehs.west, first_veh_ids.west, road_prms.west);

    % Cの計算
    obj.make_C_matrix(route_vehs.north, first_veh_ids.north);
    obj.make_C_matrix(route_vehs.south, first_veh_ids.south);
    obj.make_C_matrix(route_vehs.east, first_veh_ids.east);
    obj.make_C_matrix(route_vehs.west, first_veh_ids.west);

    % D1の計算
    obj.make_D1_matrix(route_vehs.north, first_veh_ids.north, "north");
    obj.make_D1_matrix(route_vehs.south, first_veh_ids.south, "south");
    obj.make_D1_matrix(route_vehs.east, first_veh_ids.east, "east");
    obj.make_D1_matrix(route_vehs.west, first_veh_ids.west, "west");

    % D2の計算
    obj.make_D2_matrix(pos_vehs.north, first_veh_ids.north);
    obj.make_D2_matrix(pos_vehs.south, first_veh_ids.south);
    obj.make_D2_matrix(pos_vehs.east, first_veh_ids.east);
    obj.make_D2_matrix(pos_vehs.west, first_veh_ids.west);

    % D3の計算
    obj.make_D3_matrix(pos_vehs.north, first_veh_ids.north, road_prms.north);
    obj.make_D3_matrix(pos_vehs.south, first_veh_ids.south, road_prms.south);
    obj.make_D3_matrix(pos_vehs.east, first_veh_ids.east, road_prms.east);
    obj.make_D3_matrix(pos_vehs.west, first_veh_ids.west, road_prms.west);

    % Eの計算
    obj.make_E_matrix(pos_vehs.north, first_veh_ids.north, road_prms.north);
    obj.make_E_matrix(pos_vehs.south, first_veh_ids.south, road_prms.south);
    obj.make_E_matrix(pos_vehs.east, first_veh_ids.east, road_prms.east);
    obj.make_E_matrix(pos_vehs.west, first_veh_ids.west, road_prms.west);
end