
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Actions
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
at(L2,I+1) :- approach(D,I), at(L1,I), hasdoor(L2,D), acc(L1,L2),I=0..n-2.
facing(D,I+1) :- approach(D,I), door(D), I=0..n-2.
beside(D,I+1) :- approach(D,I), door(D), I=0..n-2.
:- approach(D,I), facing(D,I), door(D), I=0..n-1.
:- approach(D,I), at(L1,I), door(D), dooracc(L3,D,L2), not acc(L1,L3), not acc(L1,L2), I=0..n-1.
% :- approach(D2, I), door(D1), door(D2), location(L), @dis(D1, D2, L) > @dis(D2, D1, L), I=0..n-1.

at(R,I+1) :- goto(R,I), at(L,I), acc(R,L), location(L), I=0..n-2.
-facing(D,I+1) :- goto(R,I), door(D), I=0..n-2.
-beside(D,I+1) :- goto(R,I), door(D), I=0..n-2.
:- goto(R,I), at(R,I), room(R), I=0..n-1.
:- goto(R2,I), at(R1,I), not acc(R1,R2), room(R1), I=0..n-1.
:- goto(R2,I), at(R1,I), not acc(R1,R2), not acc(R2,L1), not acc(R1,L1), location(L1), I=0..n-1.
:- goto(R1,I), at(L1,I), not acc(R1,L1), room(R1), location(L1), I=0..n-1.

at(L2,I+1) :- gothrough(D,I), at(L1,I), dooracc(L1,D,L2), location(L1), location(L2), I=0..n-2.
-facing(D,I+1) :- gothrough(D,I), I=0..n-2.
:- gothrough(D,I), not facing(D,I), door(D), I=0..n-1.
:- gothrough(D,I), not open(D,I), door(D), I=0..n-1.
:- gothrough(D,I), at(R,I), not hasdoor(R,D), door(D), location(R), I=0..n-1.


open(D,I+1) :- opendoor(D,I), door(D), I=0..n-2.
:- opendoor(D,I), not facing(D,I), door(D), I=0..n-1.
:- opendoor(D,I), open(D,I), door(D), I=0..n-1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Static laws
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%you can't be at two places at the some time
-at(L1,I):- at(R1,I), location(L1), room(R1), R1 != L1, I=0..n-1.
-at(L2,I):- at(L1,I), location(L2), L1 != L2, I=0..n-1.
-at(R1,I):- at(L1,I), room(R1), location(L1), R1 != L1, I=0..n-1.
-at(R2,I):- at(R1,I), room(R2), R1 != R2, I=0..n-1.


%you can be facing only one door at a time
-facing(D2,I):- facing(D1,I), door(D2), D1 != D2, I=0..n-1.

%you can only be beside a door at any given time (if you delete this, 
%the observations must also return -beside which doesn't happen at the moment.
-beside(D2,I):- beside(D1,I), door(D2), D1 != D2, I=0..n-1.
-beside(D,I+1) :- beside(D,I), at(R,I+1), not hasdoor(R,D), door(D), I=0..n-2.


% -located(O,L1,I) :- located(O,L2,I), location(L1), location(L2), L1 != L2, I=0..n-1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Inertia
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%at is inertial
at(L,I+1) :- at(L,I), not -at(L,I+1), I=0..n-2.

%facing is inertial
facing(D,I+1) :- facing(D,I), not -facing(D,I+1), I=0..n-2.
-facing(D,I+1) :- -facing(D,I), not facing(D,I+1), I=0..n-2.

% open is inertial
open(D,I+1) :- open(D,I), not -open(D,I+1), I=0..n-2.
-open(D,I+1) :- -open(D,I), not open(D,I+1), I=0..n-2.

% beside is inertial
beside(D,I+1) :- beside(D,I), not -beside(D,I+1), I=0..n-2.
-beside(D,I+1) :- -beside(D,I), not beside(D,I+1), I=0..n-2.

% located is inertial
% located(O,R,I+1) :- located(O,R,I), not -located(O,R,I+1), I=0..n-2.
% -located(O,R,I+1) :- -located(O,R,I), not located(O,R,I+1), I=0..n-2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Initial
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%hide fluents implied by others
%#hide -at/2.
%#hide -facing/2.
%#hide -beside/2.



