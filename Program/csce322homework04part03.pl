

fewestRotationsMultiple(Maze,R):-
  loadModule,
  removeEndOfFile(Maze,ModMaze),
  shortestSolvedPaths(ModMaze,R),
  paths(R,true),
  retract(paths(R,true)).
