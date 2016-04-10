% find(Element,List,Position)
find(Element,[Element|_],1).
find(Element,[_|T],Position):-
    find(Element,T,TPosition),
    Position is TPosition + 1.
