function make_C_matrix(obj, route_vehs, first_veh_ids)
    C_r = []; % C_rを初期化

    % 自動車が存在しない場合は何もしない
    if isempty(route_vehs)
        return;
    end

    % パラメータを取得
    num_veh = length(route_vehs); % 自動車台数

    if first_veh_ids.straight == 1
        % IDが1の自動車が直進車線の先頭の場合
        for veh_id = 1:num_veh
            if veh_id == 1
                % IDが1の自動車の場合
                % cの初期化
                c = zeros(12, num_veh); 

                % 係数が0ではない要素に値を代入
                c(5:6, veh_id) = [1; -1];
                c(7:8, veh_id) = [-1; 1];
                c(11:12, veh_id) = [1; -1];

            elseif veh_id == first_veh_ids.right
                % 右折車線の先頭車（IDが１ではないかつ先頭車）の場合
                % cの初期化
                c = zeros(28, num_veh);

                % 係数が0ではない要素に値を代入
                c(9:10,veh_id) = [1;-1];                     
                c(11:12,veh_id) = [-1;1];
                c(13:14,(veh_id-1):veh_id) = [1,-1;-1,1];
                c(15:16,veh_id) = [1;-1];
                c(19:20,veh_id) = [1;-1];                    
                c(23:24,veh_id-1) = [1;-1]; 
                c(27:28,veh_id) = [1;-1];
            else
                % それ以外の場合
                % cの初期化
                c = zeros(42, num_veh);

                % 車線分岐後の先行車のIDを取得
                front_veh_id = controller.dan_8phase.get_front_veh_id(veh_id, route_vehs);

                % 係数が0ではない要素に値を代入
                c(13:22,veh_id) = [1;-1;-1;1;-1;1;-1;1;1;-1]; 
                c(17:18,veh_id-1) = [1;-1];
                c(19:20,front_veh_id) = [1;-1];
                c(25:26,veh_id) = [1;-1];
                c(29:30,veh_id-1) = [1;-1];                  
                c(33:34,veh_id) = [1;-1];
                c(37:38,front_veh_id) = [1;-1];
                c(41:42,veh_id) = [1;-1];
            end

            % C_rに追加
            C_r = [C_r; c];
        end
    elseif first_veh_ids.right == 1
        % IDが1の自動車が右折車線の先頭の場合
        for veh_id = 1:num_veh
            if veh_id == 1
                % IDが1の自動車の場合
                % cの初期化
                c = zeros(12, num_veh); 

                % 係数が0ではない要素に値を代入
                c(5:6, veh_id) = [1; -1];
                c(7:8, veh_id) = [-1; 1];
                c(11:12, veh_id) = [1; -1];

            elseif veh_id == first_veh_ids.straight
                % 直進車線の先頭車（IDが１ではないかつ先頭車）の場合
                % cの初期化
                c = zeros(28, num_veh);

                % 係数が0ではない要素に値を代入
                c(9:10,veh_id) = [1;-1];                     
                c(11:12,veh_id) = [-1;1];
                c(13:14,(veh_id-1):veh_id) = [1,-1;-1,1];
                c(15:16,veh_id) = [1;-1];
                c(19:20,veh_id) = [1;-1];                    
                c(23:24,veh_id-1) = [1;-1]; 
                c(27:28,veh_id) = [1;-1];
            else
                % それ以外の場合
                % cの初期化
                c = zeros(42, num_veh);

                % 車線分岐後の先行車のIDを取得
                front_veh_id = controller.dan_8phase.get_front_veh_id(veh_id, route_vehs);

                % 係数が0ではない要素に値を代入
                c(13:22,veh_id) = [1;-1;-1;1;-1;1;-1;1;1;-1];
                c(17:18,veh_id-1) = [1;-1];
                c(19:20,front_veh_id) = [1;-1];
                c(25:26,veh_id) = [1;-1];
                c(29:30,veh_id-1) = [1;-1];
                c(33:34,veh_id) = [1;-1];
                c(37:38,front_veh_id) = [1;-1];
                c(41:42,veh_id) = [1;-1];
            end

            % C_rに追加
            C_r = [C_r; c];
        end
    end

    obj.MLD_matrices.C = blkdiag(obj.MLD_matrices.C, C_r);
end