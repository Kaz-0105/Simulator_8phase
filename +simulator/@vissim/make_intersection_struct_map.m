function make_intersection_struct_map(obj)
    for group = obj.config.groups
        group = group{1};
        for intersection = group.intersections
            intersection = intersection{1};
            obj.intersection_struct_map(intersection.id) = intersection;
        end
    end
end