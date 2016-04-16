% working_directory(CWD,'c:/users/kevin/documents/github/322Prolog/Program').
% consult('csce322homework04part01.pl').
% [homework04tests].
% [helpers].
% [csce322homework04part02].

use_module(library(clpfd), []).

% edge(move(c),move(c)).
% edge(move(c),move(cc)).
% edge(move(c),move(180)).
%
% edge(move(cc),move(c)).
% edge(move(cc),move(cc)).
% edge(move(cc),move(180)).
%
% edge(move(180),move(c)).
% edge(move(180),move(cc)).
% edge(move(180),move(180)).

edge(c,c).
edge(cc,c).
edge(180,c).

edge(c,cc).
edge(cc,cc).
edge(180,cc).

edge(c,180).
edge(cc,180).
edge(180,180).


move(c).
move(cc).
move(180).


fewestRotationsSingle(Maze,[180,180,180]).
% use this
% bfSearch(Move, Move,List).

% bfSearch(From,To,Path).
% bfSearch(From,From,[From]).
% bfSearch(From,To,[From|Result]):-
%     length(Result,ResultLength),
%     % writeln(ResultLength),
%     ResultLength =< 6,
%     edge(From,Anything),
%     bfSearch(Anything,To,Result).


bfSearch(From,From,[From]).
bfSearch(From,To,[From|Result]):-
    length(Result,ResultLength),
    % writeln(ResultLength),
    ResultLength =< 6,
    edge(From,Anything),
    bfSearch(Anything,To,Result).



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
