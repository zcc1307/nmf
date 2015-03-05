function anchor = find_anchor(M, k)
% function anchor = find_anchor(M, k)
% find anchor words using geometric approach
% Input: Gram matrix: M
%        topic to be extracted: k
% Output: anchor words: anchor

    
    %normalize each row of M
    M_n = diag(sum(M,2).^-1) * M;

    %transpose so that each column is a vector to be analyzed
    D = M_n';
    n = size(D, 1);
    S = zeros(n, k);
    
    sum(D.^2,1)
    [~, max_idx] = max(sum(D.^2,1));
    max_idx
    S(:,1) = D(:,max_idx);
    norm(S(:,1))

    % first phase
    for i = 2:k
        S_p = S(:,1:i-1);
        %S_p'*S_p
        R = D - S_p*((S_p'*S_p)\(S_p'*D));
        [~, max_idx] = max(sum(R.^2,1));
        S(:,i) = D(:,max_idx);
        norm(S(:,i))
    end
    
    anchor = zeros(k,1);
    
    % clean-up phase
    % maybe one heuristic is to run this several times until it is steady?
    
    for i = 1:k
        sel = true(1,k);
        sel(i) = false;
        S_p = S(:,sel);
        
        R = D - S_p*((S_p'*S_p)\(S_p'*D));
        [~, max_idx] = max(sum(R.^2,1));
        anchor(i) = max_idx;
        S(:,i) = D(:,max_idx);
        norm(S(:,i))
       
    end
    
    W_n = S';

end