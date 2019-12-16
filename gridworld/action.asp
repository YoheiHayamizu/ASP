%%%%% Dynamics
%generate exactly one action, unless noop is set. This is used for planning.

1{up(X, Y, I) : pos(X, Y);
  right(X, Y, I) : pos(X, Y);
  left(X, Y, I) : pos(X, Y);
  down(X, Y, I) : pos(X, Y)}1 :- not noop(I), I=0..n-2.

noop(n).

%#hide noop/1.
