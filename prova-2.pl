/*
vim :set syntax=prolog
*/

compAcc(L,C):- compr3(L,0,C).
compr3([_|Xs],Acc,C):-compr3(Xs,Acc+1,C).
compr3([],Acc,C):- C = Acc.

sum([], 0).
sum([X|Xs], S + X):- sum(Xs,S).

sumAcc(L,S):-sum3(L,0,S).
sum3([X|Xs], Acc, S):- sum3(Xs,Acc+X,S).
sum3([], Acc, S):- S = Acc.

membro(X,[X|_]).
membro(X,[_|Xs]):- membro(X,Xs).

append([],Bs,Bs).
append([A|As],Bs,[A|AsBs]):-append(As,Bs,AsBs).

membro2(X,L):- append(_,[X|_],L).

prefix(P,L):-append(P,_,L).

sufix(S,L):- append(_,S,L).

sublist(S,L):- prefix(P,L), sufix(S,P).

select1(X,[X|Xs],Xs).
select1(X,[Y|Xs],[Y|Zs]) :- select1(X,Xs,Zs).

max1(X,Y,X) :- X > Y,!.
max1(_,Y,Y).

ultimo1([U],U) :- !.
ultimo1([_|Xs],U) :- ultimo1(Xs,U).

ultimo2(L,U) :- append(_,[U|[]],L),!.

%12
% Simplificacação do predicado remU/2, para não retornar false, fazendo os
% cortes necessários.
remU(L,Lu) :- L = [_|Xs], Xs = [], Lu = [].
remU(L,Lu) :- L = [X|Xs], Xs \= [], Lu = [X|Xu], remU(Xs,Xu).

remU2([_],[]) :- !.
remU2([X|Xs],[X|Xu]) :- remU2(Xs,Xu).

%13.
% Predicado remU/2 com recursividade.
remUa(L,Lu) :-
  append(Lu,[_],L), !.

%14.
% Define o predicado contiguos/1, que testa se uma lista tem elementos contiguos
% repetidos. Versão recursiva.
% contiguos ([a,b,c,c,e]). Yes
contiguous([X,X|_]) :- !.
contiguous([_|Xs]) :-
  contiguous(Xs).

%15.
% A mesma coisa da questão anterior. Mas, agora usando append.
contiguous1(L) :-
  append(_,[X,X|_],L), !.

%16.
% Testa se uma lista possuí elementos duplicados. Utilizando member e
% recursividade.
% duplicados([a,b,c,d,b])
duplicados([X|Xs]):-
    member(X, Xs), !.
duplicados([_|Xs]):-
    duplicados(Xs).

%17.
% Utilizando append, troque as posições entre o primeiro e o último elemento.
% trocaPU([a,b,c], X).
trocaPU(Lpu, Lup):-
    append([P|M], [U], Lpu),
    append([U|M], [P], Lup).

%18.
% Utilizando member e recursividade, remova os ELEMENTOS DUPLICADOS INICIAIS de
% uma lista e retorne apenas os elementos restantes.
remDupl([X|Xs], Xd):-
    member(X, Xs),
    remDupl(Xs, Xd).
remDupl([X, Xs], [X|Xd]):-
    remDupl(Xs, Xd).
remDupl([], []).

%19.
% A mesma coisa da questão anterior, mas agora removendo os ELEMENTOS FINAIS. 
% remDupl1([a,b,a], X).
remDupl1([X|Xs], [X|Xd]):-
    member(X,Xs),
    select(X, Xs, Xd),
    remDupl1(Xs, Xd).
remDupl1([X|Xs], [X|Xd]):-
    remDupl1(Xs, Xd).
remDupl1([], []).


%20.
% Predicado para remover apenas as ocorrências de um determinado elemento.
% remove(a,[a,b,a,d,x,a], X).
% X=[b,d,x]
remove(_, [], []).
remove(X, [X|Xs], Xr):-
    remove(X, Xs, Xr).
remove(X, [Y,Xs], [Y|Xr]):-
    X\=Y,
    remove(X, Xs, Xr).

%21.
% A partir de uma lista aninhada, retorna uma lista simples. Mantendo a mesma
% ordem dos elementos.
% flatten1([1,[2], [], [2,[3,4], 5], 6], X).
% X=[1, 2, 2, 3, 4, 5, 6]
flatten1([], []).
flatten1(X, [X]):-
    X\=[],
    X\=[_|_].
flatten1([X, Xs], F):-
    flatten1(X, F1),
    flatten1(Xs, F2),
    append(F1, F2, F).

%22.
% Realiza a operação de zip a partir de duas listas.
% zipper([a,b,c,d], [1,2,3,4], X).
% X=[a-1, b-2, c-3, d-4]
zipper([], [], []).
zipper([X|Xs], [Y|Ys], [X-Y|XYs]):-
    zipper(Xs, Ys, XYs).

