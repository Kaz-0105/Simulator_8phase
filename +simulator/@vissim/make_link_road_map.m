% link_road_mapを作る関数
function make_link_road_map(obj)

    for group = obj.config.groups
        group = group{1};
        for road = group.roads
            road = road{1};
            for link_id = road.link_ids
                obj.link_road_map(link_id) = road.id;
            end
        end
    end
end