





% ourReplace(Before,From,To,After)
% ourReplace([b,a,n,a,n,a],a,e,[b,e,n,e,n,e])

ourReplace([],_,_,[]).
ourReplace([From|T],From,To,[To|ReplacedT]):-
    ourReplace(T,From,To,ReplacedT).
ourReplace([H|T],From,To,[H|ReplacedT]):-
    H \= From,
    ourReplace(T,From,To,ReplacedT).
