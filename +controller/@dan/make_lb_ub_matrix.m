function make_lb_ub_matrix(obj)

    lb = zeros(1, obj.variables_size);
    ub = ones(1, obj.variables_size);


    intcon_binary = obj.MILP_matrices.intcon_binary;

    for variables_id = 1: obj.variables_size
        if intcon_binary(variables_id) == 0
            ub(variables_id) = Inf;
            lb(variables_id) = - Inf;
        end
    end


    obj.MILP_matrices.lb = lb;
    obj.MILP_matrices.ub = ub;
end