% Task 4b
    
P = 100000;
alfa = 0.1;
lambda = 1800;
C = 10;
f = 10000;
b = 10e-5;
N = 1:1:10;

resultsPL = zeros(1,10);
resultsMPD = zeros(1,10);
resultsAPD = zeros(1,10);
resultsTT = zeros(1,10);

for it = N
     [resultsPL(it),resultsAPD(it),resultsMPD(it),resultsTT(it)] = simulator3(lambda, C, f, P, b);
end

termPL = norminv(1-alfa/2)*sqrt(var(resultsPL)/10);
termAPD = norminv(1-alfa/2)*sqrt(var(resultsAPD)/10);
termMPD = norminv(1-alfa/2)*sqrt(var(resultsMPD)/10);
termTT = norminv(1-alfa/2)*sqrt(var(resultsTT)/10);
PL = mean(resultsPL);
APD = mean(resultsAPD);
MPD = mean(resultsMPD);
TT = mean(resultsTT);


fprintf('PL sim3 = %0.2e +- %0.2e \n', PL, termPL);
fprintf('APD sim = %0.2e +- %0.2e \n', APD,termAPD);
fprintf('MPD sim3 = %0.2e +- %0.2e \n', MPD, termMPD);
fprintf('TT sim2 = %0.2e +- %0.2e \n', TT, termTT);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function p=norminv(b)
    p = -sqrt(2)*erfcinv(2*b);
end