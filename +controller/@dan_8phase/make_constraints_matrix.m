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
    [~, obj.v_num] = size(D);

    % 交差点内の全ての自動車の位置情報をまとめる
    pos_vehs_all = [pos_vehs.north; pos_vehs.south; pos_vehs.east; pos_vehs.west];

    % ここから具体的な計算
    A_bar = kron(ones(obj.N_p, 1), A); % A_barの計算
    B_bar = kron(tril(ones(obj.N_p), -1), B); % B_barの計算
    C_bar = kron(eye(obj.N_p), C); % C_barの計算
    D_bar = kron(eye(obj.N_p), D); % D_barの計算
    E_bar = kron(ones(obj.N_p, 1), E); % E_barの計算

    % P、qに代入  
    obj.MILP_matrices.P = [obj.MILP_matrices.P; C_bar*B_bar + D_bar];
    obj.MILP_matrices.q = [obj.MILP_matrices.q; E_bar - C_bar*A_bar*pos_vehs_all];

    % 信号機制約を追加していく

    % 信号機の変数が増えた分の変数を追加
    [row_num, ~] = size(obj.MILP_matrices.P);
    obj.MILP_matrices.P = [obj.MILP_matrices.P, zeros(row_num, obj.phase_num*obj.N_p + (obj.phase_num + 1)*(obj.N_p-1))];
    [~, obj.variables_size] = size(obj.MILP_matrices.P);

    % フェーズのバイナリ変数の定義

    phase_groups = dictionary(int32.empty, cell.empty);
    phase_groups(1) = {[1, 3]};
    phase_groups(2) = {[2, 4]};
    phase_groups(3) = {[5, 7]};
    phase_groups(4) = {[6, 8]};
    phase_groups(5) = {[1, 2]};
    phase_groups(6) = {[3, 4]};
    phase_groups(7) = {[5, 6]};
    phase_groups(8) = {[7, 8]}; 
    
    for phase_id = 1: obj.phase_num
        phase_group = phase_groups(phase_id);
        phase_group = phase_group{1};

        for step = 1:obj.N_p
            P_tmp = zeros(3, obj.variables_size);
            P_tmp(:, phase_group(1) + obj.v_num*(step-1)) = [-1; 0; 1];
            P_tmp(:, phase_group(2) + obj.v_num*(step-1)) = [0; -1; 1];
            P_tmp(:, obj.v_num*obj.N_p + phase_id + obj.phase_num*(step-1)) = [1; 1; -1];
            obj.MILP_matrices.P = [obj.MILP_matrices.P; P_tmp];

            q_tmp = [0;0;1];
            obj.MILP_matrices.q = [obj.MILP_matrices.q; q_tmp];
        end
    end

    % 信号現示の変化のバイナリ変数を定義 


    for step = 1:(obj.N_p-1)
        P_tmp = zeros(4*obj.phase_num, obj.variables_size);

        for phase_id = 1: obj.phase_num
            P_tmp((1 + 4*(phase_id -1): 4*phase_id), obj.v_num*obj.N_p + phase_id + obj.phase_num*(step -1)) = [1;-1;-1;1];
            P_tmp((1 + 4*(phase_id -1): 4*phase_id), obj.v_num*obj.N_p + phase_id + obj.phase_num*step) = [1;-1;1;-1];
            P_tmp((1 + 4*(phase_id -1): 4*phase_id), obj.v_num*obj.N_p + obj.phase_num*obj.N_p + phase_id + (obj.phase_num + 1)*(step - 1)) = [1;1;-1;-1];
        end

        obj.MILP_matrices.P = [obj.MILP_matrices.P; P_tmp];

        q_tmp = zeros(4*obj.phase_num, 1);

        for phase_id = 1: obj.phase_num
            q_tmp(1 + 4*(phase_id -1),1) = 2;    
        end

        obj.MILP_matrices.q = [obj.MILP_matrices.q; q_tmp];
    end


    % 青になっていい信号の数の制限

    for step = 1:obj.N_p
        P_tmp = zeros(1, obj.variables_size);
        P_tmp(1, 1 + obj.v_num*(step-1): obj.signal_num +obj.v_num*(step-1)) = [1, 1, 1, 1, 1, 1, 1, 1];
        obj.MILP_matrices.P = [obj.MILP_matrices.P; P_tmp];

        obj.MILP_matrices.q = [obj.MILP_matrices.q; 2];
    end

    % 信号の変化の回数の制限

    P_tmp = zeros(1, obj.variables_size);

    for step = 1:(obj.N_p-1)
        P_tmp(1, obj.v_num*obj.N_p + obj.phase_num*obj.N_p + (obj.phase_num + 1)*step) = 1;
    end

    obj.MILP_matrices.P = [obj.MILP_matrices.P; P_tmp];

    obj.MILP_matrices.q = [obj.MILP_matrices.q; obj.m];

    % delta_cの固定

    deltac_list = obj.variables_list_map("delta_c");
    deltac_list = deltac_list{1};
    
    for veh_id = 1:length(deltac_list)
        for step = 1:obj.N_p
            P_tmp = zeros(1, obj.variables_size);
            P_tmp(deltac_list(veh_id) + obj.v_num*(step-1)) = 1;
            obj.MILP_matrices.Peq = [obj.MILP_matrices.Peq; P_tmp];

            q_tmp = 1;
            obj.MILP_matrices.qeq = [obj.MILP_matrices.qeq; q_tmp];
        end
    end


    % 増えた変数の定義その２
    
    for step = 1:(obj.N_p-1)
        P_tmp = zeros(1, obj.variables_size);
        P_tmp(obj.v_num*obj.N_p + obj.phase_num*obj.N_p + (obj.phase_num + 1)*(step -1) + 1 : obj.v_num*obj.N_p + obj.phase_num*obj.N_p+ (obj.phase_num + 1)*step) = [-1, -1, -1, -1, -1, -1, -1, -1, 2];
        obj.MILP_matrices.Peq = [obj.MILP_matrices.Peq; P_tmp];
        obj.MILP_matrices.qeq = [obj.MILP_matrices.qeq; 0];
    end
    

    % 初期値の固定
    
    for step = 1:obj.fix_num
        P_tmp = zeros(obj.signal_num, obj.variables_size);
        for signal_id = 1:8
            P_tmp(signal_id, signal_id + obj.v_num*(step -1)) = 1;
        end
        obj.MILP_matrices.Peq = [obj.MILP_matrices.Peq; P_tmp];

        u_data = obj.u_results.get_future_data();
        q_tmp = u_data(:, step);
        obj.MILP_matrices.qeq = [obj.MILP_matrices.qeq; q_tmp];
    end

    for step = 1: obj.N_p -1
        P_tmp = zeros(1, obj.variables_size);
        q_tmp = 1;

        for i = 1: step
            P_tmp(1, obj.v_num*obj.N_p + obj.phase_num*obj.N_p + (obj.phase_num + 1)*i) = 1;
        end

        phi_past_data = obj.phi_results.get_past_data();

        for j = 1: obj.N_s - step
            q_tmp = q_tmp - phi_past_data(end - j + 1);
        end

        obj.MILP_matrices.P = [obj.MILP_matrices.P; P_tmp];
        obj.MILP_matrices.q = [obj.MILP_matrices.q; q_tmp];

    end


end