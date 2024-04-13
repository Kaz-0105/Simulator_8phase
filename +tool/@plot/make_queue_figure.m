function make_queue_figure(obj)
    queue_data_map = obj.measurements.get_queue_data_map();

    % 全てのqueueのデータに0秒のデータを加える

    for intersection_id = keys(queue_data_map)'
        queue_data = queue_data_map(intersection_id);
        queue_data.north = [0, queue_data.north];
        queue_data.south = [0, queue_data.south];
        queue_data.east = [0, queue_data.east];
        queue_data.west = [0, queue_data.west];
        queue_data_map(intersection_id) = queue_data;
    end

    % 平均のデータをqueue_dataに加える
    
    for intersection_id = keys(queue_data_map)'
        queue_data = queue_data_map(intersection_id);
        queue_data.average = mean([queue_data.north; queue_data.south; queue_data.east; queue_data.west], 1);
        queue_data_map(intersection_id) = queue_data;
    end

    queue_data_all = [];

    num_intersections = 0;

    for intersection_id = keys(queue_data_map)'
        queue_data = queue_data_map(intersection_id);
        if isempty(queue_data_all)
            queue_data_all = queue_data.average;
        else
            queue_data_all = queue_data_all + queue_data.average;
        end

        num_intersections = num_intersections + 1;
    end

    queue_data_all = queue_data_all / num_intersections;

    % 系全体の平均のプロット
    for plot_member = obj.plot_list
        plot_member = plot_member{1};
        if strcmp(plot_member.data, "queue_length") && strcmp(plot_member.type, "all")

            figure_struct = [];
            figure_struct.fig_obj = figure("Name", "Queue");
            grid on;
            figure_struct.x_data = obj.time_data;
            figure_struct.y_data = queue_data_all;

            figure_struct.p_obj = plot(obj.time_data, queue_data_all, "LineWidth", obj.line_width);

            set(gca, "FontSize", obj.gca_font_size);
            xlabel("Time [s]", "FontSize", obj.label_font_size);
            ylabel("Queue Length [m]", "FontSize", obj.label_font_size);
            title("Queue Length (Entire Network)", "FontSize", obj.title_font_size);

            xlim([0, obj.time_data(end)]);

            obj.figure_structs("queue_length_all") = figure_struct;
        end
    end

    % 各交差点のプロット
    
    for plot_member = obj.plot_list
        plot_member = plot_member{1};
        if strcmp(plot_member.data, "queue_length") && strcmp(plot_member.type, "one")
            
            for intersection_id = keys(queue_data_map)'
                queue_data = queue_data_map(intersection_id);

                figure_struct = [];
                figure_struct.fig_obj = figure("Name", "Queue");
                grid on;
                figure_struct.x_data = obj.time_data;
                figure_struct.y_data = queue_data.average;

                figure_struct.p_obj = plot(obj.time_data, queue_data.average, "LineWidth", obj.line_width);

                set(gca, "FontSize", obj.gca_font_size);
                xlabel("Time [s]", "FontSize", obj.label_font_size);
                ylabel("Queue Length [m]", "FontSize", obj.label_font_size);
                title(strcat("Queue Length (Intersection ID: ", num2str(intersection_id), ")"), "FontSize", obj.title_font_size);

                xlim([0, obj.time_data(end)]);

                obj.figure_structs(strcat("queue_length_", num2str(intersection_id))) = figure_struct;
            end
        end
    end
    
end