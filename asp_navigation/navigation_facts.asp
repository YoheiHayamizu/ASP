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