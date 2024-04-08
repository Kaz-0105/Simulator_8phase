classdef measurement < handle

    properties(GetAccess = public)
    end

    properties(GetAccess = private)
        vis_obj;          % VissimのCOMオブジェクト
        input_data_map;   % 末端道路ごとの流入量の時系列データ格納するディクショナリ
        output_data_map;  % 末端道路ごとの流出量の時系列データ格納するディクショナリ
        queue_data_map;   % 交差点ごとの待ち行列の時系列データを格納するディクショナリ
        calc_time_data;   % 交差点ごとの計算時間の時系列データを格納するディクショナリ
    end

    methods(Access = public)

        function obj = measurement(vis_obj)

            obj.vis_obj = vis_obj;
            obj.input_data_map = dictionary(int32.empty, cell.empty);
            obj.output_data_map = dictionary(int32.empty, cell.empty);
            obj.queue_data_map = dictionary(int32.empty, cell.empty);
            obj.calc_time_data = dictionary(int32.empty, cell.empty);
        end

        function update_data(obj)
            obj.update_input_data();
            obj.updata_output_data();
            obj.update_queue_data();
            obj.update_calc_time_data();
        end

        function input_data_map = get_input_data_map(obj)
            input_data_map = obj.input_data_map;
        end

        function output_data_map = get_output_data_map(obj)
            output_data_map = obj.output_data_map;
        end

        function queue_data_map = get_queue_data_map(obj)
            queue_data_map = obj.queue_data_map;
        end

        function calc_time_data = get_calc_time_data(obj)
            calc_time_data = obj.calc_time_data;
        end

        function plot_data(obj, data_map_name)
            if strcmp(data_map_name, "input")
                obj.plot_input_data();
            elseif strcmp(data_map_name, "output")
                obj.plot_output_data();
            elseif strcmp(data_map_name, "queue")
                obj.plot_queue_data();
            elseif strcmp(data_map_name, "calc_time")
                obj.plot_calc_time_data();
            end
        end

    end

    methods(Access = private)
        % 計測データの更新を行う関数
        update_input_data(obj)
        updata_output_data(obj)
        update_queue_data(obj)
        update_calc_time_data(obj)

        % 計測データのプロットを行う関数
        plot_input_data(obj)
        plot_output_data(obj)
        plot_queue_data(obj)
        plot_calc_time_data(obj)
    end

    methods(Static)
    end
end