% dropn(Before,N,After)
dropn(Before,0,Before).
dropn([],_,[]).
dropn([_|T],N,DropT):-
    length(_,N),
    N > 0,
    NM1 is N - 1,
    dropn(T,NM1,DropT).
