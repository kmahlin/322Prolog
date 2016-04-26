

fewestRotationsMultiple(Maze,R):-
  loadModule,
  removeEndOfFile(Maze,ModMaze),
  solvedPaths(ModMaze,R).
