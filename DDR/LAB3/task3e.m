% MM1m WAITING QUEUE

pl_mmm1 = zeros(1,8);
w_mmm1 = zeros (1,8);
tt_mmm1 = zeros(1,8);

P = 10000;
lambda = 1800;
C = 10;
f_values = 2500:2500:20000
b = 0;
N = 40;

aux2= [65:109 111:1517];
B = 64*0.16 + 110*0.25 + 1518*0.2 + (mean(aux2))*(1-0.16-0.25-0.2);
miu = C*1e6/(B*8);
k=1
for f = f_values
    m = fix(f / B) + 1

    sum = 0;
    for j = 0:m
        sum = sum + ((lambda/miu)^j);
    end

    pl_mmm1(k) = (((lambda/miu)^m)/sum) * 100;

    sum2 = 0;
    for a = 0:m
        sum2 = sum2 + (a * (lambda/miu)^a);
    end

    L = sum2 / sum;
    w_mmm1(k) = L / ((lambda * (1 - pl_mmm1(k)/100))) * 1000;
    tt_mmm1(k) = lambda * 8 * B * 1e-6 * (1 - pl_mmm1(k)/100);
    k=k+1
end

resultsPL = zeros(1,40);
resultsMPD = zeros(1,40);
resultsAPD = zeros(1,40);
resultsTT = zeros(1,40);

dataPL = zeros(1,8);
dataMPD = zeros(1,8);
dataAPD = zeros(1,8);
dataTT = zeros(1,8);

i = 1;

for f = f_values
    for it = 1:N
    [resultsPL(it),resultsAPD(it),resultsMPD(it),resultsTT(it)] = simulator2(lambda, C, f, P, b);
    end
    dataPL(i) = mean(resultsPL);
    dataAPD(i) = mean(resultsAPD);
    dataMPD(i) = mean(resultsMPD);
    dataTT(i) = mean(resultsTT);
    i = i+1;
end

data_pl = [dataPL;pl_mmm1]
figure(1)
h = bar(f_values,data_pl);
hold on
grid on
title("Packet Loss mMm1")
set(h, {'DisplayName'}, {'W sim','W theoric'}')
legend('Location','northwest')
hold off

data_w = [dataAPD;w_mmm1];
figure(2)
h = bar(f_values,data_w);
hold on
grid on
title("Average Packet Delay mMm1")
set(h, {'DisplayName'}, {'W sim','W theoric'}')
legend('Location','northwest')
hold off

data_tt = [dataTT;tt_mmm1];
figure(3)
h = bar(f_values,data_tt);
hold on
grid on
title("Total Throughput mMm1")
set(h, {'DisplayName'}, {'TT sim','TT theoric'}')
legend('Location','northwest')
hold off
