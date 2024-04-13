function make_vehs_data(obj, intersection_struct_map, vis_data)

    % vis_dataからroad_vehs_mapとroad_first_veh_mapを取得
    % road_vehs_mapはキー：道路ID、値：その道路上の自動車の位置と進路をまとめた配列
    % road_first_veh_mapはキー：道路ID、値：その道路上の先頭の自動車のID

    road_vehs_map = vis_data.get_road_vehs_map();
    road_first_veh_map = vis_data.get_road_first_veh_map();

    % intersection構造体を取得
    intersection_struct = intersection_struct_map(obj.id);

    % 東西南北それぞれの道路の情報をまとめる
    for irid = intersection_struct.input_road_ids
        % road_vehs_mapから注目している流入道路に対応するデータを取得
        vehs_data = road_vehs_map(irid);
        vehs_data = vehs_data{1}; % cell型から取り出す処理

        if strcmp(intersection_struct.input_road_directions(irid), "north")
            if ~isempty(vehs_data)
                % 自動車が存在する場合
                obj.pos_vehs.north = vehs_data(:,1); % 1列目は位置のデータなのでpos_vehsに格納
                obj.route_vehs.north = vehs_data(:,2); % 2列目は進路のデータなのでroute_vehsに格納
            else
                % 自動車が存在しない場合は空の配列とする
                obj.pos_vehs.north = []; 
                obj.route_vehs.north = [];
            end

            % その道路の先頭車のIDをfirst_veh_idsに格納（直進車線と右折車線で2台分ある）
            obj.first_veh_ids.north = road_first_veh_map(irid);

        elseif strcmp(intersection_struct.input_road_directions(irid), "south")
            if ~isempty(vehs_data)
                obj.pos_vehs.south = vehs_data(:,1);
                obj.route_vehs.south = vehs_data(:,2);
            else
                obj.pos_vehs.south = [];
                obj.route_vehs.south = [];
            end

            obj.first_veh_ids.south = road_first_veh_map(irid);

        elseif strcmp(intersection_struct.input_road_directions(irid), "east")
            if ~isempty(vehs_data)
                obj.pos_vehs.east = vehs_data(:,1);
                obj.route_vehs.east = vehs_data(:,2);
            else
                obj.pos_vehs.east = [];
                obj.route_vehs.east = [];
            end

            obj.first_veh_ids.east = road_first_veh_map(irid);

        elseif strcmp(intersection_struct.input_road_directions(irid), "west")
            if ~isempty(vehs_data)
                obj.pos_vehs.west = vehs_data(:,1);
                obj.route_vehs.west = vehs_data(:,2);
            else
                obj.pos_vehs.west = [];
                obj.route_vehs.west = [];
            end

            obj.first_veh_ids.west = road_first_veh_map(irid);
        end

    end

    % num_vehsを計算
    obj.num_vehs.north = length(obj.pos_vehs.north);
    obj.num_vehs.south = length(obj.pos_vehs.south);
    obj.num_vehs.east = length(obj.pos_vehs.east);
    obj.num_vehs.west = length(obj.pos_vehs.west);
    
end