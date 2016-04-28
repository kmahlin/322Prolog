:- dynamic paths/2,
  inGoal/2,

	module( helpers,
	 [ readGravityMazeFile/3
	 , printMazeGame/1

	 ,countMovesInList/2
	 ,countPlayerInMaze/2

	 , loadModule/0
	 , removeEndOfFile/2
	 , solvedPaths/2
	 , shortestSolvedPaths/2


	 ,isStacked/2
	 ]
    ).


readGravityMazeFile(File,Moves,Maze):-
    open(File,read,Input),
    read(Input,Moves),
    readMaze(Input,Maze),
    close(Input).

readMaze(Input,[]):-
    at_end_of_stream(Input),
    !.
readMaze(Input,[Row|Rows]):-
    \+ at_end_of_stream(Input),
    read(Input,Row),
    readMaze(Input,Rows).

printMazeGame([]).
printMazeGame([Row|Rows]):-
    writeln(Row),
    printMazeGame(Rows).


% does end of file exist in the maze variable
endOfFile(end_of_file).

% solved paths
paths([180,180,180],false).

% all edges for BFsearch
edge(c,c).
edge(c,cc).
edge(c,180).

edge(cc,c).
edge(cc,cc).
edge(cc,180).

edge(180,c).
edge(180,cc).
edge(180,180).

% a value that a player can move into
forward(-).

% goal value in maze
goal(g).

% at the start of game, no players are in goal
inGoal(1,false).
inGoal(2,false).
inGoal(3,false).
inGoal(4,false).

% possible players in game
player(1).
player(2).
player(3).
player(4).

% all possible moves
move(c).
move(cc).
move(180).

% Known unSolvable paths
unSolvable([180,180,180]).
unSolvable([180,180,180,180]).
unSolvable([180,180,180,180,180]).
unSolvable([180,180,180,180,180,180]).


% part 1 predicates
countMovesInList([],0):- !.
countMovesInList([HE|TA],R):-
  not(move(HE)),
  countMovesInList(TA,R).

countMovesInList([_|TA],R):-
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

countPlayersInList([_|TA],R):-
  countPlayersInList(TA,R2),
  R is R2 + 1.


% part 02 03 predicates

loadModule:-
  use_module(library(clpfd), []).


% remove 'end of file' from maze
removeEndOfFile(Maze,R):-
  reverse(Maze,[H|RMazeTail]),
  endOfFile(H),
  reverse(RMazeTail,CorrectedMaze),
  R = CorrectedMaze,
  !.
removeEndOfFile(Maze,Maze).


% NOTE: collect all sol for bfsearch
% findall(Path,bfSearch(From,To,Path),X) ; true.
% findall(Path,helpers:bfSearch(From,To,Path),X) ; true.

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


shortestSolvedPaths(Maze,R):-
	solvedPaths(Maze,Paths),
  shortestPaths(Paths,R).


shortestPaths([Path|Paths],R):-
	length(Path,ShortestPathLength),
	findAllPathsOfLength(ShortestPathLength,[Path|Paths]).


% loadHelpers.
% helpers:findAllPathsOfLength(4,[[c,cc,c,c],[cc,c,c,cc],[180,180,c,c]],R).
% sort through all solved paths and find the all of length len

findAllPathsOfLength(_,[]).
findAllPathsOfLength(Len,[Path|Paths]):-
	length(Path,PathLength),
	PathLength == Len,
	findAllPathsOfLength(Len,Paths),
	 asserta(paths(Path,true)).

findAllPathsOfLength(Len,[_|Paths]):-
	findAllPathsOfLength(Len,Paths),
	!.



% get all paths from BFS serach, and return a list of
% paths that solve the maze
solvedPaths(Maze,R):-
  % Do bfSearch
  % bfSearch(From, To,BFSList),
  findall(Paths,bfSearch(From,To,Paths),AllPaths),
	% add [c],[cc],[180] as possible paths - bandaid, I know =/
  addPaths(AllPaths,AllPathsMod),
  % Find all palths
  processBFSLists(Maze,AllPathsMod,R).

% bandaid fix, for some reason these aren't in the
% bfs searched paths
addPaths(Paths,R):-
	append([[180]],Paths,R1),
	append([[cc]],R1,R2),
	append([[c]],R2,R).



% Process each path to see if it solves the maze
% retrun a list of solved paths.
processBFSLists(_,[],[]).
processBFSLists(Maze,[Rlist|Rlists],R):-
  (
    solvable(Maze,Rlist)
    ->
      % writeln(blah),
      R = [Rlist|R2],
      processBFSLists(Maze,Rlists,R2)
    ;
      processBFSLists(Maze,Rlists,R)
  ).




% this just checks if a single list of rotations
% Solve the Maze
solvable(Maze,RList):-
  %something for keeping out 180 180 180
  not(unSolvable(RList)),
  %Process Rotation list
  processRotationList(Maze,RList,RMaze),
  % Check for goal
  not(goalExists(RMaze)),
	resetPlayerInGoal.

resetPlayerInGoal:-
	inGoal(Player,true),
	retract(inGoal(Player,true)),
	asserta(inGoal(Player,false)).

% use up rotation list
% return the rotated maze
processRotationList(Maze,[Hr|Tr], R):-
  % do one rotation
  processRotation(Maze,Hr,ProcMaze),
  % check if goal still exists
  goalExists(Maze),
  % if it does, process the rest of the list
  processRotationList(ProcMaze,Tr, R),
  !.

%Goal no longer exists, we out.
processRotationList(Maze,_, Maze):- !.


% 1)This predicate rotates the maze
% 2)then rotates the maze CC in order to turn Cols into rows
% 3)moves the payers forward
% 4)then rotates the maze c to properly orient the maze
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
		asserta(inGoal(He,true)),
		retract(inGoal(He,false)),
    !.
swapHeadMiddle([He,Mi|R],[Mi,He|R]):-
    player(He),
		not(inGoal(He,true)),
    forward(Mi),
    !.
swapHeadMiddle([He|R],[He|R1]):-
    swapHeadMiddle(R,R1).


% rotate the maze based on move() choice
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


% % part 04 specific predicates
% % also uses part 02/3 predicates for rotation and Moves
isStacked(Maze,Rotation):-
	% do all rotations in move
	processRotation(Maze,Rotation,RMaze),
	rotateCounterClockWise(RMaze,CCMaze),
	stackExists(CCMaze).



%Check if a stack of players exist in the maze
stackExists(Maze):-
	flatten(Maze,FlatMaze),
  stackedCheck(FlatMaze).

stackedCheck([He,Mi|_]):-
	player(He),
	player(Mi),
	!.
stackedCheck([_|Ta]):-
	stackedCheck(Ta).
