#const max_y = 4.
#const max_x = 4.

% up causes at(X,Y+1) if at(X,Y).
% nonexecutable up if at(X,max_y).
% nonexecutable up if at(X,Y,I), obst(X,Y,X,Y+1,I).

at(X, Y+1, I+1) :- up(X, Y, I), at(X, Y, I), pos(X, Y), I=0..n-2.
:- up(X, Y, I), at(0..max_x, max_y, I), pos(X, Y).
:- up(X, Y, I), -at(X, Y, I), pos(X, Y).
:- up(X, Y, I), at(X, Y, I), obst(X, Y, X, Y+1, I).

at(X+1, Y, I+1) :- right(X, Y, I), at(X,Y,I), pos(X, Y), I=0..n-2.
:- right(X, Y, I), at(max_x, 0..max_y, I), pos(X, Y).
:- right(X, Y, I), -at(X, Y, I), pos(X, Y).
:- right(X, Y, I), at(X, Y, I), obst(X, Y, X+1, Y, I).

at(X-1,Y,I+1) :- left(X, Y, I), at(X, Y, I), pos(X, Y), I=0..n-2.
:- left(X, Y, I), at(0, 0..max_y, I), pos(X, Y).
:- left(X, Y, I), -at(X, Y, I), pos(X, Y).
:- left(X, Y, I), at(X, Y, I), obst(X, Y, X-1, Y, I).

at(X,Y-1,I+1) :- down(X, Y, I),at(X, Y, I), pos(X, Y), I=0..n-2.
:- down(X, Y, I), at(0..max_x, 0, I), pos(X, Y).
:- down(X, Y, I), -at(X, Y, I), pos(X, Y).
:- down(X, Y, I), at(X, Y, I), obst(X, Y, X, Y-1, I).


%%%%% System
%% if you are somewhere, you are not anywhere else
-at(X, Y, I) :- at(Z, K, I), pos(Z, K), pos(X, Y), Z != X, X=0..max_x, Y=0..max_y, I=0..n-1.
-at(X, Y, I) :- at(Z, K, I), pos(Z, K), pos(X, Y), K != Y, X=0..max_x, Y=0..max_y, I=0..n-1.

% %% at is inertial
at(X, Y, I+1) :- at(X, Y, I), not -at(X,Y,I+1), I=0..n-2.


obst(X2,Y2,X1,Y1,I) :- obst(X1,Y1,X2,Y2,I).

%obstacles that are always there
obst(X, Y, X+1, Y, I):- X=0..1, Y=1, I=0..n-1.
obst(X, Y, X+1, Y, I):- X=2..3, Y=1, I=0..n-1.
obst(X, Y, X+1, Y, I):- X=0..1, Y=2, I=0..n-1.
obst(X, Y, X+1, Y, I):- X=2..3, Y=2, I=0..n-1.
obst(X, Y, X+1, Y, I):- X=2..3, Y=3, I=0..n-1.

obst(X, Y, X, Y+1, I):- X=0, Y=1..2, I=0..n-1.
obst(X, Y, X, Y+1, I):- X=1, Y=0..2, I=0..n-1.
obst(X, Y, X, Y+1, I):- X=3, Y=0..3, I=0..n-1.

%if at some point you know about an obstacle, it doesn't go away
obst(X,Y,Z,K,I) :- obst(X,Y,Z,K,I-1), not -obst(X,Y,Z,K,I), I=0..n-1.


%useless rule to suppress clingo's warning about -obst not beind defined.
%-obst will be set as an observation in the current state if necessary
-obst(0,0,0,1,I) :- I=0..n-1.