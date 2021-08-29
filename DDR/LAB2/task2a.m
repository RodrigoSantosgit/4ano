% Task 2a

R = 10000;
alfa = 0.1;
lambda = 100:20:200;
N = 10;
p = 20;
servers = 10;
S = 100;
W = 0;
i = 1;
for lam = lambda
    
    for it = 1:N
        [results(it),av(it)]= simulator2(lam,p,servers,S,W,R,"movies.txt");
    end
 
    alfa= 0.1; %90% confidence interval%
    mediaHD = mean(results);
    termHD = norminv(1-alfa/2)*sqrt(var(results)/N);
    media4K = mean(av);
    term4K = norminv(1-alfa/2)*sqrt(var(av)/N);
    fprintf('Blocking probability of HD = %.2e +- %.2e\n',mediaHD,termHD)
    fprintf('Blocking probability of 4K = %.2e +- %.2e\n',media4K,term4K)
    dataHD(i)= mediaHD;
    errhighHD(i) = termHD;
    errlowHD(i) = - termHD;
    data4K(i)= media4K;
    errhigh4K(i) = term4K;
    errlow4K(i) = - term4K;
    i=i+1;
end

data = [dataHD; data4K];
h = bar(lambda,data)
hold on
grid on
er = errorbar(lambda,dataHD,errlowHD,errhighHD);    
er.Color = [0 0 0];                          
er.LineStyle = 'none';  
er2 = errorbar(lambda,data4K,errlow4K,errhigh4K);    
er2.Color = [0 0 0];                            
er2.LineStyle = 'none';  
set(h, {'DisplayName'}, {'dataHD','data4K'}')
legend('Location','northwest')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function p=norminv(b)
    p = -sqrt(2)*erfcinv(2*b);
end