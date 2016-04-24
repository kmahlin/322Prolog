% working_directory(CWD,'c:/users/kevin/documents/github/322Prolog/Program').
% consult('csce322homework04part01.pl').
% [homework04tests].
% [helpers].
% [csce322homework04part02].

loadModule:-
  use_module(library(clpfd), []).

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
player(2).

badRotation([180,180,180]).

fewestRotationsSingle(Maze,[180,180,180]):-
  loadModule.


bfSearch(From,From,[From]).
bfSearch(From,To,[From|Result]):-
    length(Result,ResultLength),
    % writeln(ResultLength),
    ResultLength =< 6,
    edge(From,Anything),

    % do the rotation and move
    bfSearch(Anything,To,Result).


% use up rotation array
processRotationList(Maze,[Hr|Tr], R):-
  % rotate the maze based on head of ratation list
  chooseRotation(Maze,Hr,RoMaze),
  % rotate counter cc to make columns rows
  chooseRotation(RoMaze,cc,CCMaze),
  % move all playes
  movePlayers(CCMaze,MoMaze),
  % rotate c to get the maze correctly oriented
  chooseRotation(MoMaze,c,CMaze),
  % Check for goal
  flatten(Maze,FlatMaze),
  goalCheck(FlatMaze),
  % process rest of rotation list
  processRotationList(CMaze,Tr, R).

%Goal no longer exists, we out.
processRotationList(Maze,[], Maze):- !.



processRotation(Maze,Rotation,R):-




% does a goal exist in maze?
goalCheck([He|_]):-
  goal(He),
  !.

goalCheck([_|Ta]):-
  goalCheck(Ta).



% Move all players in a list of lists
movePlayers([],[]).
movePlayers([Row|Rows],R):-
  movePlayerInRow(Row,NewR),
  List = [NewR],
  movePlayers(Rows,NewRs),
  append(List,NewRs,R),
  !.
movePlayers(R,R).

% Move all players in a row
movePlayerInRow(Row,R):-
    swapHeadMiddle(Row,SwappedRow),
    !,
    movePlayerInRow(SwappedRow,R).
movePlayerInRow(Row,Row).

% Swap x and y if x is a player and y is a valid space
swapHeadMiddle([He,Mi|R],[-,He|R]):-
    player(He),
    goal(Mi),
    !.
swapHeadMiddle([He,Mi|R],[Mi,He|R]):-
    player(He),
    forward(Mi),
    !.
swapHeadMiddle([He|R],[He|R1]):-
    swapHeadMiddle(R,R1).


chooseRotation(Maze,Rotation,RMaze):-
  (Rotation == c,
  rotateClockWise(Maze,RMaze),!);

  (Rotation == cc,
  rotateCounterClockWise(Maze,RMaze),!);

  (Rotation == 180,
  rotateOneEighty(Maze,RMaze),!).





% rotate c
rotateClockWise(Maze,R):-
  reverse(Maze,RMaze),
  clpfd:transpose(RMaze,R).
  % transpose(RMaze,R).

% rotate cc
rotateCounterClockWise(Maze,R):-
  clpfd:transpose(Maze,TMaze),
  reverse(TMaze,R).

% rotate 180
rotateOneEighty(Maze,R):-
  rotateClockWise(Maze,R1),
  rotateClockWise(R1,R).
