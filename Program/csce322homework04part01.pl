% working_directory(CWD,'c:/users/kevin/documents/github/322Prolog/Program').
% consult('csce322homework04part01.pl').
% [homework04tests].
% [helpers].
% [csce322homework04part01].

player(1).
player(2).
player(3).
player(4).

move(c).
move(cc).
move(180).


% odd number of rotations, and players
% or even number of rotations, and even players.
rotationsAndPlayers(Rotations,Maze):-
  countMovesInList(Rotations,RetMoves),
  countPlayerInMaze(Maze,RetPlayers),
  ((0 is mod(RetMoves,2),
    0 is mod(RetPlayers,2));
    not(0 is mod(RetMoves,2)),
    not(0 is mod(RetPlayers,2))).


countMovesInList([],0):- !.
countMovesInList([HE|TA],R):-
  not(move(HE)),
  countMovesInList(TA,R).

countMovesInList([HE|TA],R):-
  countMovesInList(TA,R2),
  R is R2 + 1.


countPlayerInMaze(Maze,R):-
  flatten(Maze,R2),
  countPlayersInList(R2,R3),
  R is R3.

countPlayersInList([],0):- !.
countPlayersInList([HE|TA],R):-
  not(player(HE)),
  countPlayersInList(TA,R)
  ,!.

countPlayersInList([HE|TA],R):-
  countPlayersInList(TA,R2),
  R is R2 + 1.
