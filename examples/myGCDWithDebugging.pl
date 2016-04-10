



myGCD(A,B,G):-
    writeln(first),
    A = B,
    G = A,
    writeln(doneFirst).
myGCD(A,B,G):-
    writeln(second),
    A > B,
    C is A-B,
    myGCD(C,B,G),
    writeln(doneSecond).
myGCD(A,B,G):-
    writeln(third),
    B > A,
    C is B-A,
    myGCD(C,A,G),
    writeln(doneThird).
