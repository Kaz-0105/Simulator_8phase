clear all;
close all;

% yamlクラスの変数の作成
file_name = 'config.yaml';
file_dir = strcat(pwd, '\layout\');
config = config.yaml(file_name, file_dir);

% vissimクラスの作成
vissim = simulator.vissim(config);

% vissimクラスのCOMオブジェクトを取得
vis_obj = vissim.get_vissim_obj();

% シミュレーションを行う

for sim_count = 1:config.sim_count
    fprintf('%d回目のシミュレーションを開始します。\n', sim_count);
    vissim.clear_states();

    for sim_step = 1:config.num_loop
        vissim.update_simulation(sim_step);
    end
    
    % 結果のプロット

    vissim.plot_results();
end


