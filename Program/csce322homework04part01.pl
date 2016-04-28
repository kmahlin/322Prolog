
% odd number of rotations, and players
% or even number of rotations, and even players.
rotationsAndPlayers(Rotations,Maze):-
  countMovesInList(Rotations,RetMoves),
  countPlayerInMaze(Maze,RetPlayers),
  ((0 is mod(RetMoves,2),
    0 is mod(RetPlayers,2));
    not(0 is mod(RetMoves,2)),
    not(0 is mod(RetPlayers,2))).
