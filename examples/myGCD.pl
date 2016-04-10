



myGCD(A,B,G):-
    A = B,
    G = A.
myGCD(A,B,G):-
    A > B,
    C is A-B,
    myGCD(C,B,G).
myGCD(A,B,G):-
    B > A,
    C is B-A,
    myGCD(C,A,G).
