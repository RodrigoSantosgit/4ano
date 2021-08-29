% TASK 1c

P = 10000;
alfa = 0.1;
lambda = 1800;
C = 10;
f = 10000;

sizes = [65:1:109 111:1:1517];
rest = 1 - 0.16 - 0.2 - 0.25;
B = (64 * 0.16 + 1518 * 0.20 + 110 * 0.25 + mean(sizes) * rest) * 8;
u = (C*1e6)/B;
W = 1/(u - lambda) * 1000;

TT = lambda * B * 1e-6;

fprintf('W (atraso médio no sistema) = %0.4e \n', W);
fprintf('TT (totatl throughput no sistema) = %0.4e \n', TT);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% lambda = 1800;
% C = 10;
% 
% aux2= [65:109 111:1517];
% B = 64*0.16 + 110*0.25 + 1518*0.2 + (mean(aux2))*(1-0.16-0.25-0.2);
% miu = C*1e6/(B*8);
% 
% L = lambda / ( miu - lambda)
% W = (L/lambda) * 1000
% % WQ = W - 1/miu
% TH = lambda * B * 1e-6 * 8


