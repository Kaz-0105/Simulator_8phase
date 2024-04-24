function make_f_matrix(obj)
    f = zeros(1, obj.variables_size);

    delta1_list = obj.variables_list_map('delta_1');
    delta1_list = delta1_list{1};

    for delta1_num = delta1_list
        for step = 1: obj.N_p
            f(delta1_num + obj.v_num*(step-1)) = 1;
        end
    end

    obj.MILP_matrices.f = f;
end