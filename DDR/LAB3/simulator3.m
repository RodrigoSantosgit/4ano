function [PL , APD , MPD , TT] = simulator3(lambda,C,f,P,b)
% INPUT PARAMETERS:
%  lambda - packet rate (packets/sec)
%  C      - link bandwidth (Mbps)
%  f      - queue size (Bytes)
%  P      - number of packets (stopping criterium)
%  b      - BER
% OUTPUT PARAMETERS:
%  PL   - packet loss (%)
%  APD  - average packet delay (milliseconds)
%  MPD  - maximum packet delay (milliseconds)
%  TT   - transmitted throughput (Mbps)

%Events:
ARRIVAL= 0;       % Arrival of a packet            
DEPARTURE= 1;     % Departure of a packet
TRANSITION = 2;

%State variables:
STATE = 0;          % 0 - connection free; 1 - connection bysy
QUEUEOCCUPATION= 0; % Occupation of the queue (in Bytes)
QUEUE= [];          % Size and arriving time instant of each packet in the queue
FLOWSTATE = 0;  

%Statistical Counters:
TOTALPACKETS= 0;       % No. of packets arrived to the system
LOSTPACKETS= 0;        % No. of packets dropped due to buffer overflow
TRANSMITTEDPACKETS= 0; % No. of transmitted packets
TRANSMITTEDBYTES= 0;   % Sum of the Bytes of transmitted packets
DELAYS= 0;             % Sum of the delays of transmitted packets
MAXDELAY= 0;           % Maximum delay among all transmitted packets
PACKETS_WITH_ERRORS = 0; % No. of packtes arrived with errors
%Auxiliary variables:
% Initializing the simulation clock:
Clock= 0;

% Initializing the List of Events with the first ARRIVAL:

F1 = 1 / (1 + 10/5 + 10/5*5/10);
F2 = (10/5)  / (1 + 10/5 + 10/5*5/10);
F3 = (10/5*5/10)  / (1 + 10/5 + 10/5*5/10);
T_perm = 1/10;

aux_rand= rand();
if aux_rand <= F1 
    rate=0.5*lambda;
    FLOWSTATE = 1;
elseif aux_rand <= F1+F2
    rate = lambda;
    FLOWSTATE = 2;
else
    rate = 1.5*lambda;
    FLOWSTATE = 3;
end
EventList = [ARRIVAL, Clock + exprnd(1/rate), GeneratePacketSize(), 0];
EventList = [EventList; TRANSITION, Clock + exprnd(T_perm), 0, 0];

%Similation loop:
while TRANSMITTEDPACKETS<P               % Stopping criterium
    EventList= sortrows(EventList,2);    % Order EventList by time
    Event= EventList(1,1);               % Get first event and 
    Clock= EventList(1,2);               %   and
    PacketSize= EventList(1,3);          %   associated
    ArrivalInstant= EventList(1,4);      %   parameters.
    EventList(1,:)= [];                  % Eliminate first event
    switch Event
        case ARRIVAL                     % If first event is an ARRIVAL
            TOTALPACKETS= TOTALPACKETS+1;
            EventList = [EventList; ARRIVAL, Clock + exprnd(1/rate), GeneratePacketSize(), 0];
            if STATE==0
                STATE= 1;
                EventList = [EventList; DEPARTURE, Clock + 8*PacketSize/(C*10^6), PacketSize, Clock];
            else
                if QUEUEOCCUPATION + PacketSize <= f
                    QUEUE= [QUEUE;PacketSize , Clock];
                    QUEUEOCCUPATION= QUEUEOCCUPATION + PacketSize;
                else
                    LOSTPACKETS= LOSTPACKETS + 1;
                end
            end
            
        case DEPARTURE                     % If first event is a DEPARTURE
            prob_err = (1-b) ^ (8 * PacketSize);   
            if(rand(1)>prob_err)
                PACKETS_WITH_ERRORS = PACKETS_WITH_ERRORS + 1;
                LOSTPACKETS = LOSTPACKETS + 1;
            else
                TRANSMITTEDBYTES= TRANSMITTEDBYTES + PacketSize;
                DELAYS= DELAYS + (Clock - ArrivalInstant);
                if Clock - ArrivalInstant > MAXDELAY
                    MAXDELAY= Clock - ArrivalInstant;
                end
                TRANSMITTEDPACKETS= TRANSMITTEDPACKETS + 1;
            end
            if QUEUEOCCUPATION > 0
                EventList = [EventList; DEPARTURE, Clock + 8*QUEUE(1,1)/(C*10^6), QUEUE(1,1), QUEUE(1,2)];
                QUEUEOCCUPATION= QUEUEOCCUPATION - QUEUE(1,1);
                QUEUE(1,:)= [];
            else
                STATE= 0;
            end
            
        case TRANSITION
            if FLOWSTATE ~= 2 
                FLOWSTATE = 2;
                rate = lambda;  
            else
                if rand() <= 0.5
                    FLOWSTATE = 1;
                    rate = 0.5*lambda;
                else
                    FLOWSTATE = 3;
                    rate = 1.5*lambda;
                end
        
            end
            EventList = [EventList; TRANSITION, Clock + exprnd(T_perm), 0, 0];
    end
end

%Performance parameters determination:
PL= 100*LOSTPACKETS/TOTALPACKETS;      % in %
APD= 1000*DELAYS/TRANSMITTEDPACKETS;   % in milliseconds
MPD= 1000*MAXDELAY;                    % in milliseconds
TT= 10^(-6)*TRANSMITTEDBYTES*8/Clock;  % in Mbps

end

function out= GeneratePacketSize()      
    aux= rand();
    aux2= [65:109 111:1517];
    if aux <= 0.16
        out= 64;
    elseif aux <= 0.16 + 0.25
        out= 110;
    elseif aux <= 0.16 + 0.25 + 0.2 
        out= 1518;
    else
        out = aux2(randi(length(aux2)));    
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function a=exprnd(b)
    a= rand();
    a= -b* log(a);
end