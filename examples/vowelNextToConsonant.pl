



vowel(a).
vowel(e).
vowel(i).
vowel(o).
vowel(u).

consonant(Letter):-
    not(vowel(Letter)).

vowelNextToConsonant([H,N|_]):-
    vowel(H),
    consonant(N),
    !.
vowelNextToConsonant([H,N|_]):-
    consonant(H),
    vowel(N),
    !.
vowelNextToConsonant([_,N|T]):-
    vowelNextToConsonant([N|T]).
