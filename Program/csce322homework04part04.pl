notStacked(Maze,Move):-
  loadModule,
  not(isStacked(Maze,Move)).
