%13.
remU([_], []):-!.
remU([X|Xs], [X|Lu]) :- remU(Xs, Lu).

%14.
remU1(L, Lu) :-
    append(Lu, [U], L).

%15.
contiguos([X, X|_]):-!.
contiguos([X|Xs]) :-
    contiguos(Xs).
contiguos1(L):-
    append(_, [X, X|_], L).

%16.
% duplicados([a,b,c,d,b])
duplicados([X|Xs]):-
    member(X, Xs), !.
duplicados([_|Xs]):-
    duplicados(Xs).

%17.
% trocaPU([a,b,c], X).
trocaPU(Lpu, Lup): -
    append([P|M], [U], Lpu),
    append([U|M], [P], Lup)

%18.
remDupl([X|Xs], Xd):-
    member(X, Xs),
    remDupl(Xs, Xd).
remDupl([X, Xs], [X|Xd]):-
    remDupl(Xs, Xd).
remDupl([], []).

%19.
% remDupl1([a,b,a], X).
remDupl1([X|Xs], [X|Xd]):-
    member(X,Xs),
    select(X, Xs, Xd),
    remDupl1(Xs, Xd).
remDupl1([X|Xs], [X|Xd]):-
    remDupl2(Xs, Xd).
remDupl1([], []).


%20.
remove(X, [X|Xs], Xr):-
    remove(X, Xs, Xr).
remove(X, [Y,Xs], [Y|Xr]):-
    X\=Y,
    remove(X, Xs, Xr).
remove(X, [], []).

%21.
% flatten1([1,[2], [], [2,[3,4], 5], 6], X).
flatten1([], []).
flatten1(X, [X]):-
    -X\=[], X\=[_|_].
flatten1([X, Xs], F):-
    flatten1(X, F1),
    flatten1(Xs, F2),
    append(F1, F2, F).

%22.
% zipper([a,b,c,d], [1,2,3,4], X).
zipper([X|Xs], [Y|Ys], [X-Y|XYs]):-
    zipper(Xs, Ys, XYs).
zipper([], [], []).

%23.
% permutation([a,b,c], P).
permutation(Xs, [Z|Zs]):-
    select(Z, Xs, Ys),
    permutation(Ys Zs).
permutation([], []).

%24.
% reverse2([a,b,c,d], X).
reverse2(L, [], R).
reverse2([], R, R).
reverse2([X|Xs], ACC, R):-
    reverse2(Xs, [X|ACC], R).