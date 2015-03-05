function [A, W] = brittle_recover(M, anchor)
% function [A, W] = recover(M,W_n,anchor)
% recover A and W matrix using matrix inversion
% Inputs: M: Gram matrix
%         W_n: normalized anchor row
%         anchor: anchor words
% Outputs: A: topic matrix
%          W: unnormalized anchor row

    M_s = M(anchor, :);
    M_s_s = M(anchor, anchor);
    p_s = sum(M_s,2);
    
    
    z = M_s_s \ p_s;
    
    A = ((M_s_s * diag(z)) \ M_s)';
    %R = diag(z) * M_s_s * diag(z);
    
    W = diag(z) \ M_s;

end