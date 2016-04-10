

edge(b,a).
edge(b,d).
edge(a,c).
edge(d,c).
edge(c,e).
edge(c,f).

path(From,From).
path(From,To):-
    edge(Between,To),
    path(From,Between).
