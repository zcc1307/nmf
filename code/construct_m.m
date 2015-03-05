%Deal with real corpus

%A = load('docword.nytimes2.txt');
A = load('docword.nips.txt');
X = spconvert(A);

%Dict = textread('vocab.nytimes.txt', '%s', 'delimiter', '\n');
Dict = textread('vocab.nips.txt', '%s', 'delimiter', '\n');

cutoff = 1000;

[~, I] = sort(sum(X,1),'descend');
Dict = Dict(I(1:cutoff));
X = X(:,I(1:cutoff));

V = sum(X,2);

%X = X(V >= 100,:);
%X = X(randsample(size(X,1),5000,false), :);
[~, I] = sort(V, 1, 'descend');
X = X(I(1:1100),:);

V = sum(X,2);
Docs = size(X,1);
M = (X' * diag((V.*(V-1)).^-1) * X - diag(sum(diag((V.*(V-1)).^-1) * X)) ) / Docs;


[A, anchor] = extract_topics(M,10);

[~, I] = sort(A, 1,'descend');

for j = 1:size(A,2)
   Dict(anchor(j))
   %A(anchor(j),:)
   Dict(I(1:20,j))'
end
