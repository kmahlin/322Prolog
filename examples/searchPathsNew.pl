edge(a,e).
edge(b,a).
edge(b,c).
edge(c,b).
edge(c,d).
edge(c,e).
edge(d,a).
edge(d,b).
edge(d,e).
edge(e,a).
edge(e,b).
edge(e,c).
edge(e,d).

% dfSearch(From,To,Path).
dfSearch(From,From,[From]).
dfSearch(From,To,[From|Result]):-
    edge(From,Anything),
    dfSearch(Anything,To,Result).

% dfSearchSafe(From,To,Used,Path)
dfSearchSafe(From,From,_,[From]).
dfSearchSafe(From,To,Used,[From|Rest]):-
    edge(From,Anything),
    not(member(Anything,Used)),
    dfSearchSafe(Anything,To,[From|Used],Rest).

% bfSearch(From,To,Path).
bfSearch(From,From,[From]).
bfSearch(From,To,[From|Result]):-
    length(Result,ResultLength),
    edge(From,Anything),
    bfSearch(Anything,To,Result).











