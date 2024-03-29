function [b o]= simulator1(lambda,C,M,R,fname)
    %lambda = request arrival rate (in requests per hour)
    %C=       Internet connection capacity (in Mbps)
    %M=       throughput of each movie (in Mbps)
    %R=       stop simulation on ARRIVAL no. R
    %fname=   filename with the duration of each movie
    
    invlambda=60/lambda;     %average time between requests (in minutes)
    invmiu= load(fname);     %duration (in minutes) of each movie
    Nmovies= length(invmiu); % number of movies
    
    %Events definition:
    ARRIVAL= 0;        %movie request
    DEPARTURE= 1;      %termination of a movie transmission
    %State variables initialization:
    STATE= 0;
    %Statistical counters initialization:
    OCCUPATION= 0;
    REQUESTS= 0;
    BLOCKED= 0;
    %Simulation Clock and initial List of Events:
    Clock= 0;
    EventList= [ARRIVAL exprnd(invlambda)];
 
    while REQUESTS < R
        event= EventList(1,1);
        Previous_Clock= Clock;
        Clock= EventList(1,2);
        EventList(1,:)= [];
        OCCUPATION= OCCUPATION + STATE*(Clock-Previous_Clock);
        if event == ARRIVAL
            EventList= [EventList; ARRIVAL Clock+exprnd(invlambda)];
            REQUESTS= REQUESTS+1;
            if STATE + M <= C
                STATE= STATE+M;
                EventList= [EventList; DEPARTURE Clock+invmiu(randi(Nmovies))];
            else
                BLOCKED= BLOCKED+1;
            end
        else
            STATE= STATE-M;
        end
        EventList= sortrows(EventList,2);
    end
    b= 100*BLOCKED/REQUESTS;    % blocking probability in %
    o= OCCUPATION/Clock;         % average occupation in Mbps
end

function a=exprnd(b)
    a= rand();
    a= -b* log(a);
end

