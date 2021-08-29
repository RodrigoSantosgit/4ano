N = 10; %number of simulations
results= zeros(1,N); %vector with N simulation results
av = zeros(1,N);
lambda = 100:50:400;
data = zeros(1,7);
errhigh = zeros(1,7);
errlow = zeros(1,7);
i=1;
for lam=lambda
    for it= 1:N
        [results(it),av(it)]= simulator1(lam,1000,4,5000,"movies.txt");
    end
    alfa= 0.1; %90% confidence interval%
    media = mean(results);
    term = norminv(1-alfa/2)*sqrt(var(results)/N);
    fprintf('Blocking probability = %.2e +- %.2e\n',media,term)
    data(i)= media;
    errhigh(i) = term;
    errlow(i) = - term;
    i=i+1;
end

bar(lambda,data)
hold on

er = errorbar(lambda,data,errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off
