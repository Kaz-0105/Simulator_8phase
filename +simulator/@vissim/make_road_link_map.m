function make_road_link_map(obj)
    for group = obj.config.groups
        group = group{1};
        for road = group.roads
            road = road{1};
            obj.road_link_map(road.id) = {road.link_ids};
        end
    end
end