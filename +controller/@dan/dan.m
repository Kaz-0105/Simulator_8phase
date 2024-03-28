classdef dan < handle
    properties(GetAccess = private)
        id; % 交差点のID
        signal_num; % 信号機の数
        dt; % タイムステップ
        N_p; % 予測ホライゾン
        N_c; % 制御ホライゾン
        N_s; % 最低の連続回数
        eps; % 微小量
        m; % ホライゾン内の最大変化回数
        fix_num; % 固定するステップ数

        road_prms; % 交差点を構成する東西南北の道路のパラメータを収納する構造体

        phi_results; % 全体として信号現示が変化したことを示すバイナリphiの結果を格納するクラス
        u_results; % 信号現示のバイナリuの結果を格納するクラス

        pos_vehs; % 自動車の位置情報をまとめた構造体
        route_vehs; % 自動車の進行方向の情報をまとめた構造体
        first_veh_ids; % 先頭車の情報をまとめた構造体

        MLD_matrices; % 混合論理動的システムの係数行列を収納する構造体
        MILP_matrices; % 混合整数線形計画問題の係数行列を収納する構造体

        variables_list_map; % 決定変数の種類ごとのリストを収納するdictionary

        v_num; % MLDの決定変数の長さ
        prediction_count; % 予測回数


    end

    methods(Access = public)
        function obj = dan(id, config, maps)
            obj.id = id; % 交差点のID
            obj.signal_num = 8; % 信号機の数（今回は各道路2車線なので8）
            obj.dt = config.time_step; % タイムステップ
            obj.N_p = config.predictive_horizon; % 予測ホライゾン
            obj.N_c = config.control_horizon; % 制御ホライゾン
            obj.N_s = config.model_prms.N_s; % 最低の連続回数
            obj.eps = config.model_prms.eps; % 微小量
            obj.m = config.model_prms.m; % ホライゾン内の最大変化回数
            obj.fix_num = config.model_prms.fix_num; % 固定するステップ数

            obj.make_road_prms(maps) % 交差点の東西南北の道路のパラメータを収納する構造体を作成

            obj.phi_results = tool.phi_results(obj.N_p, obj.N_c, obj.N_s); % phi_resultsクラスの初期化
            obj.u_results = tool.u_results(obj.signal_num, obj.N_p, obj.N_c); % u_resultsクラスの初期化
            obj.u_results.set_initial_future_data([1,0,1,0,0,0,0,0]'); % モデルに出てくる前回の信号現示の部分でエラーを起こさないために設定

            obj.prediction_count = 0; % 予測回数の初期化

            obj.variables_list_map = dictionary(string.empty, cell.empty); % 決定変数の種類ごとのリストを収納するdictionaryの初期化
        end


        % 計算に必要な自動車の位置情報と進行方向の情報を更新する関数
        function update_states(obj, intersection_struct_map, vis_data)

            obj.make_vehs_data(intersection_struct_map, vis_data); % 自動車の位置情報と進行方向の情報を更新
            obj.make_MLD_matrices(); % 混合論理動的システムの係数行列を更新
            obj.make_variables_list(); % 決定変数の種類ごとのリストを更新
            obj.make_MILP_matrices(); % 混合整数線形計画問題の係数行列を更新

        end
    end

    methods(Access = private)
        make_road_prms(obj, maps);
        make_vehs_data(obj, intersection_struct_map, vis_data);

        % 混合論理動的システムの係数行列を作成する関数群
        make_MLD_matrices(obj);
        make_A_matrix(obj, pos_vehs);
        make_B1_matrix(obj, pos_vehs, route_vehs, first_veh_ids, road_prms);
        make_B2_matrix(obj, route_vehs, first_veh_ids, road_prms);
        make_B3_matrix(obj, route_vehs, first_veh_ids, road_prms);
        make_C_matrix(obj, pos_vehs, route_vehs, first_veh_ids, road_prms);    
        make_D1_matrix(obj, route_vehs, first_veh_ids, direction);
        make_D2_matrix(obj, pos_vehs, first_veh_ids, road_prms);
        make_D3_matrix(obj, pos_vehs, first_veh_ids, road_prms);
        make_E_matrix(obj, pos_vehs, first_veh_ids, road_prms);

        % 決定変数の種類ごとのリストを作成する関数群

        make_variables_list(obj);

        make_delta1_list(obj);
        make_delta2_list(obj);
        make_delta3_list(obj);

        make_deltad_list(obj);
        make_deltap_list(obj);
        make_deltaf2_list(obj);
        make_deltaf3_list(obj);
        make_deltab_list(obj);
        
        make_deltac_list(obj);

        make_z1_list(obj);
        make_z2_list(obj);
        make_z3_list(obj);
        make_z4_list(obj);
        make_z5_list(obj);

        % 混合整数線形計画問題の形にMLDの係数と信号機制約の係数を変形する関数群
        make_MILP_matrices(obj);
        make_f_matrix(obj);
        make_constraints_matrix(obj, MLD_matrices, pos_vehs);
        make_lb_ub_matrix(obj);
        make_intcon_matrix(obj);

        % 最適解と次の最適化に必要な決定変数を抽出する関数群
        make_u_opt(obj, x_opt);
        make_phi_opt(obj, x_opt);

    end

    methods(Static)
        front_veh_id = get_front_veh_id(veh_id, route_vehs);
    end
end