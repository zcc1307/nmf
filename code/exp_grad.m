function c = exp_grad(Q_s_s, Q_s_i)
%function c = exp_grad(Q_s_s, Q_s_i)
% recover c matrix by solving a least squares problem
% now the implicit form is only used for recover L2 error 
% originally it was intended for exponentiated gradient, but the
% experimental result is not good. 
% Inputs: Q_s_s: pairwise product of anchor rows
%         Q_s_i: product of anchor rows and row i
% Outputs: c: estimate of P(z = k | w = i)

%     k
%     c = ones(k,1) / k;
%     
%     converged = false;
%     t = 0;
%     eps = 0.01;
%     
%     
%     while ~converged && t < 1000
%        t = t + 1;
%        %eta_t = 1/t;
%        eta_t = 1;
%        
%        grad = 2 * (Q_s_s * c - Q_s_i);
%        c = c .* exp(-eta_t * grad);
%        c = c / sum(c);
%        
%        lambda = grad - min(grad);
%        if lambda' * c < eps
%            converged = true;
%        end
%     end
%    c = Q_s_s \ Q_s_i;

    k = size(Q_s_s,2);
    cvx_begin quiet
        variable c(k)
        minimize (c'*Q_s_s*c - 2*c'*Q_s_i)
        subject to
            sum(c) == 1;
            c >= 0;
    cvx_end



end