% Task 1a
N = 10; %number of simulations
results= zeros(1,N); %vector with N simulation results
av = zeros(1,N);
lam = 20;

for it= 1:N
    [results(it),av(it)]= simulator1(lam,100,4,500,"movies.txt");
end

alfa= 0.1; %90% confidence interval%
media = mean(results);
term = norminv(1-alfa/2)*sqrt(var(results)/N);
fprintf('Blocking probability = %.2e +- %.2e\n',media,term)
term2 = norminv(1-alfa/2)*sqrt(var(av)/N);
fprintf('Average occupation = %.2e +- %.2e\n\n',mean(av), term2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Task 1b)

N = 10;
results = zeros(1, N);
av = zeros(1,N);
lam = [10 15 20 25 30 35 40];
R = 500;
M = 4;
C = 100;
data = zeros(1,7);
errhigh = zeros(1,7);
errlow = zeros(1,7);
i=1;
for l= lam
    for it = 1:N
        [results(it), av(it)] = simulator1(l,C,M,R,"movies.txt");
    end
    alfa= 0.1; %90% confidence interval%
    media = mean(results);
    term = norminv(1-alfa/2)*sqrt(var(results)/N);
    fprintf('Blocking probability = %.2e +- %.2e\n\n',media,term)
    data(i)= media;
    errhigh(i) = term;
    errlow(i) = - term;
    i=i+1;
end


bar(lam,data)                

hold on

er = errorbar(lam,data,errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Task 1c)

N = 10;
results = zeros(1, N);
av = zeros(1,N);
lam = [10 15 20 25 30 35 40];
R = 5000;
M = 4;
C = 100;
data = zeros(1,7);
errhigh = zeros(1,7);
errlow = zeros(1,7);
i=1;

for l= lam
    for it = 1:N
        [results(it), av(it)] = simulator1(l,C,M,R,"movies.txt");
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


% bar(lam,data)                
% 
% hold on
% 
% er = errorbar(lam,data,errlow,errhigh);    
% er.Color = [0 0 0];                            
% er.LineStyle = 'none';
% grid on
% 
% hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Task 1d

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

% bar(lambda,data)
% hold on
% grid on
% er = errorbar(lambda,data,errlow,errhigh);    
% er.Color = [0 0 0];                            
% er.LineStyle = 'none';  

%hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function p=norminv(b)
    p = -sqrt(2)*erfcinv(2*b);
end
