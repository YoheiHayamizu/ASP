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

location(s0).
room    (s1).
room    (s2).
location(s3).
room    (s4).
room    (s5).
room    (s6).
location(s7).
room    (s8).
room    (s9).
location(s10).
room    (s11).
room    (s12).
location(s13).
room    (s14).

% naming d1 for door on level 1. location where this door can be found after underscore
door(d0).
door(d1).
door(d2).
door(d3).
door(d4).

hasdoor(s2, d0).
hasdoor(s5, d0).
hasdoor(s4, d1).
hasdoor(s6, d1).
hasdoor(s1, d2).
hasdoor(s14, d2).
hasdoor(s11, d3).
hasdoor(s12, d3).
hasdoor(s8, d4).
hasdoor(s9, d4).

% Accecibility

acc(s0, s1).
acc(s0, s2).
acc(s1, s2).
acc(s3, s4).
acc(s5, s6).
acc(s5, s7).
acc(s5, s8).
acc(s6, s7).
acc(s6, s8).
acc(s7, s8).
acc(s9, s11).
acc(s10, s9).
acc(s10, s11).
acc(s12, s13).
acc(s12, s14).
acc(s13, s14).


dooracc(R1,D,R2) :- hasdoor(R1,D), hasdoor(R2,D), R1 != R2, door(D), room(R1), room(R2).
dooracc(R1,D,R2) :- dooracc(R2,D,R1).


acc(L,L) :- location(L).
acc(L1,L2) :- acc(L2,L1), location(L1), location(L2).
acc(L1,L2) :- acc(L1,_L), acc(L2,_L), location(L1), location(L2), location(_L).

acc(R,R) :- room(R).
acc(R1,R2) :- acc(R2,R1), room(R1), room(R2).
acc(R1,R2) :- acc(R1,_R), acc(R2,_R), room(R1), room(R2), room(_R).

acc(R,L) :- acc(L,R), room(R), location(L).
acc(L,R) :- acc(R,L), room(R), location(L).
acc(R,L) :- acc(R,_R), acc(L,_R), room(R), location(L), room(_R).
acc(L,R) :- acc(L,_L), acc(R,_L), room(R), location(L), location(_L).

pos(X) :- location(X).
pos(X) :- room(X).
cost(X, Y, L) :- L=@dis(X, Y), pos(X), pos(Y).
path(X, Y, I+1) :- at(X, I), at(Y, I+1), I=0..n-2.

%LIST HERE ANY ACTION YOU ADD!!!

1{	approach(D,I) : door(D);
	gothrough(D,I) : door(D);
	opendoor(D,I) : door(D);
	goto(L,I) : location(L)
	}1 :- not noop(I), I=0..n-2.

%removes the warning about noop not being defined, shouldn't have any consequences
noop(n).

%#hide noop/1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Actions
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
at(R2,I+1) :- approach(D,I), at(R1,I), hasdoor(R2,D), acc(R1,R2), I=0..n-2.
facing(D,I+1) :- approach(D,I), door(D), I=0..n-2.
beside(D,I+1) :- approach(D,I), door(D), I=0..n-2.
:- approach(D,I), facing(D,I), door(D), I=0..n-1.
:- approach(D,I), at(R1,I), door(D), dooracc(R3,D,R2), not acc(R1,R3), not acc(R1,R2), I=0..n-1.


at(L,I+1) :- goto(L,I), at(R,I), acc(L,R), I=0..n-2.
:- goto(L,I), at(L,I), I=0..n-1.
:- goto(L2,I), at(L1,I), not acc(L1,L2), I=0..n-1.
:- goto(L2,I), at(L1,I), acc(R1,L2), not acc(L1,L2), not acc(L1,R1), I=0..n-1.

at(R2,I+1) :- gothrough(D,I), at(R1,I), dooracc(R1,D,R2), room(R1), room(R2), I=0..n-2.
-facing(D,I+1) :- gothrough(D,I), I=0..n-2.
:- gothrough(D,I), not facing(D,I), door(D), I=0..n-1.
:- gothrough(D,I), not open(D,I), door(D), I=0..n-1.
:- gothrough(D,I), at(R,I), not hasdoor(R,D), door(D), room(R), I=0..n-1.


open(D,I+1) :- opendoor(D,I), door(D), I=0..n-2.
:- opendoor(D,I), not facing(D,I), door(D), I=0..n-1.
:- opendoor(D,I), open(D,I), door(D), I=0..n-1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Static laws
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%you can't be at two places at the some time
-at(R1,I):- at(L1,I), room(R1),     location(L1), R1 != L1, I=0..n-1.
-at(R1,I):- at(R2,I), room(R1),     room(R2),     R1 != R2, I=0..n-1.
-at(L1,I):- at(L2,I), location(L1), location(L2), L1 != L2, I=0..n-1.
-at(L1,I):- at(R1,I), location(L1), room(R1),     L1 != R1, I=0..n-1.

%you can be facing only one door at a time
-facing(D2,I):- facing(D1,I), door(D2), D1 != D2, I=0..n-1.

%you can only be beside a door at any given time (if you delete this,
%the observations must also return -beside which doesn't happen at the moment.
-beside(D2,I):- beside(D1,I), door(D2), D1 != D2, I=0..n-1.
-beside(D,I+1) :- beside(D,I), at(L,I+1), not hasdoor(L,D), door(D), I=0..n-2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Inertia
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%at is inertial
at(R,I+1) :- at(R,I), not -at(R,I+1), I=0..n-2.

%facing is inertial
facing(D,I+1) :- facing(D,I), not -facing(D,I+1), I=0..n-2.
-facing(D,I+1) :- -facing(D,I), not facing(D,I+1), I=0..n-2.

% open is inertial
open(D,I+1) :- open(D,I), not -open(D,I+1), I=0..n-2.
-open(D,I+1) :- -open(D,I), not open(D,I+1), I=0..n-2.

% beside is inertial
beside(D,I+1) :- beside(D,I), not -beside(D,I+1), I=0..n-2.
-beside(D,I+1) :- -beside(D,I), not beside(D,I+1), I=0..n-2.



