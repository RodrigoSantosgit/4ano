%%
% 3B
R = 50000;
AS2_Total = 10;
AS3_Total = 25;
AS2_Subs = 5000;
AS3_Subs = 2500;
Movie_per_day = 1;
clc

P = 30;
S = 1000;
lambda = (AS2_Subs * AS2_Total + AS3_Subs * AS3_Total) / 24;

arr_prob_hd = zeros(1,10); 
arr_prob_4k = zeros(1,10);
mean_prob_hd = zeros(1,10);
mean_prob_4k = zeros(1,10);

n = ceil(linspace(10,100,10));
w = ceil(linspace(1000,50000,10));
x = 1;

% Verificar valores de N e W em larga escala %
for i = 1:length(n)
    fprintf("Calculating for %d servers and W between 1000 and 50000\n",n(i));
    for j = 1:length(w)
        [prob_hd, prob_4k] = simulator2(lambda, P, n(i), S, w(j), R, 'movies.txt');
        fprintf("\n----- N: %d | W: %d ", n(i), w(j));
        disp("-----");
        arr_prob_hd(1,j) = prob_hd;
        arr_prob_4k(1,j) = prob_4k;
        disp("");
        disp(arr_prob_hd);
        disp(arr_prob_4k);
     end
 
     % Para cada servidor faz a media do W entre 46870 - 46880 %
     mean_prob_hd(1, x) = mean(arr_prob_hd);
     mean_prob_4k(1, x) = mean(arr_prob_4k);
     fprintf("Mean for %d servers and W between 1000 and 50000\n",n(i));
     disp(mean_prob_hd)
     disp(mean_prob_4k)
     x = x+1;
end

% Verificou-se que N será melhor entre 70 e 80 e W melhor entre 35000 e
% 50000 &
% Com os resultados anteriormente calculados, verificar o N e W em menor escala %
clc

arr_prob_hd = zeros(1,10); 
arr_prob_4k = zeros(1,10);

mean_prob_hd = zeros(1,10);
mean_prob_4k = zeros(1,10);

n = ceil(linspace(73,77,5));
w = ceil(linspace(35000,50000,10));

alfa = 0.1;
norminv90 = 1.6449;

for i = 1:length(n)
    for j = 1:length(w)
        [prob_hd, prob_4k] = simulator2(lambda, P, n(i), S, w(j), R, 'movies.txt');
        arr_prob_hd(1, i) = prob_hd;
        arr_prob_4k(1, i) = prob_4k;
        fprintf("\n----- N: %d - W: %d | hd: %d - 4k: %d ", n(i), w(j), prob_hd, prob_4k);
        conf_prob_hd = norminv90 * sqrt(var(arr_prob_hd)/10);
        conf_prob_4k = norminv90 * sqrt(var(arr_prob_4k)/10);
        fprintf("\n    ----- conf_HD: %d - conf_4K: %d ", conf_prob_hd, conf_prob_4k);
    end
end