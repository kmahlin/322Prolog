% ourLength(List,Length).
ourLength([],0).
ourLength([_|T],Length):-
    ourLength(T,TLength),
    Length is TLength + 1.
