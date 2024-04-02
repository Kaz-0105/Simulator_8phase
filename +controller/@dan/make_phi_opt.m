function make_phi_opt(obj)
    phi_opt = zeros(1, obj.N_p-1);

    for step = 1:obj.N_p-1
        phi_opt(step) = obj.x_opt(v_num*obj.N_p + (obj.signal_num + 1)*step);
    end

    obj.phi_opt = phi_opt;
end