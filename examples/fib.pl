% fib(N,FibN)
fib(0,0).
fib(1,1).
fib(N,FibN):-
    length(_,N),
    N > 1,
    NM1 is N-1,
    NM2 is N-2,
    fib(NM1,FNM1),
    fib(NM2,FNM2),
    FibN is FNM1 + FNM2.
