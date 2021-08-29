function [bHD, b4K]= simulator2(lambda, p, n, S, W, R, fname)
    % lambda - movies request rate (in requests per hour)
    % p = percentage of requests for 4K movies (in %)
    % n = Number of servers
    % S = capacity of each server
    % W = Resource reservation for 4K movies (in Mbps)
    % R = Number of movie requests to stop simulation
    % fname = filename
    
    invlambda=60/lambda; %average time between requests (in minutes)
    invmiu= load(fname); %duration (in minutes) of each movie
    Nmovies= length(invmiu); % number of movies
    
    % Events Definition
    DEPARTURE_HD = 1; % HD movie termination 
    DEPARTURE_4K = 2; % 4K movie termination
    ARRIVAL_HD = 0;  % HD movie arrival
    ARRIVAL_4K = 3; % 4K movie arrival
    
    % State Variables
    STATE = zeros(1, n); % Throughput of movies in transmission by server
    STATE_HD = 0; % Throughput of HD movies in transmission
    
    % Statistical counters
    NARRIVALS = 0; % Movie requests
    REQUESTS_HD = 0; % HD movie requests
    REQUESTS_4K = 0; % 4K movie requests
    BLOCKED_HD = 0; % Blocked HD movie requests
    BLOCKED_4K = 0; % Blocked 4K movie requests
    
    %Simulation Clock
    Clock = 0;
    C = S*n; % Bandwidth for a whole server farm
    
    if(rand(1)<p/100)
        new_event = ARRIVAL_4K;
    else
        new_event = ARRIVAL_HD;
    end
    EventList= [new_event exprnd(invlambda) 0];
    
    while NARRIVALS < R
        event= EventList(1,1);
        Clock= EventList(1,2);
        idx2 = EventList(1,3);
        EventList(1,:)= [];
        [Min, Idx] = min(STATE);
        if event == ARRIVAL_HD
            if(rand(1)<p/100)
                new_event = ARRIVAL_4K;
            else
                new_event = ARRIVAL_HD;
            end
            
            EventList= [EventList; new_event Clock+exprnd(invlambda) 0];
            NARRIVALS = NARRIVALS + 1;
            REQUESTS_HD = REQUESTS_HD + 1;
            if(Min+5 <= S && STATE_HD+5 <= C-W)
                STATE(1, Idx) = STATE(1, Idx) + 5;
                STATE_HD = STATE_HD + 5;
                EventList= [EventList; DEPARTURE_HD Clock+invmiu(randi(Nmovies)) Idx];
            else
                BLOCKED_HD = BLOCKED_HD + 1;
            end
        
        elseif event==ARRIVAL_4K
            if(rand(1)<p/100)
                new_event = ARRIVAL_4K;
            else
                new_event = ARRIVAL_HD;
            end
            EventList= [EventList; new_event Clock+exprnd(invlambda) 0];
            NARRIVALS = NARRIVALS + 1;
            REQUESTS_4K = REQUESTS_4K + 1;
            
            if(Min <= S-25)
                STATE(1, Idx) = STATE(1, Idx) + 25;
                EventList= [EventList; DEPARTURE_4K Clock+invmiu(randi(Nmovies)) Idx];
            
            else
                BLOCKED_4K = BLOCKED_4K + 1;
            end
            
        elseif event==DEPARTURE_HD
            STATE(1, idx2) = STATE(1, idx2) - 5;
            STATE_HD = STATE_HD - 5;
        else
            STATE(1, idx2) = STATE(1, idx2) - 25;
        end
        
        EventList= sortrows(EventList,2);
    end
    
    bHD = 100*BLOCKED_HD/REQUESTS_HD; % blocking probability in %
    b4K = 100*BLOCKED_4K/REQUESTS_4K; % blocking probability in %
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function a=exprnd(b)
    a= rand();
    a= -b* log(a);
end