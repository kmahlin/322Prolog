
fewestRotationsSingle(Maze,R):-
  loadModule,
  removeEndOfFile(Maze,ModMaze),
  % solvedPaths(ModMaze,R).
  shortestSolvedPaths(ModMaze,R),
  % writeln(R).
  paths(R,true),
  retract(paths(R,true)).
