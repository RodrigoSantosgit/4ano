
%PacketLoss (%) = 0.0000
%Av. Packet Delay (ms) = 8.1275
%Throughput (Mbps) = 9.3602
C = 10; %Mbps
lam = 1800;


P = 10000;
lambda = 1800;
C = 10;
f = 1000000;
N = 10;

aux2= [65:109 111:1517];
B = 64*0.16 + 110*0.25 + 1518*0.2 + (mean(aux2))*(1-0.16-0.25-0.2);
miu = C*1e6/(B*8);

L = lambda / ( miu - lambda)
W = (L/lambda) * 1000
WQ = W - 1/miu
