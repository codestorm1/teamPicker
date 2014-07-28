:- use_module(library(clpfd)).

nondev(juan).
nondev(dana).
nondev(joelle).
nondev(bobby).
nondev(josh).
nondev(nick).
nondev(krishna).
nondev(emily).
nondev(diana).
nondev(rick).

dev(bryan).
dev(bill).
dev(brad).
dev(tim).
dev(angello).
dev(jimmy).
dev(evan).
dev(pawan).

blocked(juan, dana).
blocked(juan, emily).
blocked(dana, emily).

blocked(joelle, josh).
blocked(joelle, nick).
blocked(joelle, diana).
blocked(josh, nick).
blocked(josh, diana).
blocked(nick, diana).

blocked(bryan, bill).
blocked(bryan, tim).

blocked(angello, brad).

blocked(bobby, nick).
blocked(bobby, jimmy).

people(People) :- findall(X, (dev(X) ; nondev(X)), People).
alldevs(Devs) :-  findall(X, dev(X), Devs).
allnondevs(Nondevs) :-  findall(X, nondev(X), Nondevs).

valid_team_of_three((X, Y, Z)) :- 
	dev(X), nondev(Y), (dev(Z) ; nondev(Z)),
	X \= Y, X \=Z, Y \=Z,
	\+(blocked(X, Y)), \+(blocked(X, Z)), \+(blocked(Y, Z)).

valid_team_of_four((W, X, Y, Z)) :- 
	dev(X), nondev(Y), (dev(Z) ; nondev(Z)), (dev(W) ; nondev(W)),
	X \=Z, Y \=Z, X \=W, Y \=W, W \=Z,
	\+(blocked(X, Y)), \+(blocked(X, Z)), \+(blocked(Y, Z)),
	\+(blocked(X, W)), \+(blocked(Y, W)), \+(blocked(Z, W)).
				
valid_teams([]).
valid_teams([Head|Tail]) :-
	write(Head),
	(valid_team_of_three(Head) ; valid_team_of_four(Head)),
	valid_teams(Tail).
	
on_team(Player, (X, Y, Z)) :-
	Player = X; Player = Y; Player = Z.

on_team(Player, (W, X, Y, Z)) :-
	Player = W; Player = X; Player = Y; Player = Z.
	
on_a_team(Player, [Head|Tail]) :-
	on_team(Player, Head) ;	
	on_a_team(Player, Tail).
	
players_on_teams([], _).
players_on_teams([Head|Tail], Teams) :-
    on_a_team(Head, Teams),
	players_on_teams(Tail, Teams).
	
	
everyone_plays(Teams) :-
	findall(X, (dev(X) ; nondev(X)), Players),
%	write(Players),
	players_on_teams(Players, Teams).

valid_teams_and_size(List) :-
%	flatten(X, List),
%	all_different(X), % player can't be on two teams'
%	findall(X, (dev(X) ; nondev(X)), People),
%	length(People, Length),

length(List, 6),
valid_teams(List).
%everyone_plays(List).
%	length(List, div(18, 3)), % prefer teams of three over teams of four

