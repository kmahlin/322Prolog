printPaths([]).
printPaths([Path|Paths]):-
    writeln(Path),
    printPaths(Paths).

loadHelpers:-
    ['helpers'],
    ['csce322homework04part01'],
    ['csce322homework04part02'],
    ['csce322homework04part03'],
    ['csce322homework04part04'].


test:-
  readGravityMazeFile('c:/users/kevin/documents/github/322Prolog/Test/part01test01.g',Rotations,Maze),
  writeln(aaaaaaaa),
  removeEndOfFile(Maze,R).

part01:-
    readGravityMazeFile('c:/users/kevin/documents/github/322Prolog/Test/part01test01.g',Rotations,Maze),
    writeln(rotations),
    writeln(Rotations),
    writeln(maze),
    printMazeGame(Maze),
    rotationsAndPlayers(Rotations,Maze).

part02:-
    readGravityMazeFile('c:/users/kevin/documents/github/322Prolog/Test/part02test01.g',_,Maze),
    writeln(maze),
    printMazeGame(Maze),
    setof(Moves,fewestRotationsSingle(Maze,Moves),Paths),
    writeln(paths),
    printPaths(Paths).

part03:-
    readGravityMazeFile('c:/users/kevin/documents/github/322Prolog/Test/part03test01.g',_,Maze),
    writeln(maze),
    printMazeGame(Maze),
    setof(Moves,fewestRotationsMultiple(Maze,Moves),Paths),
    writeln(paths),
    printPaths(Paths).


part04:-
    readGravityMazeFile('c:/users/kevin/documents/github/322Prolog/Test/part04test01.g',[Rotation|_],Maze),
    writeln(rotation),
    writeln(Rotation),
    writeln(maze),
    printMazeGame(Maze),
    notStacked(Maze,Rotation).
