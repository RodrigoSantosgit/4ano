% Task 3b

R = 5000;
alfa = 0.1;
lambda = round((5000*2 + 2500*3) / 24);
N = 10;
p = 30;
S = 1000;
W = 0:50:250;
servers = 10:1:15;

for ser = servers
    fprintf('\n Servers: %d ', ser);
    for w = W
        fprintf('W: %d\n', w);
        for it = 1:N
            [results(it),av(it)]= simulator2(lambda,p,ser,S,w,R,"movies.txt");
        end

        alfa= 0.1; %90% confidence interval%
        mediaHD = mean(results);
        termHD = norminv(1-alfa/2)*sqrt(var(results)/N);
        media4K = mean(av);
        term4K = norminv(1-alfa/2)*sqrt(var(av)/N);
        fprintf('Blocking probability of HD = %.5e +- %.2e\n',mediaHD,termHD)
        fprintf('Blocking probability of 4K = %.5e +- %.2e\n',media4K,term4K)
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function p=norminv(b)
    p = -sqrt(2)*erfcinv(2*b);
end