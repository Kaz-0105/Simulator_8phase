classdef plot < handle
    properties(GetAccess = public)
    end

    properties(GetAccess = private)
        measurements;  % vissim_measurementsクラスの変数

    end

    methods(Access = public)

        function obj = plot(measurements, varargin)
            obj.measurements = measurements;

            
        end
    end
end