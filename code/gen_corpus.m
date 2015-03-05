% script for verifying sample complexity using semi-synthetic data

n_cand = [50 500 5000 10000 15000 20000 25000 30000 40000 50000 100000 200000];
rounds = size(n_cand,2);

m = size(A,1);
k = size(A,2);
err = zeros(k,rounds);
D = 1000;

t = 1;
for t = 1:rounds

    n = n_cand(t);
    alpha = 0.1*ones(k,1);
    X = zeros(n,m);
    M = zeros(m,m);

    for i = 1:n
       d = gamrnd(alpha , 1);
       d = d./sum(d);
       x = mnrnd(D,A*d);
       M = M + x' * x - diag(x);
    end
    M = M / (n*D*(D-1));
    
    alpha_0 = sum(alpha);

    [A_p, anchor_p] = extract_topics(M,k);

    for i = 1:k
        [~, j] = min(sum(abs(repmat(A(:,i),1,k) - A_p),1));
        err(i,t) = norm(A(:,i) - A_p(:,j),1);
        err(i,t)
        '---------------------------------'
        [~, I] = sort(A(:,i),'descend');
        Dict(anchor(i))
        Dict(I(1:20))'
        [~, I] = sort(A_p(:,j),'descend');
        Dict(anchor_p(j))
        Dict(I(1:20))'
    end

end

figure;
hold on;
for i = 1:k
   plot(n_cand,err(i,:))
end
xlabel('#documents n','FontSize',15)
ylabel('\ell_1 error for each topic','FontSize',15)



%err = zeros(k,1);
%for infinite data case:
%M = A * ( alpha * alpha' + diag(alpha) ) / (alpha_0 * (alpha_0 + 1)) * A';

%make it exactly anchor
%A(anchor,:) = diag(diag(A(anchor,:)));
%A = A * diag(sum(A,1).^-1);