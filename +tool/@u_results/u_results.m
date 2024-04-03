classdef u_results < handle
    properties(GetAccess = private)
        N_p;
        N_c;
        N_s;
        past_data;
        future_data;
        phase_num;
    end

    methods(Access = public)
        function obj = u_results(phase_num, N_p, N_c)
            obj.N_p = N_p;
            obj.N_c = N_c;
            obj.phase_num = phase_num;
            obj.past_data = zeros(phase_num, N_c);
            obj.future_data = zeros(phase_num, N_p - N_c);
            

        end

        function set_initial_future_data(obj, vec)
            for col_id = 1: length(obj.future_data(1, :))
                obj.future_data(:, col_id) = vec;
            end
        end

        function future_data = get_future_data(obj)
           future_data = obj.future_data; 
        end

        function past_data = get_past_data(obj)
           past_data = obj.past_data; 
        end

        function update_data(obj, u_opt)
            u_past = u_opt(:, 1: obj.N_c);
            u_future = u_opt(:, obj.N_c + 1: obj.N_p);

            obj.past_data = u_past;
            obj.future_data = u_future;

        end
    end
end