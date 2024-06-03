classdef vissim < handle
    properties(GetAccess = private)
        config;                             % yamlクラスの変数
        vis_obj;                            % VissimのCOMオブジェクト 
        link_road_map;                      % キー：リンクのID、バリュー：そのリンクが属する道路のID
        link_type_map;                      % キー：リンクのID、バリュー：リンクの種類
        road_link_map;                      % キー：道路のID、バリュー：その道路に属するリンクのIDの配列が入ったセル配列
        road_struct_map;                    % キー：道路のID、バリュー：道路の長さに関する構造体
        link_input_output_map;              % キー：リンクのID、バリュー：そのリンクが末端流入リンクまたは末端流出リンクであるかどうか
        intersection_struct_map;            % キー：交差点のID、バリュー：交差点の流入出道路に関する構造体
        link_queue_map;                     % キー：リンクのID、バリュー：そのリンクのキューカウンターのID
        maps;                               % キー：ディクショナリの名前、バリュー：ディクショナリ
        controllers;                        % 各交差点の制御器をまとめたディクショナリ
        measurements;                       % vissim_measurementクラスの変数
        vis_data;                           % vissim_dataクラスの変数
        break_time = 0;                     % シミュレーションのブレイクポイントの時間
        vis_controllers;                    % キー：交差点のID、バリュー：交差点の信号を制御するCOMのオブジェクト
        num_sig_group_list;                 % 各交差点のSignal Groupの数をまとめたリスト
    end

    methods(Access = public)
        function obj = vissim(config)

            % yamlクラスの変数の設定
            obj.config = config;

            % COMのオブジェクトの設定
            obj.vis_obj = actxserver('VISSIM.vissim');
            obj.vis_obj.LoadNet(config.inpx_file);
            obj.vis_obj.LoadLayout(config.layx_file);

            % Vehicle Network Performanceの設定
            obj.vis_obj.Evaluation.set('AttValue','VehNetPerfCollectData',true);
            obj.vis_obj.Evaluation.set('AttValue','VehNetPerfFromTime',0);
            obj.vis_obj.Evaluation.set('AttValue','VehNetPerfToTime',config.control_interval*config.num_loop);
            obj.vis_obj.Evaluation.set('AttValue','VehNetPerfInterval',config.control_interval);

            % Delay Timeの設定
            obj.vis_obj.Evaluation.set('AttValue','DelaysCollectData',true);                                                        % Delayの計測をONにする
            obj.vis_obj.Evaluation.set('AttValue','DelaysFromTime',0);                                                              % Delayの計測の開始時間の設定
            obj.vis_obj.Evaluation.set('AttValue','DelaysToTime',config.control_interval*config.num_loop);                          % Delayの計測の終了時間の設定
            obj.vis_obj.Evaluation.set('AttValue','DelaysInterval',config.control_interval);                                        % データの収集間隔の設定

            % Queue Lengthの設定
            obj.vis_obj.Evaluation.set('AttValue','QueuesCollectData',true);                                            % Queueの計測をONにする
            obj.vis_obj.Evaluation.set('AttValue','QueuesFromTime',0);                                                  % Queueの計測の開始時間の設定
            obj.vis_obj.Evaluation.set('AttValue','QueuesToTime',config.control_interval*config.num_loop);              % Queueの計測の終了時間の設定
            obj.vis_obj.Evaluation.set('AttValue','QueuesInterval',config.control_interval);                            % データの収集間隔の設定

            % シミュレーション用の設定
            obj.vis_obj.Simulation.set('AttValue', 'NumRuns', config.sim_count);                                             % シミュレーション回数の設定をVissimに渡す
            obj.vis_obj.Simulation.set('AttValue','RandSeed',config.seed);                                                  % 乱数シードの設定をVissimに渡す
            obj.vis_obj.Graphics.CurrentNetworkWindow.set('AttValue','QuickMode',config.graphic_mode);                      % 描画設定をVissimに渡す
            obj.vis_obj.Simulation.set('AttValue','UseMaxSimSpeed',false);                                                   % シミュレーションを最高速度で行うようにVissimを設定する
            obj.vis_obj.Simulation.set('AttValue','UseAllCores',true);                                                      % シミュレーションに全てのコアを使うようにVissimを設定する
            obj.vis_obj.Simulation.set('AttValue','SimPeriod',config.control_interval*config.num_loop);                     % シミュレーション時間を設定する

            % link_road_mapの作成
            obj.link_road_map = dictionary(int32.empty, int32.empty);                                                         % link_road_mapの初期化
            obj.make_link_road_map();

            % link_type_mapの作成
            obj.link_type_map = dictionary(int32.empty, string.empty);
            obj.make_link_type_map();

            % road_link_mapの作成
            obj.road_link_map = dictionary(int32.empty, cell.empty);
            obj.make_road_link_map();

            % road_struct_mapの作成
            obj.road_struct_map = dictionary(int32.empty, struct.empty);
            obj.make_road_struct_map();

            % intersection_struct_mapの作成
            obj.intersection_struct_map = dictionary(int32.empty, struct.empty);
            obj.make_intersection_struct_map();

            % link_input_output_mapの作成
            obj.link_input_output_map = dictionary(int32.empty, string.empty);
            obj.make_link_input_output_map();

            % link_queue_mapの作成
            obj.link_queue_map = dictionary(int32.empty, int32.empty);
            obj.make_link_queue_map();

            % mapをまとめたdictionaryの作成
            obj.maps = dictionary(string.empty, dictionary);
            obj.maps("link_road_map") = obj.link_road_map;
            obj.maps("link_type_map") = obj.link_type_map;
            obj.maps("road_link_map") = obj.road_link_map;
            obj.maps("road_struct_map") = obj.road_struct_map;
            obj.maps("link_input_output_map") = obj.link_input_output_map;
            obj.maps("intersection_struct_map") = obj.intersection_struct_map;
            obj.maps("link_queue_map") = obj.link_queue_map;

            % 制御器の設定

            obj.controllers = dictionary(int32.empty, cell.empty);

            for intersection_struct = values(obj.intersection_struct_map)'
                switch intersection_struct.control_method
                    case "Dan_4phase"
                        obj.controllers(intersection_struct.id) = {controller.dan_4phase(intersection_struct.id, config, obj.maps)};
                    case "Dan_8phase"
                        obj.controllers(intersection_struct.id) = {controller.dan_8phase(intersection_struct.id, config, obj.maps)};
                    case "Dan_3fork"
                        obj.controllers(intersection_struct.id) = {controller.dan_3fork(intersection_struct.id, config, obj.maps)};
                    case "Fix"
                        obj.controllers(intersection_struct.id) = {controller.fix(intersection_struct.id, config, obj.maps)};
                    case "Max_queue"
                        obj.controllers(intersection_struct.id) = {controller.max_queue(intersection_struct.id, config, obj.maps)};
                end    
            end

            % vissim_measurementsクラスの変数の設定
            obj.measurements = simulator.vissim_measurements(obj.vis_obj);

            % 制御器のCOMオブジェクトの設定

            obj.vis_controllers = dictionary(int32.empty, cell.empty);

            for group = obj.config.groups
                group = group{1};
                for intersection = group.intersections
                    intersection = intersection{1};
                    obj.vis_controllers(intersection.id) = {obj.vis_obj.Net.SignalControllers.ItemByKey(intersection.id)};
                end
            end

            % num_sig_group_listの作成
            obj.num_sig_group_list = zeros(1, length(obj.vis_controllers));
        end

        function v_obj = get_vissim_obj(obj)
            v_obj = obj.vis_obj;
        end

        function measurements = get_measurements(obj)
            measurements = obj.measurements;
        end

        function clear_states(obj)
        end

        function update_states(obj)
            obj.vis_data = simulator.vissim_data(obj.vis_obj, obj.maps);
            
            for controller = values(obj.controllers)'
                controller = controller{1};
                controller.update_states(obj.intersection_struct_map, obj.vis_data);
            end

        end

        function sigs = optimize(obj)

            sigs = dictionary(int32.empty, cell.empty);

            for intersection_id = keys(obj.controllers)'
                controller = obj.controllers(intersection_id);
                controller = controller{1};
                sig = controller.optimize();
                sigs(intersection_id) = {sig};
            end
        end

        function update_simulation(obj, sim_step)

            if sim_step == 1
                obj.break_time = obj.break_time + obj.config.control_interval;
                obj.vis_obj.Simulation.set('AttValue','SimBreakAt',obj.break_time);
                obj.vis_obj.Simulation.RunContinuous();

                for intersection_id = keys(obj.vis_controllers)'
                    vis_controller = obj.vis_controllers(intersection_id);
                    controller = obj.controllers(intersection_id);

                    vis_controller = vis_controller{1};
                    controller = controller{1};

                    if strcmp(string(class(controller)), "controller.dan_4phase")
                        obj.num_sig_group_list(intersection_id) = 8; 
                    elseif strcmp(string(class(controller)), "controller.dan_8phase")
                        obj.num_sig_group_list(intersection_id) = 8;
                    elseif strcmp(string(class(controller)), "controller.dan_3fork")
                        obj.num_sig_group_list(intersection_id) = 6;
                    end

                    for signal_group_id = 1: obj.num_sig_group_list(intersection_id)
                        vis_controller.SGs.ItemByKey(signal_group_id).set('AttValue','State',1);
                    end
        
                end
            else
                obj.update_states();
                sigs = obj.optimize();

                for step = 1:obj.config.control_horizon
                    obj.break_time = obj.break_time + obj.config.time_step;
                    obj.vis_obj.Simulation.set('AttValue','SimBreakAt',obj.break_time);

                    for intersection_id = keys(obj.vis_controllers)'
                        vis_controller = obj.vis_controllers(intersection_id);
                        vis_controller = vis_controller{1};

                        sig = sigs(intersection_id);
                        sig = sig{1};

                        for signal_group_id = 1: obj.num_sig_group_list(intersection_id)
                            if sig(signal_group_id, step) == 0
                                vis_controller.SGs.ItemByKey(signal_group_id).set('AttValue','State',1);
                            else
                                vis_controller.SGs.ItemByKey(signal_group_id).set('AttValue','State',3);
                            end 
                        end
                    end
                    obj.vis_obj.Simulation.RunContinuous();
                end
        
            end
            obj.measurements.update_data(obj.maps, obj.controllers);
        end
    end

    methods(Access = private)
        make_link_road_map(obj);
        make_link_type_map(obj);
        make_road_link_map(obj);
        make_road_struct_map(obj);
        make_link_input_output_map(obj);
        make_link_queue_map(obj);
        make_intersection_struct_map(obj);
    end

    methods(Static)
    end
end