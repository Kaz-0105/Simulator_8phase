function make_link_type_map(obj)
    for group = obj.config.groups
        group = group{1};
        for road = group.roads
            road = road{1};
            if length(road.link_ids) == 3
                for link_id = road.link_ids
                    if link_id >= 10000
                        obj.link_type_map(link_id) = "connector";
                    elseif link_id == road.main_link_id
                        obj.link_type_map(link_id) = "main";
                    else
                        obj.link_type_map(link_id) = "sub";
                    end
                end
            else
                obj.link_type_map(road.link_ids) = "out";
            end
        end
    end
end