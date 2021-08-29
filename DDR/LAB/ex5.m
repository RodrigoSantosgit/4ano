% 5a
states_prob = [0.9865020 0.0131534 0.0003288 0.0000132 0.0000026];
ber = [1e-6 1e-5 1e-4 1e-3 1e-2];
packet_size = 64*8;
n = 2:5;
normal_state_with_errors = zeros(size(1:3));
for i=1:3
    normal_state_with_errors(i) = 1 - ( 1*(ber(i))^0 * (1-(ber(i)))^(packet_size-0) ); 
end
    
interf_state_errors = zeros(size(4:5));
for i=4:5
    interf_state_errors(i) = 1 - ( 1*(ber(i))^0 * (1-(ber(i)))^(packet_size-0) ); 
end

prob_false_positive = zeros(size(2:5));
for i = n
    prob6 = normal_state_with_errors(1) ^ i;
    prob5 = normal_state_with_errors(2) ^ i;
    prob4 = normal_state_with_errors(3) ^ i;
    prob3 = interf_state_errors(4)^ i;
    prob2 = interf_state_errors(5)^ i;
    den = (prob6 * states_prob(1) + prob5 * states_prob(2) + prob4 * states_prob(3) + prob3 * states_prob(4) + prob2 * states_prob(5));
    prob_false_positive(i-1) = (prob6 * states_prob(1) + prob5 * states_prob(2) + prob4 * states_prob(3)) / den;
end

figure(1)
semilogy(n,prob_false_positive, 'b')
title("Probability of false positives")
xlabel("number of consecutive control frames")
grid on
axis([2 5 1e-5 1])

% 5b
states_prob = [0.9865020 0.0131534 0.0003288 0.0000132 0.0000026];
ber = [1e-6 1e-5 1e-4 1e-3 1e-2];
packet_size = 64*8;
n = 2:5;
normal_state_no_errors = zeros(size(1:3));
for i=1:3
    normal_state_no_errors(i) = ( 1*(ber(i))^0 * (1-(ber(i)))^(packet_size-0) );
end
    
interf_state_no_errors = zeros(size(4:5));
for i=4:5
    interf_state_no_errors(i) = ( 1*(ber(i))^0 * (1-(ber(i)))^(packet_size-0) );
end

prob_false_negative = zeros(size(2:5));
for i = n
    prob6 = 1- ((1- normal_state_no_errors(1)) ^ i);
    prob5 = 1- ((1- normal_state_no_errors(2)) ^ i);
    prob4 = 1- ((1- normal_state_no_errors(3)) ^ i);
    prob3 = 1- ((1- interf_state_no_errors(4)) ^ i);
    prob2 = 1- ((1- interf_state_no_errors(5)) ^ i);
    den = (prob6 * states_prob(1) + prob5 * states_prob(2) + prob4 * states_prob(3) + prob3 * states_prob(4) + prob2 * states_prob(5));
    prob_false_negative(i-1) = (prob3 * states_prob(4) + prob2 * states_prob(5)) / den;
end

figure(2)
semilogy(n,prob_false_negative, 'b')
ylim([0,0.0000135])
title("Probability of false negatives")
xlabel("number of consecutive control frames")
grid on
