% Task 1e

% numerator= ro^N/factorial(N);
% denominator= 0;
% for n= 0:N
%  denominator= denominator + ro^n/factorial(n);
% end
% p = numerator/denominator;

% Blocking Probability

a= 1;
p= 1;
N= 25;
dataTeoric = zeros(1,7);
lambda = 10:5:40;
i=1;
for lam=lambda
    ro=lam/(1/86.3) / 60;
    a= 1;
    p= 1;
    for n= N:-1:1
         a= a*n/ro;
         p= p + a;
    end
    p = 1/p; %blocking prob
    dataTeoric(i)= p *100;
    i=i+1;
end

N = 10;
dataSim = zeros(1,7);
results= zeros(1,N);
av = zeros(1,N);
lambda = 10:5:40;
i=1;
for lam=lambda
    for it= 1:N
        [results(it),av(it)]= simulator1(lam,100,4,500,"movies.txt");
    end
    media = mean(results);
    dataSim(i)= media;
    i=i+1;
end

data = [dataTeoric; dataSim];
bar(lambda, data)

grid on
hold on
hold off

% Average server ocupation

N = 10; %number of simulations
results= zeros(1,N); %vector with N simulation results
av = zeros(1,N);
lambda = 10:5:40;
dataSim2 = zeros(1,7);
i=1;
for lam=lambda
    for it= 1:N
        [results(it),av(it)]= simulator1(lam,100,4,500,"movies.txt");
    end
    dataSim2(i) = mean(av);
    i= i+1;
end

dataTeoric2 = zeros(1,7);
i= 1;
for lam=lambda
    a= 25;
    numerator= a;
    ro = lam/(1/86.3) / 60;
    for i= 25-1:-1:1
     a= a*i/ro;
     numerator= numerator + a;
    end

    a= 1;
    denominator= a;
    for i= 25:-1:1
     a= a*i/ro;
     denominator= denominator + a;
    end
    
    o= numerator/denominator;
    dataTeoric2(i) = o;
    i=i+1;
end

data = [dataTeoric2; dataSim2];
bar(lambda, data)

grid on
hold on
hold off

