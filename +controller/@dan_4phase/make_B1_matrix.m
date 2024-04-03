% B1行列を作成する関数
function make_B1_matrix(obj, pos_vehs)
    num_veh = length(pos_vehs);
    obj.MLD_matrices.B1 = [obj.MLD_matrices.B1; zeros(num_veh, obj.signal_num)];
end