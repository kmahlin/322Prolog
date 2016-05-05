
% iBeforeE(ListBefore,ListAfter)
iBeforeE([],[]).
iBeforeE([i|T],Result):-
    iBeforeE(T,ResultT),
    insertI(i,ResultT,Result).
iBeforeE([H|T],[H|Result]):-
    char_type(H,lower),
    H \= i,
    iBeforeE(T,Result).

% insertI(I,Before,After)
insertI(i,[],[i]).
insertI(i,[e|T],[i|Result]):-
    iBeforeE([e|T],Result).
insertI(i,[H|T],[H|Result]):-
    char_type(H,lower),
    H \= e,
    insertI(i,T,Result).
