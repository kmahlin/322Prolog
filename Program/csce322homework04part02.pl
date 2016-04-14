% working_directory(CWD,'c:/users/kevin/documents/github/322Prolog/Program').
% consult('csce322homework04part01.pl').
% [homework04tests].
% [helpers].
% [csce322homework04part01].






use_module(library(clpfd), []).

fewestRotationsSingle(Maze,[180,180,180]).





% Lets work on Rotations
% rotate c
rotateClockWise(Maze,R):-
  transpose(Maze,R).


% rotate cc

% rotate 180
