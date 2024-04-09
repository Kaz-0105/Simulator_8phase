function make_link_queue_map(obj)
    for group = obj.config.groups
        group = group{1};
        for road = group.roads
            road = road{1};
            for link_id = road.link_ids
                if link_id == road.main_link_id
                    obj.link_queue_map(link_id) = road.queue_counter_ids(1);
                elseif link_id < 10000
                    obj.link_queue_map(link_id) = road.queue_counter_ids(2);
                end
            end
        end

    end
end