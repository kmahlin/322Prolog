






poweroftwo(0,1):-!.
poweroftwo(A,B):-
    0 is mod(A,2),
    C is A / 2,
    poweroftwo(C,D),
    B is D**2.
poweroftwo(A,B):-
    1 is mod(A,2),
    C is A - 1,
    poweroftwo(C,D),
    B is D * 2.
