function make_phi_opt(obj)
    phi_opt = zeros(1, obj.N_p-1);

    for step = 1:obj.N_p-1
        phi_opt(step) = obj.x_opt(obj.v_num*obj.N_p + (obj.signal_num + 1)*step);
    end

    obj.phi_opt = round(phi_opt);
end