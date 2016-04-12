:- module( helpers,
	 [ readGravityMazeFile/3
	 , printMazeGame/1
	 ]
    ).

readGravityMazeFile(File,Moves,Maze):-
    open(File,read,Input),
    read(Input,Moves),
    readMaze(Input,Maze),
    close(Input).

readMaze(Input,[]):-
    at_end_of_stream(Input),
    !.
readMaze(Input,[Row|Rows]):-
    \+ at_end_of_stream(Input),
    read(Input,Row),
    readMaze(Input,Rows).

printMazeGame([]).
printMazeGame([Row|Rows]):-
    writeln(Row),
    printMazeGame(Rows).



countRotations([],Return).
countRotations([HE|TA]],Return):-
	0 is mod(HE,2)


sumRotation
