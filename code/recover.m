function [A, W] = recover(M, anchor)
% function [A,W] = recover(M, anchor)
% recover A and W matrix using least squres
% Inputs: M: Gram matrix
%         anchor: anchor words
% Outputs: A: topic matrix
%          W: unnormalized anchor row

    % from the result we assume wlog that W_n is row normalized
    M_sum = sum(M,2);
    M_n = diag(sum(M,2).^-1) * M;
    W_n = M_n(anchor,:);
    
    n = size(M, 2);
    k = size(W_n, 1);

    C = zeros(n, k);
    
    Q_s_s = W_n * W_n';
    Q_i_s = M_n * W_n';
    
    
    for i = 1:n
       i
       s = exp_grad(Q_s_s, Q_i_s(i,:)');
       %s = primal_grad(W_n, M_n(i,:));
       %Q_s_s
       C(i,:) = s';
    end

    C = diag(M_sum) * C;
    A = C * diag(sum(C,1).^-1);
    
    W = diag(sum(C,1)) * W_n;
    
end