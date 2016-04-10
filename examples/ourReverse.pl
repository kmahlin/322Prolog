
% ourReverse(Before,After)



% ourReverse([a,b,c],[c,b,a])

ourReverse([],[]).
ourReverse([H|T],Result):-
    ourReverse(T,ReverseT),
    append(ReverseT,[H],Result).
