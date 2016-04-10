% ourCumSum(List,CumulativeSum)


ourCumSum(List,Result):-
    ourCumSum(List,Result,0).


ourCumSum([],[],_).
ourCumSum([H|T],[R|TailR],Value):-
    R is Value + H,
    ourCumSum(T,TailR,R).
