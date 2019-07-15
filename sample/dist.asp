%pos(s0).
%pos(s1).
%pos(s2).
%pos(s3).
%pos(s4).
pos(s5).
pos(s6).
pos(s7).
pos(s8).
%pos(s9).

% pos(X) :- room(X).
% pos(X) :- location(X).

%acc(s0, s1).
%acc(s0, s2).
%acc(s1, s2).
%acc(s3, s4).
acc(s5, s6).
acc(s5, s7).
acc(s5, s8).
acc(s6, s7).
acc(s6, s8).
acc(s7, s8).


cost(L, X, Y) :- L=@dis(X, Y), pos(X), pos(Y).
path(X, Y) : pos(X), pos(Y) :- L1 <= L2, cost(L1, X, Y), cost(L2, X, W).


#show cost/3.
#show path/2.

%#show dist/2.