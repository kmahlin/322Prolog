% working_directory(CWD,'c:/users/kevin/documents/github/322Prolog/Program').
% consult('csce322homework04part01.pl').
% [homework04tests].
% [helpers].
% [csce322homework04part02].

use_module(library(clpfd), []).

fewestRotationsSingle(Maze,[180,180,180]).



% Lets work on Rotations
% rotate c
rotateClockWise(Maze,R):-
  reverse(Maze,RMaze),
  clpfd:transpose(RMaze,R).

% rotate cc
rotateCounterClockWise(Maze,R):-
  clpfd:transpose(Maze,TMaze),
  reverse(TMaze,R).


% rotate 180
  rotateOneEighty(Maze,R):-
    rotateClockWise(Maze,R1),
    rotateClockWise(R1,R).
