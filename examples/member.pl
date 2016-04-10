% member(Element,List)
member(Element,[Element|_]).
member(Element,[_|T]):-
    member(Element,T).
