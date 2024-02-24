function make_MILP_matrices(obj)

    
    obj.MILP_matrices.f = [];
    obj.MILP_matrices.P = [];
    obj.MILP_matrices.q = [];
    obj.MILP_matrices.Peq = [];
    obj.MILP_matrices.qeq = [];
    obj.MILP_matrices.intcon = [];
    obj.MILP_matrices.lb = [];
    obj.MILP_matrices.ub = [];

    % 系に一台も自動車が存在しない場合は計算の必要がないため空の行列を返す
    if isempty(obj.MLD_matrices.A)
        return;
    end
   
    % 等式制約と不等式制約の作成
    obj.make_constraints_matrix(obj.MLD_matrices, obj.pos_vehs);

    % 目的関数の作成
    obj.make_f_matrix();

    % 整数制約の作成
    obj.make_intcon_matrix();

    % 決定変数の上下限の作成
    obj.make_lb_ub_matrix();


end
