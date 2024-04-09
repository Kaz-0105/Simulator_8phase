function make_link_input_output_map(obj)
    % 流入末端リンクを調べる
    for group = obj.config.groups
        group = group{1};
        for road = group.roads
            road = road{1};
            if isfield(road, "input")
                obj.link_input_output_map(road.main_link_id) = "input";
            end
        end
    end

    % 流出末端リンクを調べる
    for link_id = keys(obj.link_type_map)'
        if strcmp(obj.link_type_map(link_id), "out")
            obj.link_input_output_map(link_id) = "output";
        end
    end
        
end