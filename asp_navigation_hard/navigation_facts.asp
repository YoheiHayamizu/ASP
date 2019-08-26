location(s0).
room    (s1).
room    (s2).
location(s3).
room    (s4).
room    (s5).
location(s6).
room    (s7).
room    (s8).
room    (s9).
room    (s10).
room    (s11).
room    (s12).
location(s13).
room    (s14).
room    (s15).
location(s16).
room    (s17).
room    (s18).
room    (s19).
location(s20).
room    (s21).
room    (s22).
location(s23).
room    (s24).
location(s25).
room    (s26).
location(s27).
room    (s28).
location(s29).
room    (s30).
location(s31).
room    (s32).
location(s33).

% naming d1 for door on level 1. location where this door can be found after underscore
door(d0).
door(d1).
door(d2).
door(d3).
door(d4).
door(d5).
door(d6).
door(d7).
door(d8).
door(d9).
door(d10).

hasdoor(s1, d1).
hasdoor(s2, d2).
hasdoor(s4, d3).
hasdoor(s5, d4).
hasdoor(s7, d0).
hasdoor(s8, d3).
hasdoor(s9, d4).
hasdoor(s10, d5).
hasdoor(s11, d6).
hasdoor(s12, d2).
hasdoor(s14, d7).
hasdoor(s15, d8).
hasdoor(s17, d9).
hasdoor(s18, d10).
hasdoor(s19, d1).
hasdoor(s21, d0).
hasdoor(s22, d5).
hasdoor(s24, d6).
hasdoor(s26, d7).
hasdoor(s28, d8).
hasdoor(s30, d9).
hasdoor(s32, d10).

% Accecibility

acc(s0, s1). acc(s0, s2). acc(s1, s2).
acc(s3, s4). acc(s3, s5). acc(s4, s5).
acc(s6, s7). acc(s6, s8). acc(s6, s9). acc(s6, s10). acc(s6, s11). acc(s6, s12). acc(s6, s13). acc(s6, s14). acc(s6, s15). acc(s6, s16). acc(s6, s17). acc(s6, s18). acc(s6, s19). acc(s6, s20). acc(s6, s21).
acc(s7, s8). acc(s7, s9). acc(s7, s10). acc(s7, s11). acc(s7, s12). acc(s7, s13). acc(s7, s14). acc(s7, s15). acc(s7, s16). acc(s7, s17). acc(s7, s18). acc(s7, s19). acc(s7, s20). acc(s7, s21).
acc(s8, s9). acc(s8, s10). acc(s8, s11). acc(s8, s12). acc(s8, s13). acc(s8, s14). acc(s8, s15). acc(s8, s16). acc(s8, s17). acc(s8, s18). acc(s8, s19). acc(s8, s20). acc(s8, s21).
acc(s9, s10). acc(s9, s11). acc(s9, s12). acc(s9, s13). acc(s9, s14). acc(s9, s15). acc(s9, s16). acc(s9, s17). acc(s9, s18). acc(s9, s19). acc(s9, s20). acc(s9, s21).
acc(s10, s11). acc(s10, s12). acc(s10, s13). acc(s10, s14). acc(s10, s15). acc(s10, s16). acc(s10, s17). acc(s10, s18). acc(s10, s19). acc(s10, s20). acc(s10, s21).
acc(s11, s12). acc(s11, s13). acc(s11, s14). acc(s11, s15). acc(s11, s16). acc(s11, s17). acc(s11, s18). acc(s11, s19). acc(s11, s20). acc(s11, s21).
acc(s12, s13). acc(s12, s14). acc(s12, s15). acc(s12, s16). acc(s12, s17). acc(s12, s18). acc(s12, s19). acc(s12, s20). acc(s12, s21).
acc(s13, s14). acc(s13, s15). acc(s13, s16). acc(s13, s17). acc(s13, s18). acc(s13, s19). acc(s13, s20). acc(s13, s21).
acc(s14, s15). acc(s14, s16). acc(s14, s17). acc(s14, s18). acc(s14, s19). acc(s14, s20). acc(s14, s21).
acc(s15, s16). acc(s15, s17). acc(s15, s18). acc(s15, s19). acc(s15, s20). acc(s15, s21).
acc(s16, s17). acc(s16, s18). acc(s16, s19). acc(s16, s20). acc(s16, s21).
acc(s17, s18). acc(s17, s19). acc(s17, s20). acc(s17, s21).
acc(s18, s19). acc(s18, s20). acc(s18, s21).
acc(s19, s20). acc(s19, s21).
acc(s20, s21).

% acc(s1, s19).
% acc(s2, s12).
% acc(s4, s8).
% acc(s5, s9).

% acc(s10, s22).
acc(s22, s23).
% acc(s11, s24).
acc(s24, s25).
% acc(s14, s26).
acc(s26, s27).
% acc(s15, s28).
acc(s28, s29).
% acc(s17, s30).
acc(s30, s31).
% acc(s18, s32).
acc(s32, s33).

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