
notStacked(Maze,Move):-
  loadModule,
  removeEndOfFile(Maze,ModMaze),
  not(isStacked(ModMaze,Move)).
