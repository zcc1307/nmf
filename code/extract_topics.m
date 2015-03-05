function [A, anchor] = extract_topics(M, k)
% function [A, anchor] = extract_topics(M, k)
% extract topic matrix and anchor word from a Gram matrix M
% Input: M: Gram matrix
%        k: number of topics to be extracted
% Output: A: topic matrix extracted
%         anchor: number of anchor words

    
    %here wlog W is row normalized, using distance approach to find
    %vertices
    anchor = find_anchor(M, k);
    
    % using recover L2 to find topic matrix
    [A, W] = recover(M, anchor);
    %[A, W] = brittle_recover(M, anchor);
    
    
end