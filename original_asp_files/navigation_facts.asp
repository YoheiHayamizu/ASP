
% DO NOT use room(a ; b). Computation takes forever.
% naming r1 for room on level 1. room number is after underscore
room(r1_m11).
room(r1_corr_m).
room(r1_corr_watson).
room(r1_corr_g).
room(r1_corr_h).
room(r1_corr_j).

% naming e1 for elevator on level 1. then room where elevator is
elevator(e1_corr_watson).

% naming d1 for door on level 1. room where this door can be found after underscore
door(d1_m11).
door(d1_corr_m_corr_watson).
door(d1_watson_office).
door(d1_corr_main_exit).
door(d1_g_labs).
door(d1_g25).
door(d1_200p).
door(d1_200q).
door(d1_l_section).
door(d1_h5).
door(d1_h9).
door(d1_downstairs).
door(d1_h11).
door(d1_upstairs).
door(d1_200f).
door(d1_j23).
door(d1_j21).
door(d1_ebk1).
door(d1_j19).
door(d1_j15).
door(d1_k_section).
door(d1_fire_exit).
door(d1_200b).
door(d1_restroom_m).
door(d1_restroom_f).
door(d1_203_janitor).



hasdoor(r1_m11, d1_m11).
hasdoor(r1_corr_m, d1_m11).
hasdoor(r1_corr_m, d1_corr_m_corr_watson).
hasdoor(r1_corr_watson,d1_corr_m_corr_watson).
hasdoor(r1_corr_watson,d1_watson_office).
hasdoor(r1_corr_watson,d1_corr_main_exit).
hasdoor(r1_corr_g,d1_g25).
hasdoor(r1_corr_h,d1_h9).



acc(r1_corr_watson, r1_corr_g).
acc(r1_corr_g, r1_corr_h).
acc(r1_corr_h, r1_corr_j).


% UNDER THIS IS OLD WILL DELETE

%what is this saying?
location(R) :- room(R).


dooracc(R1,D,R2) :- hasdoor(R1,D), hasdoor(R2,D), R1 != R2, door(D), room(R1),
location(R2).
dooracc(R1,D,R2) :- dooracc(R2,D,R1).

acc(L1,L1) :- location(L1).
acc(L1,L2) :- acc(L2,L1), location(L1), location(L2). 
acc(L1,L2) :- acc(L1,L3), acc(L2,L3), location(L1), location(L2), location(L3).


ball(b0).
ball(b1).
ball(b2).
square(s0).
square(s1).
square(s2). 
object(O) :- ball(O).
object(O) :- square(O). 

