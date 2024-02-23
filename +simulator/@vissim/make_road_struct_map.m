function make_road_struct_map(obj)
    for group = obj.config.groups
        group = group{1};
        
        for road = group.roads
            road_struct = [];
            road = road{1};

            for  link_id = road.link_ids
                link_type = obj.link_type_map(link_id);
                link_obj = obj.vis_obj.Net.Links.ItemByKey(link_id);

                if strcmp(link_type, "main") || strcmp(link_type, "out")
                    road_struct.main = link_obj.get('AttValue', 'Length2D');
                elseif strcmp(link_type, "sub")
                    road_struct.sub = link_obj.get('AttValue', 'Length2D');
                elseif strcmp(link_type, "connector")
                    road_struct.con = link_obj.get('AttValue', 'Length2D');
                    road_struct.to_pos = link_obj.get('AttValue', 'ToPos');
                    road_struct.from_pos = link_obj.get('AttValue', 'FromPos');
                end
            end

            if isfield(road_struct, 'con')
                road_struct.rel_con = road_struct.main - road_struct.from_pos - (road_struct.sub - road_struct.to_pos);
            end

            % モデルのパラメータを定義
            if isfield(road, 'signal_controller_id')
                road_struct.D_b = road_struct.main - road_struct.from_pos;
                road_struct.D_f = road.speed - 15;
                road_struct.D_s = road.speed;
                road_struct.d_s = 0;
                road_struct.d_f = 7;
                road_struct.p_s = obj.vis_obj.Net.SignalHeads.ItemByKey(road.sig_head_ids(1)).get('AttValue', 'Pos');
                road_struct.v = road.speed;
            end

            obj.road_struct_map(road.id) = road_struct;
        end    
    end
end