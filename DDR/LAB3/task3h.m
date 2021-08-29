% Task 3h

P = 10000;
lambda = 1500:100:2000;
C = 10;
f = 10000000;
b = 10e-5;
N = 40;
resultsPL = zeros(1,10);
resultsMPD = zeros(1,10);
resultsAPD = zeros(1,10);
resultsTT = zeros(1,10);
dataAPD = zeros(1,5);
dataTT = zeros(1,5);
i = 1;

for lam = lambda
    for it = 1:N
        [resultsPL(it),resultsAPD(it),resultsMPD(it),resultsTT(it)] = simulator2(lam, C, f, P, b);
    end
    dataAPD(i) = mean(resultsAPD);
    dataTT(i) = mean(resultsTT);
    i = i+1;
end

% MG1 WAITING QUEUE
sizes = [65:1:109 111:1:1517];
rest = 1 - 0.16 - 0.2 - 0.25; % probability of all sizes in sizes
B = (64 * 0.16 + 1518 * 0.20 + 110 * 0.25 + mean(sizes) * rest) * 8; % Average Packet Size
w_mg1 = zeros (1,5);
tt_mg1 = zeros(1,5);
S1 = (64 * 8) /10e6; %C*1e6;
S2 = (110 * 8) / 10e6; %C*1e6;
S3 = (1518 * 8) / 10e6; %C*1e6;
S4 = ((mean(sizes)) * 8) / 10e6; %C*1e6;
S42 = 0;

for i = [65:109 111:1517]
    S42 = S42 + ((i*8)/10e6)^2;
end
S42 = S42 / length(sizes);
ES = 0.16 * S1 + 0.25 * S2 + 0.2 * S3 + (1-0.16-0.25-0.2) * S4;
ES2 = 0.16 * S1^2 + 0.25 * S2^2 + 0.2 * S3^2 + (1-0.16-0.25-0.2) * S42;
i=1;
for lam = lambda
    w_mg1(i) = ((lam * ES2) / (2 * (1 - lam * ES)) + ES) * 1000;
    tt_mg1(i) = lam * B * 1e-6 ;
    i=i+1;
end

data1 = [dataAPD;w_mg1];
data2 = [dataTT;tt_mg1];

figure(1)
h = bar(lambda,data1);
hold on
grid on
title("Average Packet Delay")
set(h, {'DisplayName'}, {'APD SIM','APD MG1'}')
legend('Location','northwest')
hold off

figure(2)
h = bar(lambda,data2);
hold on
grid on
title("Total Throughput")
set(h, {'DisplayName'}, {'TT SIM','TT MG1'}')
legend('Location','northwest')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function p=norminv(b)
    p = -sqrt(2)*erfcinv(2*b);
end