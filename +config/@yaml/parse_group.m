function group = parse_group(roads_file, intersections_file)
    group = [];
    roads_data = yaml.loadFile(roads_file);
    intersections_data = yaml.loadFile(intersections_file);

    % エリアのidを取得
    group.id = roads_data.id;

    % エリアの道路の情報を取得
    group.roads = {};

    for road_data = roads_data.roads
        road_data = road_data{1};
        tmp_road = [];

        % 道路のIDを取得
        tmp_road.id = road_data.id;

        % 道路を構成するリンクのIDを取得
        tmp_road.link_ids = [];
        
        for link_id = road_data.v_ids
            tmp_road.link_ids(end + 1) = link_id{1};
        end

        % 道路を構成するリンクのうち直進車線のメインのリンクのIDを取得
        tmp_road.main_link_id = road_data.v_mid;

        % Signal Controller（1つの交差点の信号機をまとめたグループのこと）のIDを取得
        if isfield(road_data, 'v_sc')
            tmp_road.signal_controller_id = road_data.v_sc;
        end

        % Signal Group（1つの交差点で挙動ごとに信号機を分けたグループのこと）のIDを取得
        if isfield(road_data, 'v_sg')
            tmp_road.signal_group = {};

            for signal_group = road_data.v_sg
                tmp_signal_group = [];
                signal_group = signal_group{1};
                tmp_signal_group.id = signal_group.id;
                tmp_signal_group.dirct = signal_group.dirct;
                tmp_road.signal_group{end + 1} = tmp_signal_group;
            end
        end


        % 進路の割合を取得
        if isfield(road_data, 'v_rfs')
            tmp_road.rel_flows = {};

            for rel_flow = road_data.v_rfs
                tmp_rel_flow = [];
                rel_flow = rel_flow{1};
                tmp_rel_flow.id = rel_flow.id;
                tmp_rel_flow.rf = rel_flow.rf;
                tmp_rel_flow.dirct = rel_flow.dirct;
                tmp_road.rel_flows{end + 1} = tmp_rel_flow;
            end
        end

        % 自動車の流入量を取得
        if isfield(road_data, 'input')
            tmp_road.input = road_data.input;
        end

        % sig_head_idを取得
        if isfield(road_data, 'sig_head_ids')
            tmp_sig_head_ids = [];
            for sig_head_id = road_data.sig_head_ids
                sig_head_id = sig_head_id{1};
                tmp_sig_head_ids(end + 1) = sig_head_id;
            end
            tmp_road.sig_head_ids = tmp_sig_head_ids;
        end

        % 自動車の速度を取得
        if isfield(road_data, 'speed')
            tmp_road.speed = road_data.speed;
        else
            tmp_road.speed = 60;
        end

        group.roads{end + 1} = tmp_road;
    end

    % エリア内の交差点の情報を取得
    group.intersections = {};

    for intersection_data = intersections_data.intersections
        intersection_data = intersection_data{1};
        tmp_intersection = [];

        % 交差点のIDを取得
        tmp_intersection.id = intersection_data.id;

        % 流入側の道路のリストとその方角を取得
        tmp_intersection.input_road_ids = [];
        tmp_intersection.input_road_directions = dictionary(int32.empty, string.empty);

        irids = intersection_data.irids;
        ir_directions = intersection_data.ir_directions;

        for i = 1: length(irids)
            input_road_id = irids{i};
            input_road_direction = ir_directions{i};
            
            tmp_intersection.input_road_ids(end + 1) = input_road_id;
            tmp_intersection.input_road_directions(input_road_id) = input_road_direction; 
        end

        % 流出側の道路のリストを取得
        tmp_intersection.output_road_ids = [];

        for output_road_id = intersection_data.orids
            tmp_intersection.output_road_ids(end + 1) = output_road_id{1};
        end

        % フェーズ分けのリストを取得
        %{
        tmp_intersection.phases = {};

        for phase = intersection_data.phs
            tmp_phase = [];
            phase = phase{1};

            % フェーズのIDを取得
            tmp_phase.id = phase.id;

            % そのフェーズに青になる道路のIDを取得
            tmp_phase.road_ids = [];

            for road_id = phase.road_ids
                tmp_phase.road_ids(end + 1) = road_id{1};
            end

            % そのフェーズのタイプを取得（シンメトリックかスタンダードか）
            tmp_phase.type = phase.type;

            tmp_intersection.phases{end + 1} = tmp_phase;
        end
        %}

        group.intersections{end + 1} = tmp_intersection;
    end


end

