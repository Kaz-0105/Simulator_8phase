% D1行列を作成する関数
function make_D1_matrix(obj, route_vehs, first_veh_ids, direction)

    % D1_rを初期化
    D1_r = [];

    % 自動車が存在しない場合は何もしない
    if isempty(route_vehs)
        return;
    end

    % 

    % 方向と対応する信号のバイナリのIDを取得
    if ~isfield(route_vehs, "north")
        if strcmp(direction,"south")
            signal_id = [1, 2];
        elseif strcmp(direction,"east")
            signal_id = [3, 4];
        elseif strcmp(direction,"west")
            signal_id = [5, 6];
        end
    elseif ~isfield(route_vehs, "south")
        if strcmp(direction,"north")
            signal_id = [1, 2];
        elseif strcmp(direction,"east")
            signal_id = [3, 4];
        elseif strcmp(direction,"west")
            signal_id = [5, 6];
        end
    elseif ~isfield(route_vehs, "east")
        if strcmp(direction,"north")
            signal_id = [1, 2];
        elseif strcmp(direction,"south")
            signal_id = [3, 4];
        elseif strcmp(direction,"west")
            signal_id = [5, 6];
        end
    elseif ~isfield(route_vehs, "west")
        if strcmp(direction,"north")
            signal_id = [1, 2];
        elseif strcmp(direction,"south")
            signal_id = [3, 4];
        elseif strcmp(direction,"east")
            signal_id = [5, 6];
        end
    end

    % パラメータを取得
    num_veh = length(route_vehs); % 自動車台数

    % D1_rを計算
    if first_veh_ids.left == 1
        % IDが1の自動車が直進車線の先頭の場合
        for veh_id = 1: num_veh
            if veh_id == 1
                % IDが1の自動車の場合
                d1 = zeros(12, 6);
                d1(1:2,signal_id(1)) = [-1;1]; 

            elseif veh_id == first_veh_ids.right
                % 右折車線の先頭車（IDが１ではないかつ先頭車）の場合
                d1 = zeros(28,6);
                d1(1:2,signal_id(2)) = [-1;1];

            else
                % それ以外の場合
                d1 = zeros(42,6);
                if route_vehs(veh_id) == 1 
                    d1(1:2,signal_id(1)) = [-1;1];
                elseif route_vehs(veh_id) == 2
                    d1(1:2,signal_id(2)) = [-1;1];
                end
            end
            % D1_rに追加
            D1_r = [D1_r;d1];
        end

    elseif first_veh_ids.right == 1
        % IDが1の自動車が右折車線の先頭の場合
        for veh_id = 1: num_veh
            if veh_id == 1
                % IDが1の自動車の場合
                d1 = zeros(12, 6);
                d1(1:2,signal_id(2)) = [-1;1]; 
                
            elseif veh_id == first_veh_ids.left
                % 直進車線の先頭車（IDが１ではないかつ先頭車）の場合
                d1 = zeros(28,6);
                d1(1:2,signal_id(1)) = [-1;1];

            else
                % それ以外の場合
                d1 = zeros(42,6);
                if route_vehs(veh_id) == 1 
                    d1(1:2,signal_id(1)) = [-1;1];
                elseif route_vehs(veh_id) == 2
                    d1(1:2,signal_id(2)) = [-1;1];
                end
            end
            % D1_rに追加
            D1_r = [D1_r;d1];
        end
    end
    
    % D1に追加
    obj.MLD_matrices.D1 = [obj.MLD_matrices.D1; D1_r];
end
