classdef plot < handle
    properties(GetAccess = public)
    end

    properties(GetAccess = private)
        time_data; % 時間のデータ
        measurements;  % vissim_measurementsクラスの変数
        plot_list; % プロットするデータのリスト

        line_width; % 線の太さ
        label_font_size; % ラベルのフォントサイズ
        title_font_size; % タイトルのフォントサイズ
        gca_font_size; % gcaのフォントサイズ

        figure_structs; % キー：figure名、値：figure構造体のディクショナリ
    end

    methods(Access = public)

        function obj = plot(measurements, config)
            obj.measurements = measurements;
            obj.plot_list = config.plot_list;

            time_step = config.time_step;
            num_loop = config.num_loop;
            control_horizon = config.control_horizon;
            obj.time_data = 0:time_step*control_horizon:time_step*control_horizon*num_loop;

            obj.line_width = 2;
            obj.label_font_size = 15;
            obj.title_font_size = 20;
            obj.gca_font_size = 15;

            obj.figure_structs = dictionary(string.empty, struct.empty); 

            obj.make_input_output_figure();
            obj.make_queue_figure();
            obj.make_calc_time_figure();

        end

        
    end

    methods(Access = private)

        make_input_output_figure(obj)
        make_queue_figure(obj)
        make_calc_time_figure(obj)

    end

    methods(Static)
    end
end