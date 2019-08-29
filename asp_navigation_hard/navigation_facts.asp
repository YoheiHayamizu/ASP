location(s0).
room    (s1).
room    (s2).
room    (s3).
room    (s4).
location(s5).
location(s6).
location(s7).
room    (s8).
room    (s9).
location(s10).
room    (s11).
room    (s12).
location(s13).
location(s14).
location(s15).
room    (s16).
room    (s17).
location(s18).
room    (s19).
room    (s20).
location(s21).
location(s22).
location(s23).
location(s24).
location(s25).

% naming d1 for door on level 1. location where this door can be found after underscore
door(d0).
door(d1).
door(d2).
door(d3).
door(d4).
door(d5).

hasdoor(s1, d0).
hasdoor(s2, d1).
hasdoor(s3, d0).
hasdoor(s4, d1).
hasdoor(s8, d2).
hasdoor(s9, d2).
hasdoor(s11, d3).
hasdoor(s12, d3).
hasdoor(s16, d4).
hasdoor(s17, d4).
hasdoor(s19, d5).
hasdoor(s20, d5).

% Accecibility

acc(s0, s1). acc(s0, s2). acc(s1, s2).
acc(s3, s4). acc(s3, s5). acc(s3, s6). acc(s3, s7). acc(s3, s8). acc(s3, s10). acc(s3, s11). acc(s3, s17). acc(s3, s20). acc(s3, s21). acc(s3, s22). acc(s3, s23). acc(s3, s24). acc(s3, s25).
acc(s4, s5). acc(s4, s6). acc(s4, s7). acc(s4, s8). acc(s4, s10). acc(s4, s11). acc(s4, s17). acc(s4, s20). acc(s4, s21). acc(s4, s22). acc(s4, s23). acc(s4, s24). acc(s4, s25).
acc(s5, s6). acc(s5, s7). acc(s5, s8). acc(s5, s10). acc(s5, s11). acc(s5, s17). acc(s5, s20). acc(s5, s21). acc(s5, s22). acc(s5, s23). acc(s5, s24). acc(s5, s25).
acc(s6, s7). acc(s6, s8). acc(s6, s10). acc(s6, s11). acc(s6, s17). acc(s6, s20). acc(s6, s21). acc(s6, s22). acc(s6, s23). acc(s6, s24). acc(s6, s25).
acc(s7, s8). acc(s7, s10). acc(s7, s11). acc(s7, s17). acc(s7, s20). acc(s7, s21). acc(s7, s22). acc(s7, s23). acc(s7, s24). acc(s7, s25).
acc(s8, s10). acc(s8, s11). acc(s8, s17). acc(s8, s20). acc(s8, s21). acc(s8, s22). acc(s8, s23). acc(s8, s24). acc(s8, s25).
acc(s10, s11). acc(s10, s17). acc(s10, s20). acc(s10, s21). acc(s10, s22). acc(s10, s23). acc(s10, s24). acc(s10, s25).
acc(s11, s17). acc(s11, s20). acc(s11, s21). acc(s11, s22). acc(s11, s23). acc(s11, s24). acc(s11, s25).
acc(s17, s20). acc(s17, s21). acc(s17, s22). acc(s17, s23). acc(s17, s24). acc(s17, s25).
acc(s20, s21). acc(s20, s22). acc(s20, s23). acc(s20, s24). acc(s20, s25).
acc(s21, s22). acc(s21, s23). acc(s21, s24). acc(s21, s25).
acc(s22, s23). acc(s22, s24). acc(s22, s25).
acc(s23, s24). acc(s23, s25).
acc(s24, s25).
acc(s9, s12). acc(s9, s13). acc(s9, s14). acc(s9, s15). acc(s9, s16). acc(s9, s18). acc(s9, s19).
acc(s12, s13). acc(s12, s14). acc(s12, s15). acc(s12, s16). acc(s12, s18). acc(s12, s19).
acc(s13, s14). acc(s13, s15). acc(s13, s16). acc(s13, s18). acc(s13, s19).
acc(s14, s15). acc(s14, s16). acc(s14, s18). acc(s14, s19).
acc(s15, s16). acc(s15, s18). acc(s15, s19).
acc(s16, s18). acc(s16, s19).
acc(s18, s19).


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