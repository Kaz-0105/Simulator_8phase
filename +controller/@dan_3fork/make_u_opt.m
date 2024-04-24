function make_u_opt(obj)

    u_opt = zeros(obj.signal_num, obj.N_p);

    for sig_id = 1: obj.signal_num
        for step = 1: obj.N_p
            u_opt(sig_id, step) = obj.x_opt(sig_id + obj.v_num*(step-1));
        end
    end


    obj.u_opt = round(u_opt);
end