%--------------------------- TRABALHANDO COM ORDENS ----------------------------


%23.
% Predicado que retona todas as possibilidades de permutação entre os elementos
% de uma lista.
/*
?- permutation([a,b,c],P).
P = [a, b, c] ;
P = [a, c, b] ;
P = [b, a, c] ;
P = [b, c, a] ;
P = [c, a, b] ;
P = [c, b, a] ;
false.
*/
permutation([], []).
permutation(Xs, [Z|Zs]):-
  select(Z, Xs, Ys),
  permutation(Ys, Zs).

%24.
% Retorna uma lista na ordem inversa. 
/*
?- reverse([a,b,c,d], X).
R = [d,c,b,a]
*/
reverse(L,R) :-
  reverse(L,[],R).
reverse([], R,R).
reverse([X|Xs],ACC,R) :-
  reverse(Xs,[X|ACC],R).

%25
% Predicado reverse sem acumulador, usando append.
/*
?- rev([a,b,c], R).
R = [c,b,a]
*/
rev([],[]).
rev([X|Xs],R):-
  rev(Xs,Xr),
  append(Xr,[X],R).

%26
% Predicado para retornar, em booleano, se uma lista é palindrome ou não. Versão
% recursiva sem usar reverse.
/*
?- palindrome([a,b,a]).
true ;
*/
palindrome([_]).
palindrome(L):-
    append([P|M], [U], L),
    P=U,
    palindrome(M).

%27.
% A mesma coisa da questão anterior, mas Utilizando reverse e sem recursão.
% palindrome1([a,b,c,c,b,a])
palindrome1(X):-
    reverse(X, Xr),
    X=Xr.

%28
% Predicado para identificar se as duas metades de uma lista são iguais.
% metadesiguais([a,b,c,a,b,c])
metadesiguais(L):-
    append(M, M, L).

%29
% Retorna todos os subcojuntos de um conjunto.
/*
?- subConjunto(X,[a,b,c]).
X = [a, b, c] ;
X = [a, b] ;
X = [a, c, b] ;
X = [a, c] ;
X = [a] ;
X = [b, a, c] ;
X = [b, a] ;
X = [b, c, a] ;
X = [b, c] ;
X = [b] ;
X = [c, a, b] ;
X = [c, a] ;
X = [c, b, a] ;
X = [c, b] ;
X = [c] ;
X = [].
*/
subConjunto([X|Xs], Y):-
  select(X, Y, Ys),
  subConjunto(Xs, Ys).
subConjunto([],_). 

%30.
% Interseção entre dois conjuntos.
% intersecao([b,c,d], [d,a,b,c,k], I).
intersecao([],X,[]).
intersecao([X|Xs],Y,[X|Is]):- member(X,Y), intersecao(Xs,Y,Is).
intersecao([X|Xs],Y, Is):- \+ member(X,Y), intersecao(Xs,Y,Is). 

%31
% União entre dois conjuntos.
% uniao([b,c,d], [d,a,b,c,k], I).
uniao([X|Xs], Y, [X|Us]):-
    \+ member(X, Y),
    uniao(Xs, Y, Us).
uniao([X|Xs], Y, Us):-
    member(X, Y),
    uniao(Xs, Y, Us).
uniao([], Y, Y).

%----------------------------- ORDEM ALFANUMÉRICA ------------------------------
%32
% Retornar, em booleano, se uma lista já esta ordenada.
/*
?- isOrdered([1,5,5,11]).
*/
isOrdered([]).
isOrdered([_]).
isOrdered([X,Y|XYs]) :-
  X =< Y,
  isOrdered([Y|XYs]).

%33
% Sem usar acumulador, retornar o valor máximo de uma lista, com valores
% númericos.
/*
?- maxL([2,6,1,20,4],M).
*/
maxL([X],X) :- !.
maxL([X|Xs],X) :-
  maxL(Xs,M),
  X > M.
maxL([X|Xs],M) :-
  maxL(Xs,M),
  X =< M.

%34
% A mesma coisa que a questão anterior, mas agora USANDO ACUMULADOR. Inicialize
% o acumulador com a cabeça da lista.
/*
?- maxLacc([2,6,1,20,4],M).
*/
maxLacc([X|Xs],M) :-
  maxL3(Xs,X,M).
maxL3([],ACC,M) :-
  M = ACC.
maxL3([X|Xs],ACC,M) :-
  X >= ACC,
  maxL3(Xs,X,M).
maxL3([X|Xs],ACC,M) :-
  X < ACC,
  maxL3(Xs,ACC,M).

%35
% Utilizando os predicados, isOrdered e permutation. A partir de uma lista,
% retorne uma nova com todos os valores ordenados.
%?- sortx([1,11,5,2],X).
sortx(L,S) :-
  permutation(L,S),
  isOrdered(S).

