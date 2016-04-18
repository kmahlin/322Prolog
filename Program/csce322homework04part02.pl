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

forward(-).
goal(g).

player(1).

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
    % do the rotation and move
    bfSearch(Anything,To,Result).

%All Rotations

%RotateMaze
% rotateAndMove([],_,_).
% rotateAndMove([Hm|Tm],Maze,)
% movePlayer([],[]).
% movePlayer([Ta],[Ta]).
% movePlayer([He,Mi|Ta],Result):-
%   movePlayer(Ta,[He|TA]).

movePlayer([],_):- !.
movePlayer([He|Ta],Result):-
  not(He is 1),
  movePlayer(Ta,Result),
  !.
movePlayer([He|Ta],Result):-
    swap([He|Ta],R1),
    movePlayer(R1,Result),
    !.

% dropHead([He|Ta],Ta).


bubblesort(List,SortedList):-
    swap1(List,List1),
    ! ,
    bubblesort(List1,SortedList).
bubblesort(List,List).


swap1([X,Y|Rest],[-,X|Rest]):-
    X is 1,
    goal(Y),
    !.

swap1([X,Y|Rest],[Y,X|Rest]):-
    X is 1,
    forward(Y),
    !.


    % X > Y, !.
swap1([Z|Rest],[Z|Rest1]):-
    swap1(Rest,Rest1).




swap([],[]).
swap([He,Mi|Ta],[Mi,He|Ta]):- !.
  %  swap(Ta,Ra).
% swap([He|Ta],Result):-
%   swap(Ta,Result).





% movePlayer([HE,MI|TA],Result):-
%   player(HE),
%   forward(MI),
%   movePlayer([HE|TA],Result),
%   !.

list_swappedcouples([],[]).
list_swappedcouples([A],[A]).
list_swappedcouples([A,B|Xs],[B,A|Ys]) :-
   list_swappedcouples(Xs,Ys).




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
