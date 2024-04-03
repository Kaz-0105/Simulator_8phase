function make_intcon_matrix(obj)

    intcon_binary = ones(1, obj.variables_size);

    z1_list = obj.variables_list_map('z_1');
    z2_list = obj.variables_list_map('z_2');
    z3_list = obj.variables_list_map('z_3');
    z4_list = obj.variables_list_map('z_4');
    z5_list = obj.variables_list_map('z_5');

    z1_list = z1_list{1};
    z2_list = z2_list{1};
    z3_list = z3_list{1};
    z4_list = z4_list{1};
    z5_list = z5_list{1};

    for z1_num = z1_list
        for step = 1 : obj.N_p
            intcon_binary(1, z1_num + obj.v_num * (step -1)) = 0;
        end
    end

    for z2_num = z2_list
        for step = 1 : obj.N_p
            intcon_binary(1, z2_num + obj.v_num * (step -1)) = 0;
        end
    end

    for z3_num = z3_list
        for step = 1 : obj.N_p
            intcon_binary(1, z3_num + obj.v_num * (step -1)) = 0;
        end
    end

    for z4_num = z4_list
        for step = 1 : obj.N_p
            intcon_binary(1, z4_num + obj.v_num * (step -1)) = 0;
        end
    end

    for z5_num = z5_list
        for step = 1 : obj.N_p
            intcon_binary(1, z5_num + obj.v_num * (step -1)) = 0;
        end
    end

    obj.MILP_matrices.intcon_binary = intcon_binary;

    intcon = [];

    for variables_id = 1: obj.variables_size
        if intcon_binary(1, variables_id) == 1
            intcon = [intcon, variables_id];
        end
    end

    obj.MILP_matrices.intcon = intcon;

end