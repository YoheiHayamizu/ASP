
% DO NOT use location(a ; b). Computation takes forever.
% naming L1 for location on level 1. location number is after underscore
room(s0).
location(s1).
location(s2).
room(s3).
location(s4).
location(s5).
location(s6).
room(s7).
location(s8).
location(s9).
room(s10).
location(s11).
location(s12).
room(s13).
location(s14).


% naming e1 for elevator on level 1. then location where elevator is
elevator(e1_corr_watson).

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

% UNDER THIS IS OLD WILL DELETE

%what is this saying?
% room(R) :- location(R).


dooracc(L1,D,L2) :- hasdoor(L1,D), hasdoor(L2,D), L1 != L2, door(D), location(L1), location(L2).
dooracc(L1,D,L2) :- dooracc(L2,D,L1).


acc(R1,R1) :- room(R1).
acc(L1,R1) :- acc(R1,L1), location(L1), room(R1).
acc(L1,R1) :- acc(L1,L2), acc(R1,L2), location(L1), room(R1), location(L2).
acc(L1,R1) :- acc(L1,R2), acc(R1,R2), location(L1), room(R1), room(R2).

acc(R1,L1) :- acc(L1,R1), location(L1), room(R1).
acc(R1,L1) :- acc(R1,L2), acc(L1,L2), location(L1), room(R1), location(L2).
acc(R1,L1) :- acc(R1,R2), acc(L1,R2), location(L1), room(R1), room(R2).

acc(L1,L1) :- location(L1).
acc(L1,L2) :- acc(L2,L1), location(L1), location(L2). 
acc(L1,L2) :- acc(L1,L3), acc(L2,L3), location(L1), location(L2), location(L3).