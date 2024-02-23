% A行列を作成する関数
function make_A_matrix(obj, pos_vehs)
    num_veh = length(pos_vehs);
    obj.MLD_matrices.A = blkdiag(obj.MLD_matrices.A, eye(num_veh));
end