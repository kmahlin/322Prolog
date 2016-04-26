% working_directory(CWD,'c:/users/kevin/documents/github/322Prolog/Program').
% consult('csce322homework04part01.pl').
% [homework04tests].
% [helpers].
% [csce322homework04part02].

loadModule:-
  use_module(library(clpfd), []).


edge(c,c).
edge(c,cc).
edge(c,180).

edge(cc,c).
edge(cc,cc).
edge(cc,180).

edge(180,c).
edge(180,cc).
edge(180,180).



move(c).
move(cc).
move(180).

forward(-).
goal(g).

player(1).
player(2).

unSolvable([180,180,180]).
unSolvable([c,c,c,c]).
unSolvable([cc,cc,cc,cc]).

fewestRotationsSingle(Maze,[180,180,180]):-
  loadModule.



  % collect all sol for bfsearch
  % findall(Path,bfSearch(From,To,Path),X) ; true.

  % bfSearch(From,To,Path).  <- use this to call it
  % Searches for a list of possible rotations
  bfSearch(From,From,[From]).
  bfSearch(From,To,[From|Result]):-
    length(Result,ResultLength),

    ( ResultLength < 6 ->
      % writeln(ResultLength),
      edge(From,Anything),
      %  write([From|Result]),
      bfSearch(Anything,To,Result)
      ;
      !
    ).







solvedPaths(Maze,R):-
  % Do bfSearch
  bfSearch(From, To,BFSList),

  % Find all palths
  processBFSLists(Maze,BFSList,R).


  % findall(
  %   SolvablePaths,
  %   % Take list and see if solvable
  %   processBFSLists(Maze,BFSList,SolvablePaths),
  %   R
  % ).

  % Collect list of possible solved mazes







  % Move all players in a list of lists
  % movePlayers([],[]).
  % movePlayers([Row|Rows],R):-
  %   movePlayerInRow(Row,NewR),
  %   List = [NewR],
  %   movePlayers(Rows,NewRs),
  %   append(List,NewRs,R),
  %   !.
  % movePlayers(R,R).




% processBFSLists(_,[],_).
% processBFSLists(Maze,[Rlist|Rlists],R):-
%   solvable(Maze,Rlist),
%   List = [Rlist],
%   processBFSLists(Maze,Rlists,NewLists),
%   append(List,NewLists,R),
%   !.
  % processBFSLists(_,[Rlist|Rlists],Rlists).
% processBFSLists(_,[Rlist|Rlists],Rlists).

% processBFSLists(_,[],[]).
% processBFSLists(Maze,[Rlist|Rlists],R):-
%   % solveable?
%   solvable(Maze,Rlist),
%   %Process rest of list
%   processBFSLists(Maze,Rlists,R2),
%   append([Rlist],[R2],R).
% processBFSLists(Maze,[_|Rlists],R):-
%   processBFSLists(Maze,Rlists,R).

% does too many nested lists
% processBFSLists(_,[],[]).
% processBFSLists(Maze,[Rlist|Rlists],R):-
%   % solveable?
%   not(solvable(Maze,Rlist)),
%   %Process rest of list
%   processBFSLists(Maze,Rlists,R),!.
%
% processBFSLists(Maze,[Rlist|Rlists],R):-
%   processBFSLists(Maze,Rlists,R2),
%   append([Rlist],[R2],R).



processBFSLists(_,[],[]).
processBFSLists(Maze,[Rlist|Rlists],R):-
  % solveable?
  not(solvable(Maze,Rlist)),
  %Process rest of list
  processBFSLists(Maze,Rlists,R),!.

processBFSLists(Maze,[Rlist|Rlists],R):-
  processBFSLists(Maze,Rlists,R2),
  append([Rlist],R2,R).






% this just checks if a single list of rotations
% Solve the Maze
% I need to return a list if it works
solvable(Maze,RList):-
  %something for keeping out 180 180 180
  not(unSolvable(RList)),
  %Process Rotation list
  processRotationList(Maze,RList,RMaze),
  % Check for goal
  not(goalExists(RMaze)).


% use up rotation array
% return the rotated maze
%Goal no longer exists, we out.
processRotationList(Maze,[Hr|Tr], R):-
  % do one rotation
  processRotation(Maze,Hr,ProcMaze),
  % check if goal still exists
  goalExists(Maze),
  % if it does, process the rest of the list
  processRotationList(ProcMaze,Tr, R),
  !.

processRotationList(Maze,_, Maze):- !.

%Goal no longer exists, we out.
% processRotationList(Maze,[], Maze):- !.


processRotation(Maze,Rotation,R):-
  % rotate the maze based on head of ratation list
  chooseRotation(Maze,Rotation,RoMaze),
  % rotate counter cc to make columns rows
  chooseRotation(RoMaze,cc,CCMaze),
  % move all playes
  movePlayers(CCMaze,MoMaze),
  % rotate c to get the maze correctly oriented
  chooseRotation(MoMaze,c,R).



% does a goal exist in maze?
goalExists(Maze):-
  flatten(Maze,FlatMaze),
  goalCheck(FlatMaze).

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
