function c = primal_grad(W_n, M_n_i)
% c = primal_grad(W_n, M_n_i)
% recover c matrix by solving a least squares problem
% Inputs: W_n: anchor rows
%         M_n_i: row i
% Outputs: c: estimate of P(z = k | w = i)

    k = size(W_n, 1);

    cvx_begin
        variable c(k)
        %minimize (sum(rel_entr(M_n_i,c'*W_n))) 
        minimize (sum_square(M_n_i - c'*W_n))
        subject to
            sum(c) == 1;
            c >= 0;
    cvx_end
    
end