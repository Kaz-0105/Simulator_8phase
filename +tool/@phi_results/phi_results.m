classdef phi_results < handle
    properties(GetAccess = private)
        N_s;
        N_c;
        past_data;
        N_p;

    end

    methods(Access = public)
        function obj = phi_results(N_p, N_c, N_s)
            obj.N_s = N_s;
            obj.N_c = N_c;
            obj.N_p = N_p;
            obj.past_data = zeros(1, N_s);
            
        end

        function update_data(obj, phi_opt)
            obj.past_data = [obj.past_data(obj.N_c + 1:end), phi_opt(1:obj.N_c)];
        end

        function past_data = get_past_data(obj)
            past_data = obj.past_data; 
        end
    end

end