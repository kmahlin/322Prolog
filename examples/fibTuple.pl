% fibTuple((N,FibN,FibNP1))





fibTuple((0,0,1)).
fibTuple((N,FibN,FibNP1)):-
    length(_,N),
    N > 0,
    NM1 is N - 1,
    fibTuple((NM1,FNM1,FibN)),
    FibNP1 is FNM1 + FibN.