%36
% Insere um elemento em uma lista e a mantém ordenada.
/*
?- insOrd(4,[2,3,5,7],L).
*/
insOrd(X,[],[X]).
insOrd(X,[Y|Ys],[X,Y|Ys]) :-
  X < Y.
insOrd(X,[Y|Ys],[Y|XYs]) :-
  X >= Y,
  insOrd(X,Ys,XYs).


%--------------------------- Auxiliares para testes ----------------------------

gL(L,N) :- findall(X,(between(1,N,_), X is random(1000)),L).

% Gera uma lista com valores aleatórios.
/*
?- gL(L, 7).
L = [895, 279, 815, 788, 29, 407, 863].
*/

% Mede o tamanho de uma lista gerada.
/*
?- gL(L,100),length(L,Len).
L = [238, 14, 609, 97, 464, 66, 172, 145, 864|...],
Len = 100.
*/

% Gerar um range de valores.
/*
?- between(1,5,N).
N = 1 ;
N = 2 ;
N = 3 ;
N = 4 ;
N = 5.
*/

% Medir tempo de execução de um sort, e avaliar o tamanho da lista de retorno.
/*
?- gL(L,10),time(sort(L,S)),length(S,Len).
% 1 inferences, 0.000 CPU in 0.000 seconds (?% CPU, Infinite Lips)
L = [112, 806, 260, 693, 264, 306, 571, 793, 198|...],
S = [32, 112, 198, 260, 264, 306, 571, 693, 793|...],
Len = 10.
*/

% Conseguir 10 últimos elementos de uma lista
/*
?- gL(L,100), getL(10,L,Lo).
L = [316, 612, 506, 676, 322, 500, 246, 836, 856|...],
Lo = [821, 604, 365, 255, 317, 292, 943, 897, 413|...] 
*/
getL(N,L,Lo) :- length(Lo,N), append(_,Lo,L).

%37
% Detecta se uma lista de caracteres JÁ ESTA ORDENADA. Com a diferença que
% incluí caracteres, ao invés da versão anterior só com números.
insOrd2(X,[],[X]).
insOrd2(X,[Y|Ys],[X,Y|Ys]):- X@<Y. 
insOrd2(X,[Y|Ys],[Y|XYs]) :-
  X@>=Y,
  insOrd2(X,Ys,XYs).

/*
?- insOrd2(c,[a,b,d,e],L).
L = [a, b, c, d, e] .
*/

%38
% Insersor direto. Insere elementos a partir de uma lista vazia, mantendo-os
% ordenados.
/*
?- insDir([1,11,5,2],X).
X = [1, 2, 5, 11] .
*/
insDir([X|Xs],Lo) :-
  insDir3(Xs,[X],Lo).
insDir3([X|Xs],ACC,Lo) :-
  insOrd(X,ACC,ACCx),
  insDir3(Xs,ACCx,Lo),!.
insDir3([],ACC,Lo) :-
  Lo = ACC.

%39
% Particiona uma lista em duas partes iguais, quando possível. Quando a
% quatidade de elementos na lista for ímpar, um dos lados terá um elemento e
% mais. 
/*
?- particiona([a,b,c,1,2,3,4],A,B).
A = [a, c, 2, 4],
B = [b, 1, 3] .
*/
particiona([X,Y|XYs],[X|Xs],[Y|Ys]) :-
  particiona(XYs,Xs,Ys).
particiona([X],[X],[]).
particiona([],[],[]). 

%40
% Junta duas listas ordenadas, mantendo a ordem.
/*
?- merge1([a,b,b,k,z], [c,m,n,o], X).
X = [a, b, b, c, k, m, n, o, z].
*/
merge1([X|Xs],[Y|Ys],[X|XYs]) :-
  X@<Y,!,
  merge1(Xs, [Y|Ys],XYs).
merge1([X|Xs],[Y|Ys],[Y|XYs]) :-
  X@>=Y,!,
merge1([X|Xs], Ys,XYs).
merge1([],Ys,Ys):-!.
merge1(Xs,[],Xs):-!. 

%41
% Uma forma de implementar o merge sort. Utilizando os predicados, particiona e
% merge1.
/*
?- mergeSort([1,11,5,2], X).
X = [1, 2, 5, 11] .
*/
mergeSort([],[]):-!.
mergeSort([X],[X]):-!.
mergeSort(L,S) :-
  particiona(L,X,Y),
  mergeSort(X,Xo),
  mergeSort(Y,Yo),
  merge1(Xo,Yo,S).

%--------------------------- COMPUTAÇÃO ARITMÉTICA ----------------------------

%42
% Obtem o enezimo elemento de um conjunto(lista) passada para o predicado.
/*
?- enezimo(3,[a,b,c,d], X). 
X = c .
*/
enezimo(N,[X|_],X) :-
  N =< 1.
enezimo(N,[_|Xs],Y) :-
  N > 1,
  N1 is (N-1),
  enezimo(N1,Xs,Y). 
