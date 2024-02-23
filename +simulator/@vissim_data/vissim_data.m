classdef vissim_data<handle

    properties(GetAccess = public)

    end

    properties(GetAccess = private)
        road_vehs_map;          % キー：道路ID、値：その道路上の自動車の位置と進路をまとめた配列
        road_first_veh_map;     % キー：道路ID、値：その道路上の先頭の自動車のID
        queue_no_map;           
        delay_no_map;
    end

    methods(Access = public)
        function obj = vissim_data(v_obj, maps)
            % road_vehs_map を作成する
            obj.road_vehs_map = dictionary(int32.empty, cell.empty);
            obj.road_first_veh_map = dictionary(int32.empty, struct.empty);
            obj.get_vehicle_data(v_obj, maps);

            % queue_no_map, delay_no_map を作成する
            obj.queue_no_map = dictionary(int32.empty, double.empty);
            obj.delay_no_map = dictionary(int32.empty, struct.empty);
            obj.get_measurement_data(v_obj);
        end

        function road_vehs_map = get_road_vehs_map(obj)
            road_vehs_map = obj.road_vehs_map;
        end

        function road_first_veh_map = get_road_first_veh_map(obj)
            road_first_veh_map = obj.road_first_veh_map;
        end

        function queue_no_map = get_queue_no_map(obj)
            queue_no_map = obj.queue_no_map;
        end

        function delay_no_map = get_delay_no_map(obj)
            delay_no_map = obj.delay_no_map;
        end

        
    end

    methods(Access = private)
        get_vehicle_data(obj, v_obj, maps);
        get_measurement_data(obj, v_obj);
    end

    methods(Static)
    end
end