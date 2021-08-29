%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Task 3a 

G=[ 1 2
 1 3
 1 4
 1 5
 1 6
 1 14
 1 15
 2 3
 2 4
 2 5
 2 7
 2 8
 3 4
 3 5
 3 8
 3 9
 3 10
 4 5
 4 10
 4 11
 4 12
 4 13
 5 12
 5 13
 5 14
 6 7
 6 16
 6 17
 6 18
 6 19
 7 19
 7 20
 8 9
 8 21
 8 22
 9 10
 9 22
 9 23
 9 24
 9 25
 10 11
 10 26
 10 27
 11 27
 11 28
 11 29
 11 30
 12 30
 12 31
 12 32
 13 14
 13 33
 13 34
 13 35
 14 36
 14 37
 14 38
 15 16
 15 39
 15 40
 20 21];

% VARIABLES
n = 6:1:40;
c = zeros(40);
c = [repelem(0, 5) repelem(12, 15-5) repelem(8, 40-15)];
vars = {};
% GRAPH
internet = graph(G(:,1), G(:,2));
plot(internet)

% ILP FILE WRITING
f = fopen('task3a.lp', 'wt');

% OBJECTIVE FUNCTION
fprintf(f, 'Minimize\n');
for i=n
    fprintf(f, ' + %f x%d', c(i), i);
end

% CONSTRAINTS
fprintf(f, '\nSubject To\n');
write = 0;
for i = n
    for j = n
        [sp, len] = shortestpath(internet, i, j);
        if len <= 2
            write = 1;
            fprintf(f, ' + x%d', j);
        end  
    end
    if write == 1
        fprintf(f, ' >= 1 \n');
    end
    write= 0;
end

% ILP BINARY VARIABLES
fprintf(f, '\nBinary\n');
for i = n
    fprintf(f, 'x%d', i);
    fprintf(f, '\n');
end

% END
fprintf(f, '\nEnd\n');
fclose(f);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%