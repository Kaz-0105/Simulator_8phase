clear all;
close all;

% yamlクラスの変数の作成
file_name = 'config.yaml';
file_dir = strcat(pwd, '\layout\');
config = config.yaml(file_name, file_dir);

% 制御方法の表示

config.show_control_method();

%fprintf('制御モデル：'+ config.prediction_model + '\n');

% vissimクラスの作成
vissim = simulator.vissim(config);

% vissimクラスのCOMオブジェクトを取得
vis_obj = vissim.get_vissim_obj();

% シミュレーションを行う

for sim_count = 1:config.sim_count
    fprintf('%d回目のシミュレーションを開始します。\n', sim_count);
    vissim.clear_states();

    for sim_step = 1:config.num_loop
        fprintf('%d回目の最適化計算を行っています。\n', sim_step);
        
        vissim.update_simulation(sim_step);
      
    end

    data_analysis = tool.data_analysis(vissim.get_measurements(), config);

    % 性能指標の表示
    fprintf("Queue Length: %f\n", data_analysis.get_performance_index());

    data_analysis.save_figure_structs();

    data_analysis.compare_results();
end


