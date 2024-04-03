% 分岐後の先行車を特定する関数
function front_veh_id = get_front_veh_id(veh_id, route_vehs)
    for front_veh_id = (veh_id-1) : -1 : 1
        if route_vehs(veh_id) == 1 || route_vehs(veh_id) == 2
            if route_vehs(front_veh_id) == 1 || route_vehs(front_veh_id) == 2
                break;
            end
        else
            if route_vehs(front_veh_id) == 3
                break;
            end
        end
    end
end