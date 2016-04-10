% evenSum(List,Sum)
evenSum([],0).
evenSum([H|T],Sum):-
    0 is mod(H,2),
    evenSum(T,TSum),
    Sum is TSum + H.
evenSum([H|T],Sum):-
    1 is mod(H,2),
    evenSum(T,Sum).
