

fewestRotationsMultiple(Maze,R):-
  loadModule,
  removeEndOfFile(Maze,ModMaze),
  shortestSolvedPaths(ModMaze,R).
