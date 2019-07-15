at(s0, 0).
:- not at(s10, n-1).

%#show approach/2.

%#show gothrough/2.

%#show opendoor/2.

%#show goto/2.

%#show cost/3.

#show path/3.

%#show at/2.

%#show beside/2.

%#show facing/2.

#minimize { L,X,Y,I: path(X,Y,I), cost(X,Y,L)}.
                