%4a 
P1 = 1 / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5)

P2 = (8/600) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5)


P3 = (8/600*5/200) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5)


P4 = (8/600*5/200*2/50) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5)


P5 = (8/600*5/200*2/50*1/5) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5)

P_normal = (P1 + P2 + P3)
P_interf = P4 + P5

%4b
Av_ber_normal = (P1*1e-6 + P2*1e-5 + P3*1e-4) / (1e-6 + 1e-5 + 1e-4)
Ac_ber_interf = (P4*1e-3 + P5*1e-2) / (1e-3 + 1e-2)

%4c
states_prob = [0.9865020 0.0131534 0.0003288 0.0000132 0.0000026];
ber = [1e-6 1e-5 1e-4 1e-3 1e-2];
packet_Bytes = 64:200;

numerador = 0;
for i=1:3
    numerador = numerador + states_prob(i) * (1 - (1-ber(i)) .^ (packet_Bytes*8));
end
denominador = numerador;

for i=4:5
    denominador = denominador + states_prob(i) * (1 - (1-ber(i)) .^ (packet_Bytes*8));
end
y = numerador ./ denominador;

figure(1)
plot(packet_Bytes , y, 'b' )
title("Probability of being in normal state when packet received with errors")
xlabel("Packet sizes in Bytes")
grid on
axis([64 200 0.95 1])

%4d
states_prob = [0.9865020 0.0131534 0.0003288 0.0000132 0.0000026];
ber = [1e-6 1e-5 1e-4 1e-3 1e-2];
packet_Bytes = 64:200;

numerador = 0;
for i=4:5
    numerador = numerador + states_prob(i) * ((1-ber(i)) .^ (packet_Bytes*8));
end
denominador = numerador;

for i=1:3
    denominador = denominador + states_prob(i) * ((1-ber(i)) .^ (packet_Bytes*8));
end
y = numerador ./ denominador;

figure(2)
plot(packet_Bytes , y, 'b' )
title("Probability of being in interference state when packet received without errors")
xlabel("Packet sizes in Bytes")
grid on
axis([64 200 0 0.0001])





