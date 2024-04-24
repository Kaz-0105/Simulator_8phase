function make_B3_matrix(obj, route_vehs, first_veh_ids, road_prms)
    B3_r = []; % B3_rを初期化

    % 自動車が存在しない場合は何もしない
    if isempty(route_vehs)
        return;
    end

    % パラメータを取得
    num_veh = length(route_vehs); % 自動車台数

    D_s = road_prms.D_s; % 信号の影響圏に入る距離
    d_s = road_prms.d_s; % 信号と信号の停止線の間の距離
    D_f = road_prms.D_f; % 先行車の影響圏に入る距離
    d_f = road_prms.d_f; % 先行車と最接近したときの距離
    p_s = road_prms.p_s; % 信号の位置

    k_s = 1/(D_s - d_s); % モデルに登場する係数（その１）
    k_f = 1/(D_f - d_f); % モデルに登場する係数（その２）

    dt = obj.dt; % タイムステップ[s]
    v = road_prms.v; % 速度[m/s]

    % B2_rを計算
    if first_veh_ids.left == 1
        % IDが1の自動車が直進車線の先頭の場合
        for veh_id = 1:num_veh
            if veh_id == 1
                % IDが1の自動車の場合
                b3 = [0, 0, k_s*(p_s-d_s)-1, 1]*v*dt;
            elseif veh_id == first_veh_ids.right
                % 右折車線の先頭車（IDが１ではないかつ先頭車）の場合
                b3 = [0, 0, 0, 0, k_s*(p_s-d_s)-1, -k_f*d_f-1, 1]*v*dt;
            else
                % それ以外の場合
                b3 = [0, 0, 0, 0, 0, k_s*(p_s-d_s)-1, -k_f*d_f-1, -k_f*d_f-1, 1]*v*dt;
            end
            % B2_rに追加
            B3_r = blkdiag(B3_r, b3);
        end

    elseif first_veh_ids.right == 1
        % IDが1の自動車が右折車線の先頭の場合
        for veh_id = 1:num_veh
            if veh_id == 1
                % IDが1の自動車の場合
                b3 = [0, 0, k_s*(p_s-d_s)-1, 1]*v*dt;
            elseif veh_id == first_veh_ids.left
                % 直進車線の先頭車（IDが１ではないかつ先頭車）の場合
                b3 = [0, 0, 0, 0, k_s*(p_s-d_s)-1, -k_f*d_f-1, 1]*v*dt;
            else
                % それ以外の場合
                b3 = [0, 0, 0, 0, 0, k_s*(p_s-d_s)-1, -k_f*d_f-1, -k_f*d_f-1, 1]*v*dt;
            end
            B3_r = blkdiag(B3_r, b3);
        end
    end

    % B3に追加
    obj.MLD_matrices.B3 = blkdiag(obj.MLD_matrices.B3, B3_r);
end