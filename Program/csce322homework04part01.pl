% working_directory(CWD,'c:/users/kevin/documents/github/322Prolog/Program').
% consult('csce322homework04part01.pl').
% [homework04tests].
% [helpers].
% [csce322homework04part01].




% odd number of rotations, and players
% or even number of rotations, and even players.
rotationsAndPlayers(Rotations,Maze):-
  countMovesInList(Rotations,RetMoves),
  countPlayerInMaze(Maze,RetPlayers),
  ((0 is mod(RetMoves,2),
    0 is mod(RetPlayers,2));
    not(0 is mod(RetMoves,2)),
    not(0 is mod(RetPlayers,2))).
