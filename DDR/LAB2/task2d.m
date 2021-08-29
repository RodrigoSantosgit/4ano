% Task 2d

R = 10000;
alfa = 0.1;
lambda = 100:20:200;
N = 10;
p = 20;
servers = 10;
S = 100;
W = 600;
i = 1;
for lam = lambda
    
    for it = 1:N
        [results(it),av(it)]= simulator2(lam,p,servers,S,W,R,"movies.txt");
        [results2(it),av2(it)]= simulator2(lam,p,4,250,W,R,"movies.txt");
        [results3(it),av3(it)]= simulator2(lam,p,1,1000,W,R,"movies.txt");
    end
 
    alfa= 0.1; %90% confidence interval%
    
    mediaHD = mean(results);
    termHD = norminv(1-alfa/2)*sqrt(var(results)/N);
    media2HD = mean(results2);
    term2HD = norminv(1-alfa/2)*sqrt(var(results2)/N);
    media3HD = mean(results3);
    term3HD = norminv(1-alfa/2)*sqrt(var(results3)/N);
    
    media24K = mean(av2);
    term24K = norminv(1-alfa/2)*sqrt(var(av2)/N);
    media34K = mean(av3);
    term34K = norminv(1-alfa/2)*sqrt(var(av3)/N);
    media4K = mean(av);
    term4K = norminv(1-alfa/2)*sqrt(var(av)/N);
    
    dataHD(i)= mediaHD;
    data2HD(i)= media2HD;
    data3HD(i)= media3HD;
    
    data4K(i)= media4K;
    data24K(i)= media24K;
    data34K(i)= media34K;
    i=i+1;
end

data = [dataHD; data2HD; data3HD];
data2 = [data4K; data24K; data34K];

figure(1)
h = bar(lambda,data)
hold on
grid on
set(h, {'DisplayName'}, {'dataHDconfig1','dataHDconfig2','dataHDconfig3'}')
legend('Location','northwest')
hold off

figure(2)
h2 = bar(lambda,data2)
hold on
grid on
set(h2, {'DisplayName'}, {'data4Kconfig1','data4Kconfig2','data4Kconfig3'}')
legend('Location','northwest')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function p=norminv(b)
    p = -sqrt(2)*erfcinv(2*b);
end