function make_D2_matrix(obj, pos_vehs, first_veh_ids)
    % D2_rを初期化
    D2_r = []; 

    % 自動車が存在しない場合は何もしない
    if isempty(pos_vehs)
        return;
    end

    % パラメータを取得
    num_veh = length(pos_vehs); % 自動車台数

    % D2_rを計算
    if first_veh_ids.straight == 1
        % 直進車線の先頭車の場合
        for veh_id = 1:num_veh
            if veh_id == 1
                % IDが1の自動車の場合
                % d2を初期化
                d2 = zeros(12, 1);

                % 非０要素を代入
                d2(9:12, 1) = [-1, 1, -1, 1]';
            elseif veh_id == first_veh_ids.right
                % 右折車線の先頭車（IDが１ではないかつ先頭車）の場合
                % d2を初期化
                d2 = zeros(28, 3);

                % 非０要素を代入
                d2(17:20, 1) = [-1, 1, -1, 1]';
                d2(21:24, 2) = [-1, 1, -1, 1]';
                d2(25:28, 3) = [-1, 1, -1, 1]';
            else
                % それ以外の場合
                % d2を初期化
                d2 = zeros(42, 5);

                % 非０要素を代入
                d2(23:26, 1) = [-1, 1, -1, 1]';
                d2(27:30, 2) = [-1, 1, -1, 1]';
                d2(31:34, 3) = [-1, 1, -1, 1]';
                d2(35:38, 4) = [-1, 1, -1, 1]';
                d2(39:42, 5) = [-1, 1, -1, 1]';
            end
            % D2_rに追加
            D2_r = blkdiag(D2_r, d2);
        end
    elseif first_veh_ids.right == 1
        % 右折車線の先頭車の場合
        for veh_id = 1:num_veh
            if veh_id == 1
                % IDが1の自動車の場合
                % d2を初期化
                d2 = zeros(12, 1);

                % 非０要素を代入
                d2(9:12, 1) = [-1, 1, -1, 1]';
            elseif veh_id == first_veh_ids.straight
                % 直進車線の先頭車（IDが１ではないかつ先頭車）の場合
                % d2を初期化
                d2 = zeros(28, 3);

                % 非０要素を代入
                d2(17:20, 1) = [-1, 1, -1, 1]';
                d2(21:24, 2) = [-1, 1, -1, 1]';
                d2(25:28, 3) = [-1, 1, -1, 1]';
            else
                % それ以外の場合
                % d2を初期化
                d2 = zeros(42, 5);

                % 非０要素を代入
                d2(23:26, 1) = [-1, 1, -1, 1]';
                d2(27:30, 2) = [-1, 1, -1, 1]';
                d2(31:34, 3) = [-1, 1, -1, 1]';
                d2(35:38, 4) = [-1, 1, -1, 1]';
                d2(39:42, 5) = [-1, 1, -1, 1]';
            end
            % D2_rに追加
            D2_r = blkdiag(D2_r, d2);
        end
    end

    % D2に追加
    obj.MLD_matrices.D2 = blkdiag(obj.MLD_matrices.D2, D2_r);
end