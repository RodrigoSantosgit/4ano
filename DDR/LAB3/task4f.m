% Task 4f
    
P = 100000;
alfa = 0.1;
lambda = 1800;
C = 10;
f_sizes = 2500:2500:20000;
b = 10e-5;
N = 1:1:10;

resultsPL = zeros(1,10);
resultsMPD = zeros(1,10);
resultsAPD = zeros(1,10);
resultsTT = zeros(1,10);

resultsPL2 = zeros(1,10);
resultsMPD2 = zeros(1,10);
resultsAPD2 = zeros(1,10);
resultsTT2 = zeros(1,10);

PL = zeros(1,5);
MPD = zeros(1,5);
APD = zeros(1,5);
TT = zeros(1,5);

PL2 = zeros(1,5);
MPD2 = zeros(1,5);
APD2 = zeros(1,5);
TT2 = zeros(1,5);

i= 1;
for f = f_sizes
    
    for it = N
         [resultsPL(it),resultsAPD(it),resultsMPD(it),resultsTT(it)] = simulator3(lambda, C, f, P, b);
         [resultsPL2(it),resultsAPD2(it),resultsMPD2(it),resultsTT2(it)] = simulator2(lambda, C, f, P, b);
    end
    
    PL(i) = mean(resultsPL);
    APD(i) = mean(resultsAPD);
    MPD(i) = mean(resultsMPD);
    TT(i) = mean(resultsTT);

    PL2(i) = mean(resultsPL2);
    APD2(i) = mean(resultsAPD2);
    MPD2(i) = mean(resultsMPD2);
    TT2(i) = mean(resultsTT2);
    i= i+1;
end

dataPL = [PL;PL2];
figure(1)
h = bar(f_sizes,dataPL);
hold on
grid on
title("Packet Loss")
set(h, {'DisplayName'}, {'PL SIM3','PL SIM2'}')
legend('Location','northwest')
hold off

dataAPD = [APD;APD2];
figure(2)
h = bar(f_sizes,dataAPD);
hold on
grid on
title("Average Packet Delay")
set(h, {'DisplayName'}, {'APD SIM3','APD SIM2'}')
legend('Location','northwest')
hold off

dataMPD = [MPD;MPD2];
figure(3)
h = bar(f_sizes,dataMPD);
hold on
grid on
title("Maximum Packet Delay")
set(h, {'DisplayName'}, {'MPD SIM3','MPD SIM2'}')
legend('Location','northwest')
hold off

dataTT = [TT;TT2];
figure(4)
h = bar(f_sizes,dataTT);
hold on
grid on
title("Total Throughput")
set(h, {'DisplayName'}, {'TT SIM3','TT SIM2'}')
legend('Location','northwest')
hold off
