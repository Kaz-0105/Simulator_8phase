function make_D3_matrix(obj, pos_vehs, first_veh_ids, road_prms)
    % D3_rを初期化
    D3_r = []; 

    % 自動車が存在しない場合は何もしない
    if isempty(pos_vehs)
        return;
    end

    % パラメータを取得
    num_veh = length(pos_vehs); % 自動車台数

    D_s = road_prms.D_s; % 信号の影響圏に入る距離
    d_s = road_prms.d_s; % 信号と信号の停止線の間の距離
    D_f = road_prms.D_f; % 先行車の影響圏に入る距離
    D_b = road_prms.D_b; % 車線の分岐点と信号の間の距離
    p_s = road_prms.p_s; % 信号の位置

    v = road_prms.v; % 速度[m/s]
    dt = obj.dt; % タイムステップ[s]
    N_p = obj.N_p; % 予測ホライゾン
    epsilon = obj.eps; % 微小量

    % 自動車の位置を評価
    p_min = pos_vehs(end);
    p_max = pos_vehs(1) + v*dt*N_p;

    % hiの評価
    h1_min = p_s-p_max-D_s;
    h1_max = p_s-p_min-D_s;
    h2_min = p_min-p_s+d_s;
    h2_max = p_max-p_s+d_s;
    h3_min = D_f-p_max+p_min;
    h3_max = D_f-p_min+p_max;
    h4_min = D_f-p_max+p_min;
    h4_max = D_f-p_min+p_max;
    h5_min = p_s-p_max-D_b;
    h5_max = p_s-p_min-D_b;

    % D3_rを計算

    if first_veh_ids.straight == 1
        % IDが1の自動車が直進車線の先頭の場合
        for veh_id = 1:num_veh
            if veh_id == 1
                % IDが1の自動車の場合
                % d3を初期化
                d3 = zeros(12, 4);

                % 非０要素を代入
                d3(1, [1, 2, 3]) = [-1, -1, -1];
                d3(2, [1, 2, 3]) = [0, 0, 1];
                d3(3, [1, 2, 3]) = [1, 0, 1];
                d3(4, [1, 2, 3]) = [0, 1, 1];

                d3(5, 1) = -h1_min;
                d3(6, 1) = -h1_max-epsilon;

                d3(7, 2) = -h2_min;
                d3(8, 2) = -h2_max-epsilon;

                d3(9, 3) = p_min;
                d3(10, 3) = -p_max;
                d3(11, 3) = p_max;
                d3(12, 3) = -p_min;


            elseif veh_id == first_veh_ids.right
                % 右折車線の先頭車（IDが１ではないかつ先頭車）の場合
                % d3を初期化
                d3 = zeros(28, 7);

                % 非０要素を代入
                d3(1, [1, 2, 5]) = [-1, -1, -1];
                d3(2, [1, 2, 5]) = [0, 0, 1];
                d3(3, [1, 2, 5]) = [1, 0, 1];
                d3(4, [1, 2, 5]) = [0, 1, 1];

                d3(5, [3, 4, 5, 6]) = [1, 1, -1, -1];
                d3(6, [3, 4, 5, 6]) = [0, 0, 1, 1];
                d3(7, [3, 4, 5, 6]) = [-1, 0, 0, 1];
                d3(8, [3, 4, 5, 6]) = [0, -1, 0, 1];

                d3(9, 1) = -h1_min;
                d3(10, 1) = -h1_max-epsilon;

                d3(11, 2) = -h2_min;
                d3(12, 2) = -h2_max-epsilon;

                d3(13, 3) = -h3_min;
                d3(14, 3) = -h3_max-epsilon;

                d3(15, 4) = -h5_min;
                d3(16, 4) = -h5_max-epsilon;

                d3(17, 5) = p_min;
                d3(18, 5) = -p_max;
                d3(19, 5) = p_max;
                d3(20, 5) = -p_min;

                d3(21, 6) = p_min;
                d3(22, 6) = -p_max;
                d3(23, 6) = p_max;
                d3(24, 6) = -p_min;

                d3(25, 6) = p_min;
                d3(26, 6) = -p_max;
                d3(27, 6) = p_max;
                d3(28, 6) = -p_min;
                
            else
                % それ以外の場合
                % d3を初期化
                d3 = zeros(42, 9);

                % 非０要素を代入
                d3(1, [1, 2, 6]) = [-1, -1, -1];
                d3(2, [1, 2, 6]) = [0, 0, 1];
                d3(3, [1, 2, 6]) = [1, 0, 1];
                d3(4, [1, 2, 6]) = [0, 1, 1];
            end
        end
    elseif first_veh_ids.right == 1
    end
                