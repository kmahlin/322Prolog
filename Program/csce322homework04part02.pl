% working_directory(CWD,'c:/users/kevin/documents/github/322Prolog/Program').
% consult('csce322homework04part01.pl').
% [homework04tests].
% [helpers].
% [csce322homework04part02].


fewestRotationsSingle(Maze,R):-
  loadModule,
  removeEndOfFile(Maze,ModMaze),
  solvedPaths(ModMaze,R).
