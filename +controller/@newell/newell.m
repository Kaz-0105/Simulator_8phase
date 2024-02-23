classdef newell < handle
    
    properties(GetAccess = private)
        id = 0;
        pos_vehs = [];       % フィールド：方角、バリュー：自動車の位置を降順に並べた配列
        route_vehs = [];     % フィールド：方角、バリュー：自動車のルートをpos_vehに対応するように並べた配列
        first_veh = [];


    end

    methods(Access = public)
        function obj = newell(id)
            obj.id = id;
        end

        function update_states(obj, intersection_struct_map, road_vehs_map)
            intersection_struct = intersection_struct_map(obj.id);
            irids = intersection_struct.input_road_ids;

            for irid = irids
                vehs_data = road_vehs_map(irid);
                vehs_data = vehs_data{1};

                if intersection_struct.input_road_directions(irid) == 'n'
                    if ~isempty(vehs_data)
                        obj.pos_vehs.north = vehs_data(:,1);
                        obj.route_vehs.north = vehs_data(:,2);
                    else
                        obj.pos_vehs.north = [];
                        obj.route_vehs.north = [];
                    end
                elseif intersection_struct.input_road_directions(irid) == 's'
                    if ~isempty(vehs_data)
                        obj.pos_vehs.south = vehs_data(:,1);
                        obj.route_vehs.south = vehs_data(:,2);
                    else
                        obj.pos_vehs.south = [];
                        obj.route_vehs.south = [];
                    end
                elseif intersection_struct.input_road_directions(irid) == 'e'    
                    if ~isempty(vehs_data)
                        obj.pos_vehs.east = vehs_data(:,1);
                        obj.route_vehs.east = vehs_data(:,2);
                    else
                        obj.pos_vehs.east = [];
                        obj.route_vehs.east = [];
                    end
                elseif intersection_struct.input_road_directions(irid) == 'w'
                    if ~isempty(vehs_data)
                        obj.pos_vehs.west = vehs_data(:,1);
                        obj.route_vehs.west = vehs_data(:,2);
                    else
                        obj.pos_vehs.west = [];
                        obj.route_vehs.west = [];
                    end
                end
            end
        end

        function sig = optimize(obj)




        end
    end

end