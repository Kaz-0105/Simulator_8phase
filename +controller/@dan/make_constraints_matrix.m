function make_constraints_matrix(obj, MLD_matrices, pos_vehs)

    % MLDの式を一つの不等式制約にまとめる

    % MLDの係数を取得
    A = MLD_matrices.A;
    B1 = MLD_matrices.B1;
    B2 = MLD_matrices.B2;
    B3 = MLD_matrices.B3;
    C = MLD_matrices.C;
    D1 = MLD_matrices.D1;
    D2 = MLD_matrices.D2;
    D3 = MLD_matrices.D3;
    E = MLD_matrices.E;

    % B1, B2, B3をまとめる
    B = [B1, B2, B3];

    % D1, D2, D3をまとめる
    D = [D1, D2, D3];

    % MLDの1ステップ分の決定変数の数を取得
    [~, col_num] = size(D);
    obj.v_num = col_num;

    % 交差点内の全ての自動車の位置情報をまとめる
    pos_vehs_all = [pos_vehs.north; pos_vehs.south; pos_vehs.east; pos_vehs.west];

    % ここから具体的な計算
    A_bar = kron(ones(obj.N_p, 1), A); % A_barの計算
    B_bar = kron(tril(ones(obj.N_p), -1), B); % B_barの計算
    C_bar = kron(eye(obj.N_p), C); % C_barの計算
    D_bar = kron(eye(obj.N_p), D); % D_barの計算
    E_bar = kron(ones(obj.N_p, 1), E); % E_barの計算

    % P、qに代入  
    obj.MILP_matrices.P = [obj.MILP_matrices.P; C_bar*B_bar - D_bar];
    obj.MILP_matrices.q = [obj.MILP_matrices.q; E_bar - C_bar*A_bar*pos_vehs_all];

    % 信号機制約を追加していく

    % 信号機の変数が増えた分の変数を追加
    [row_num, ~] = size(obj.MILP_matrices.P);
    obj.MILP_matrices.P = [obj.MILP_matrices.P, zeros(row_num, (obj.signal_num + 1)*(obj.N_p -1))];

    % 信号現示の変化のバイナリ変数を定義 
    [~, col_num] = size(obj.MILP_matrices.P);

    for step = 1:(obj.N_p-1)
        P_tmp = zeros(4*obj.signal_num, col_num);

        for signal_id = 1: obj.signal_num
            P_tmp((1 + 4*(signal_id -1): 4*signal_id), signal_id + obj.v_num*(step -1)) = [1;-1;-1;1];
            P_tmp((1 + 4*(signal_id -1): 4*signal_id), signal_id + obj.v_num*step) = [1;-1;1;-1];
            P_tmp((1 + 4*(signal_id -1): 4*signal_id), obj.v_num*obj.N_p + signal_id + (obj.signal_num + 1)*(step - 1)) = [1;1;-1;-1];
        end

        obj.MILP_matrices.P = [obj.MILP_matrices.P; P_tmp];

        q_tmp = zeros(4*obj.signal_num, 1);

        for signal_id = 1: obj.signal_num
            q_tmp(1 + 4*(signal_id -1),1) = 2;    
        end

        obj.MILP_matrices.q = [obj.MILP_matrices.q; q_tmp];
    end

    % 信号の変化の回数の制限

    P_tmp = zeros(1, col_num);
    for step = obj.fix_num:(obj.N_p-1)
        P_tmp(1, (obj.signal_num + 1)*step) = 1;
    end
    obj.MILP_matrices.P = [obj.MILP_matrices.P; P_tmp];

    if mod(obj.prediction_count, 3) == 0
        obj.MILP_matrices.q = [obj.MILP_matrices.q; 1];
    else
        obj.MILP_matrices.q = [obj.MILP_matrices.q; 0];
    end

    % delta_cの固定
    
    for veh_id = 1:length(obj.deltac_list)
        for step = 1:obj.N_p
            P_tmp = zeros(1, col_num);
            P_tmp(obj.deltac_list(veh_id) + obj.signal_num + obj.v_num*(step-1)) = 1;
            obj.MILP_matrices.Peq = [obj.MILP_matrices.Peq; P_tmp];

            q_tmp = 1;
            obj.MILP_matrices.qeq = [obj.MILP_matrices.qeq; q_tmp];
        end
    end
    

    % 信号機のマッチング
    
    for step = 1:obj.N_p
        P_tmp = zeros(5, col_num);
        P_tmp(:,1+obj.v_num*(step-1)) = [1;1;0;0;0];
        P_tmp(:,2+obj.v_num*(step-1)) = [1;0;1;0;0];
        P_tmp(:,3+obj.v_num*(step-1)) = [0;-1;0;0;0];
        P_tmp(:,4+obj.v_num*(step-1)) = [0;0;-1;0;0];
        P_tmp(:,5+obj.v_num*(step-1)) = [1;0;0;1;0];
        P_tmp(:,6+obj.v_num*(step-1)) = [1;0;0;0;1];
        P_tmp(:,7+obj.v_num*(step-1)) = [0;0;0;-1;0];
        P_tmp(:,8+obj.v_num*(step-1)) = [0;0;0;0;-1];

        obj.MILP_matrices.Peq = [obj.MILP_matrices.Peq; P_tmp];
        obj.MILP_matrices.qeq = [obj.MILP_matrices.qeq; [1;0;0;0;0]];
    end
    


    % 増えた変数の定義その２
    
    for step = 1:(obj.N_p-1)
        P_tmp = zeros(1, col_num);
        P_tmp(obj.v_num*obj.N_p + (obj.signal_num + 1)*(step -1) + 1 : obj.v_num*obj.N_p + (obj.signal_num + 1)*step) = [-1, -1, -1, -1, -1, -1, -1, -1, 4];
        obj.MILP_matrices.Peq = [obj.MILP_matrices.Peq; P_tmp];
        obj.MILP_matrices.qeq = [obj.MILP_matrices.qeq; 0];
    end
    

    % 初期値の固定
    
    for step = 1:obj.fix_num
        P_tmp = zeros(obj.signal_num, col_num);
        for signal_id = 1:8
            P_tmp(signal_id, signal_id + obj.v_num*(step -1)) = 1;
        end
        obj.MILP_matrices.Peq = [obj.MILP_matrices.Peq; P_tmp];

        u_data = obj.u_results.get_future_data();
        q_tmp = u_data(:, step);
        obj.MILP_matrices.qeq = [obj.MILP_matrices.qeq; q_tmp];
    end


end