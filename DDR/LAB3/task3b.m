% Task 3b
P = 10000;
alfa = 0.1;
lambda = 1500:100:2000;
C = 10;
f = 10000000;
b = 0;
N = 40;
resultsPL = zeros(1,10);
resultsMPD = zeros(1,10);
resultsAPD = zeros(1,10);
resultsTT = zeros(1,10);
dataPL = zeros(1,5);
dataMPD = zeros(1,5);
dataAPD = zeros(1,5);
dataTT = zeros(1,5);
errhighPL = zeros(1,5);
errhighMPD = zeros(1,5);
errhighAPD = zeros(1,5);
errhighTT = zeros(1,5);
errlowPL = zeros(1,5);
errlowMPD = zeros(1,5);
errlowAPD = zeros(1,5);
errlowTT = zeros(1,5);
i = 1;

for lam = lambda
    for it = 1:N
        [resultsPL(it),resultsAPD(it),resultsMPD(it),resultsTT(it)] = simulator2(lam, C, f, P, b);
    end
    alfa= 0.1; %90% confidence interval%
    
    dataPL(i) = mean(resultsPL);
    termPL = norminv(1-alfa/2)*sqrt(var(resultsPL)/N);
    errhighPL(i) = termPL;
    errlowPL(i) = - termPL;
    dataAPD(i) = mean(resultsAPD);
    termAPD = norminv(1-alfa/2)*sqrt(var(resultsAPD)/N);
    errhighAPD(i) = termAPD;
    errlowAPD(i) = - termAPD;
    dataMPD(i) = mean(resultsMPD);
    termMPD = norminv(1-alfa/2)*sqrt(var(resultsMPD)/N);
    errhighMPD(i) = termMPD;
    errlowMPD(i) = - termMPD;
    dataTT(i) = mean(resultsTT);
    termTT = norminv(1-alfa/2)*sqrt(var(resultsTT)/N);
    errhighTT(i) = termTT;
    errlowTT(i) = - termTT;
    i = i+1;
end

figure(1)
h = bar(lambda,dataPL);
hold on
grid on
title("Packet Loss")
er = errorbar(lambda,dataPL,errlowPL,errhighPL);    
er.Color = [0 0 0];                          
er.LineStyle = 'none';
set(h, {'DisplayName'}, {'dataPL'}')
legend('Location','northwest')
hold off

figure(2)
h = bar(lambda,dataAPD);
hold on
grid on
title("Average Packet Delay")
er2 = errorbar(lambda,dataAPD,errlowAPD,errhighAPD);    
er2.Color = [0 0 0];                          
er2.LineStyle = 'none';
set(h, {'DisplayName'}, {'dataAPD'}')
legend('Location','northwest')
hold off

figure(3)
h = bar(lambda,dataMPD);
hold on
grid on
title("Maximum Packet Delay")
er3 = errorbar(lambda,dataMPD,errlowMPD,errhighMPD);    
er3.Color = [0 0 0];                          
er3.LineStyle = 'none';
set(h, {'DisplayName'}, {'dataMPD'}')
legend('Location','northwest')
hold off

figure(4)
h = bar(lambda,dataTT);
hold on
grid on
title("Total Throughput")
er4 = errorbar(lambda,dataTT,errlowTT,errhighTT);    
er4.Color = [0 0 0];                          
er4.LineStyle = 'none';
set(h, {'DisplayName'}, {'dataTT'}')
legend('Location','northwest')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function p=norminv(b)
    p = -sqrt(2)*erfcinv(2*b);
end