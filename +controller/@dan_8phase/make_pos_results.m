function make_pos_results(obj)

    A = obj.MLD_matrices.A;
    B1 = obj.MLD_matrices.B1;
    B2 = obj.MLD_matrices.B2;
    B3 = obj.MLD_matrices.B3;
    B = [B1, B2, B3];
    pos_vehs_all = obj.pos_vehs_all;

    obj.pos_results = zeros(length(pos_vehs_all), obj.N_p + 1);
    for step = 0: obj.N_p
        if step == 0
            obj.pos_results(:, step + 1) = pos_vehs_all;
        else
            obj.pos_results(:, step + 1) = A*obj.pos_results(:, step) + B*obj.x_opt(1 + obj.v_num*(step-1) : obj.v_num*(step));
        end
    end

    figure;
    hold on;
    for veh_id = 1: length(obj.pos_vehs.south)
        if obj.route_vehs.south(veh_id) ~= 3
            plot(0: obj.N_p, obj.pos_results(length(obj.pos_vehs.north) + veh_id, :));
        end
    end
    close all;

    delta3_list = obj.variables_list_map('delta_3');
    delta3_list = delta3_list{1};
    count = 0;

    for delta3_num = delta3_list
        for step = 1: obj.N_p
            if obj.x_opt(delta3_num + obj.v_num*(step-1)) == 1
                count = count + 1;
            end
        end
    end

    disp(count);
end